import asyncio
import logging

import grpc
import samples.greeter_pb2 as greeter_pb2  # noqa: E402, E501

logger = logging.getLogger(__name__)

# Bidirection is not thread-safe TAXICOMMON-6729
CASES_WITHOUT_INDEPT_STREAMS = [
    'say_hello',
    'say_hello_response_stream',
    'say_hello_request_stream',
    'say_hello_streams',
]

ALL_CASES = CASES_WITHOUT_INDEPT_STREAMS + ['say_hello_indept_streams']

COUNT_TRYING = 5


async def _say_hello(grpc_client, gate):
    request = greeter_pb2.GreetingRequest(name='Python')
    response = await grpc_client.SayHello(request)
    assert response.greeting == 'Hello, Python!'
    assert gate.connections_count() > 0


async def _say_hello_response_stream(grpc_client, gate):
    request = greeter_pb2.GreetingRequest(name='Python')
    reference = '!'
    async for response in grpc_client.SayHelloResponseStream(request):
        assert response.greeting == f'Hello, Python{reference}'
        reference += '!'
    assert gate.connections_count() > 0


async def _prepare_requests(names, sleep=1):
    reqs = []
    for name in names:
        reqs.append(greeter_pb2.GreetingRequest(name=name))
    for req in reqs:
        await asyncio.sleep(sleep)
        yield req


async def _say_hello_request_stream(grpc_client, gate):

    stream = await grpc_client.SayHelloRequestStream(
        _prepare_requests(['Python', '!', '!', '!'], 1),
    )
    assert stream.greeting == 'Hello, Python!!!'
    assert gate.connections_count() > 0


async def _say_hello_streams(grpc_client, gate):
    reference = ''
    async for response in grpc_client.SayHelloStreams(
            _prepare_requests(['Python', '!', '!', '!'], 1),
    ):
        assert response.greeting == f'Hello, Python{reference}'
        reference += '!'
    assert gate.connections_count() > 0


async def _say_hello_indept_streams(grpc_client, gate):
    expected_responses = [
        'Hello, Python',
        'Hello, C++',
        'Hello, linux',
        'Hello, userver',
        'Hello, grpc',
        'Hello, kernel',
        'Hello, developer',
        'Hello, core',
        'Hello, anonim',
        'Hello, user',
        'If this message has arrived, then everything works',
    ]

    index = 0
    async for response in grpc_client.SayHelloIndependentStreams(
            _prepare_requests(
                [
                    'If',
                    ' ',
                    'this',
                    ' ',
                    'message',
                    ' ',
                    'has',
                    ' ',
                    'arrived,',
                    ' ',
                    'then',
                    ' ',
                    'everything',
                    ' ',
                    'works',
                ],
                0.1,
            ),
    ):
        assert response.greeting == expected_responses[index]
        index += 1
    assert gate.connections_count() > 0


_REQUESTS = {
    'say_hello': _say_hello,
    'say_hello_response_stream': _say_hello_response_stream,
    'say_hello_request_stream': _say_hello_request_stream,
    'say_hello_streams': _say_hello_streams,
    'say_hello_indept_streams': _say_hello_indept_streams,
}


async def check_ok_for(case, grpc_client, gate):
    for i in range(COUNT_TRYING):
        try:
            await _REQUESTS[case](grpc_client, gate)
            logging.info(f'Request {case} OK, by trying: {i}')
            return
        except grpc.RpcError as error:
            logger.warning(
                f'Error request {case}, by trying {i}: {error.code()}'
            )
        await asyncio.sleep(0.5)
    assert False, f'{case}: all attempts failed'


async def check_unavailable_for(case, grpc_client, gate):
    try:
        await _REQUESTS[case](grpc_client, gate)
        assert False, 'Server must be return UNAVAILABLE'
    except grpc.RpcError as error:
        assert grpc.StatusCode.UNAVAILABLE == error.code()


async def close_connection(gate):
    gate.to_server_pass()
    gate.to_client_pass()
    gate.start_accepting()
    await gate.sockets_close()
