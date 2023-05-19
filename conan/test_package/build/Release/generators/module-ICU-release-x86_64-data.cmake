########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

list(APPEND icu_COMPONENT_NAMES ICU::data ICU::dt ICU::uc ICU::i18n ICU::in ICU::io ICU::tu ICU::test)
list(REMOVE_DUPLICATES icu_COMPONENT_NAMES)
set(icu_FIND_DEPENDENCY_NAMES "")

########### VARIABLES #######################################################################
#############################################################################################
set(icu_PACKAGE_FOLDER_RELEASE "/Users/alexiprof/.conan/data/icu/72.1/_/_/package/f377eb916255bfd558ed1b3ba2eb6e71aad6301e")
set(icu_BUILD_MODULES_PATHS_RELEASE )


set(icu_INCLUDE_DIRS_RELEASE "${icu_PACKAGE_FOLDER_RELEASE}/include")
set(icu_RES_DIRS_RELEASE "${icu_PACKAGE_FOLDER_RELEASE}/res")
set(icu_DEFINITIONS_RELEASE "-DU_STATIC_IMPLEMENTATION")
set(icu_SHARED_LINK_FLAGS_RELEASE )
set(icu_EXE_LINK_FLAGS_RELEASE )
set(icu_OBJECTS_RELEASE )
set(icu_COMPILE_DEFINITIONS_RELEASE "U_STATIC_IMPLEMENTATION")
set(icu_COMPILE_OPTIONS_C_RELEASE )
set(icu_COMPILE_OPTIONS_CXX_RELEASE )
set(icu_LIB_DIRS_RELEASE "${icu_PACKAGE_FOLDER_RELEASE}/lib")
set(icu_LIBS_RELEASE icutest icutu icuio icui18n icuuc icudata)
set(icu_SYSTEM_LIBS_RELEASE c++)
set(icu_FRAMEWORK_DIRS_RELEASE )
set(icu_FRAMEWORKS_RELEASE )
set(icu_BUILD_DIRS_RELEASE )

# COMPOUND VARIABLES
set(icu_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${icu_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${icu_COMPILE_OPTIONS_C_RELEASE}>")
set(icu_LINKER_FLAGS_RELEASE
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${icu_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${icu_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${icu_EXE_LINK_FLAGS_RELEASE}>")


set(icu_COMPONENTS_RELEASE ICU::data ICU::dt ICU::uc ICU::i18n ICU::in ICU::io ICU::tu ICU::test)
########### COMPONENT ICU::test VARIABLES ############################################

set(icu_ICU_test_INCLUDE_DIRS_RELEASE "${icu_PACKAGE_FOLDER_RELEASE}/include")
set(icu_ICU_test_LIB_DIRS_RELEASE "${icu_PACKAGE_FOLDER_RELEASE}/lib")
set(icu_ICU_test_RES_DIRS_RELEASE )
set(icu_ICU_test_DEFINITIONS_RELEASE )
set(icu_ICU_test_OBJECTS_RELEASE )
set(icu_ICU_test_COMPILE_DEFINITIONS_RELEASE )
set(icu_ICU_test_COMPILE_OPTIONS_C_RELEASE "")
set(icu_ICU_test_COMPILE_OPTIONS_CXX_RELEASE "")
set(icu_ICU_test_LIBS_RELEASE icutest)
set(icu_ICU_test_SYSTEM_LIBS_RELEASE )
set(icu_ICU_test_FRAMEWORK_DIRS_RELEASE )
set(icu_ICU_test_FRAMEWORKS_RELEASE )
set(icu_ICU_test_DEPENDENCIES_RELEASE ICU::tu ICU::uc)
set(icu_ICU_test_SHARED_LINK_FLAGS_RELEASE )
set(icu_ICU_test_EXE_LINK_FLAGS_RELEASE )
# COMPOUND VARIABLES
set(icu_ICU_test_LINKER_FLAGS_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${icu_ICU_test_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${icu_ICU_test_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${icu_ICU_test_EXE_LINK_FLAGS_RELEASE}>
)
set(icu_ICU_test_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${icu_ICU_test_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${icu_ICU_test_COMPILE_OPTIONS_C_RELEASE}>")
########### COMPONENT ICU::tu VARIABLES ############################################

set(icu_ICU_tu_INCLUDE_DIRS_RELEASE "${icu_PACKAGE_FOLDER_RELEASE}/include")
set(icu_ICU_tu_LIB_DIRS_RELEASE "${icu_PACKAGE_FOLDER_RELEASE}/lib")
set(icu_ICU_tu_RES_DIRS_RELEASE )
set(icu_ICU_tu_DEFINITIONS_RELEASE )
set(icu_ICU_tu_OBJECTS_RELEASE )
set(icu_ICU_tu_COMPILE_DEFINITIONS_RELEASE )
set(icu_ICU_tu_COMPILE_OPTIONS_C_RELEASE "")
set(icu_ICU_tu_COMPILE_OPTIONS_CXX_RELEASE "")
set(icu_ICU_tu_LIBS_RELEASE icutu)
set(icu_ICU_tu_SYSTEM_LIBS_RELEASE )
set(icu_ICU_tu_FRAMEWORK_DIRS_RELEASE )
set(icu_ICU_tu_FRAMEWORKS_RELEASE )
set(icu_ICU_tu_DEPENDENCIES_RELEASE ICU::i18n ICU::uc)
set(icu_ICU_tu_SHARED_LINK_FLAGS_RELEASE )
set(icu_ICU_tu_EXE_LINK_FLAGS_RELEASE )
# COMPOUND VARIABLES
set(icu_ICU_tu_LINKER_FLAGS_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${icu_ICU_tu_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${icu_ICU_tu_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${icu_ICU_tu_EXE_LINK_FLAGS_RELEASE}>
)
set(icu_ICU_tu_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${icu_ICU_tu_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${icu_ICU_tu_COMPILE_OPTIONS_C_RELEASE}>")
########### COMPONENT ICU::io VARIABLES ############################################

set(icu_ICU_io_INCLUDE_DIRS_RELEASE "${icu_PACKAGE_FOLDER_RELEASE}/include")
set(icu_ICU_io_LIB_DIRS_RELEASE "${icu_PACKAGE_FOLDER_RELEASE}/lib")
set(icu_ICU_io_RES_DIRS_RELEASE )
set(icu_ICU_io_DEFINITIONS_RELEASE )
set(icu_ICU_io_OBJECTS_RELEASE )
set(icu_ICU_io_COMPILE_DEFINITIONS_RELEASE )
set(icu_ICU_io_COMPILE_OPTIONS_C_RELEASE "")
set(icu_ICU_io_COMPILE_OPTIONS_CXX_RELEASE "")
set(icu_ICU_io_LIBS_RELEASE icuio)
set(icu_ICU_io_SYSTEM_LIBS_RELEASE )
set(icu_ICU_io_FRAMEWORK_DIRS_RELEASE )
set(icu_ICU_io_FRAMEWORKS_RELEASE )
set(icu_ICU_io_DEPENDENCIES_RELEASE ICU::i18n ICU::uc)
set(icu_ICU_io_SHARED_LINK_FLAGS_RELEASE )
set(icu_ICU_io_EXE_LINK_FLAGS_RELEASE )
# COMPOUND VARIABLES
set(icu_ICU_io_LINKER_FLAGS_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${icu_ICU_io_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${icu_ICU_io_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${icu_ICU_io_EXE_LINK_FLAGS_RELEASE}>
)
set(icu_ICU_io_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${icu_ICU_io_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${icu_ICU_io_COMPILE_OPTIONS_C_RELEASE}>")
########### COMPONENT ICU::in VARIABLES ############################################

set(icu_ICU_in_INCLUDE_DIRS_RELEASE "${icu_PACKAGE_FOLDER_RELEASE}/include")
set(icu_ICU_in_LIB_DIRS_RELEASE "${icu_PACKAGE_FOLDER_RELEASE}/lib")
set(icu_ICU_in_RES_DIRS_RELEASE )
set(icu_ICU_in_DEFINITIONS_RELEASE )
set(icu_ICU_in_OBJECTS_RELEASE )
set(icu_ICU_in_COMPILE_DEFINITIONS_RELEASE )
set(icu_ICU_in_COMPILE_OPTIONS_C_RELEASE "")
set(icu_ICU_in_COMPILE_OPTIONS_CXX_RELEASE "")
set(icu_ICU_in_LIBS_RELEASE )
set(icu_ICU_in_SYSTEM_LIBS_RELEASE )
set(icu_ICU_in_FRAMEWORK_DIRS_RELEASE )
set(icu_ICU_in_FRAMEWORKS_RELEASE )
set(icu_ICU_in_DEPENDENCIES_RELEASE ICU::i18n)
set(icu_ICU_in_SHARED_LINK_FLAGS_RELEASE )
set(icu_ICU_in_EXE_LINK_FLAGS_RELEASE )
# COMPOUND VARIABLES
set(icu_ICU_in_LINKER_FLAGS_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${icu_ICU_in_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${icu_ICU_in_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${icu_ICU_in_EXE_LINK_FLAGS_RELEASE}>
)
set(icu_ICU_in_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${icu_ICU_in_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${icu_ICU_in_COMPILE_OPTIONS_C_RELEASE}>")
########### COMPONENT ICU::i18n VARIABLES ############################################

set(icu_ICU_i18n_INCLUDE_DIRS_RELEASE "${icu_PACKAGE_FOLDER_RELEASE}/include")
set(icu_ICU_i18n_LIB_DIRS_RELEASE "${icu_PACKAGE_FOLDER_RELEASE}/lib")
set(icu_ICU_i18n_RES_DIRS_RELEASE )
set(icu_ICU_i18n_DEFINITIONS_RELEASE )
set(icu_ICU_i18n_OBJECTS_RELEASE )
set(icu_ICU_i18n_COMPILE_DEFINITIONS_RELEASE )
set(icu_ICU_i18n_COMPILE_OPTIONS_C_RELEASE "")
set(icu_ICU_i18n_COMPILE_OPTIONS_CXX_RELEASE "")
set(icu_ICU_i18n_LIBS_RELEASE icui18n)
set(icu_ICU_i18n_SYSTEM_LIBS_RELEASE )
set(icu_ICU_i18n_FRAMEWORK_DIRS_RELEASE )
set(icu_ICU_i18n_FRAMEWORKS_RELEASE )
set(icu_ICU_i18n_DEPENDENCIES_RELEASE ICU::uc)
set(icu_ICU_i18n_SHARED_LINK_FLAGS_RELEASE )
set(icu_ICU_i18n_EXE_LINK_FLAGS_RELEASE )
# COMPOUND VARIABLES
set(icu_ICU_i18n_LINKER_FLAGS_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${icu_ICU_i18n_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${icu_ICU_i18n_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${icu_ICU_i18n_EXE_LINK_FLAGS_RELEASE}>
)
set(icu_ICU_i18n_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${icu_ICU_i18n_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${icu_ICU_i18n_COMPILE_OPTIONS_C_RELEASE}>")
########### COMPONENT ICU::uc VARIABLES ############################################

set(icu_ICU_uc_INCLUDE_DIRS_RELEASE "${icu_PACKAGE_FOLDER_RELEASE}/include")
set(icu_ICU_uc_LIB_DIRS_RELEASE "${icu_PACKAGE_FOLDER_RELEASE}/lib")
set(icu_ICU_uc_RES_DIRS_RELEASE )
set(icu_ICU_uc_DEFINITIONS_RELEASE )
set(icu_ICU_uc_OBJECTS_RELEASE )
set(icu_ICU_uc_COMPILE_DEFINITIONS_RELEASE )
set(icu_ICU_uc_COMPILE_OPTIONS_C_RELEASE "")
set(icu_ICU_uc_COMPILE_OPTIONS_CXX_RELEASE "")
set(icu_ICU_uc_LIBS_RELEASE icuuc)
set(icu_ICU_uc_SYSTEM_LIBS_RELEASE )
set(icu_ICU_uc_FRAMEWORK_DIRS_RELEASE )
set(icu_ICU_uc_FRAMEWORKS_RELEASE )
set(icu_ICU_uc_DEPENDENCIES_RELEASE ICU::data)
set(icu_ICU_uc_SHARED_LINK_FLAGS_RELEASE )
set(icu_ICU_uc_EXE_LINK_FLAGS_RELEASE )
# COMPOUND VARIABLES
set(icu_ICU_uc_LINKER_FLAGS_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${icu_ICU_uc_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${icu_ICU_uc_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${icu_ICU_uc_EXE_LINK_FLAGS_RELEASE}>
)
set(icu_ICU_uc_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${icu_ICU_uc_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${icu_ICU_uc_COMPILE_OPTIONS_C_RELEASE}>")
########### COMPONENT ICU::dt VARIABLES ############################################

set(icu_ICU_dt_INCLUDE_DIRS_RELEASE "${icu_PACKAGE_FOLDER_RELEASE}/include")
set(icu_ICU_dt_LIB_DIRS_RELEASE "${icu_PACKAGE_FOLDER_RELEASE}/lib")
set(icu_ICU_dt_RES_DIRS_RELEASE )
set(icu_ICU_dt_DEFINITIONS_RELEASE )
set(icu_ICU_dt_OBJECTS_RELEASE )
set(icu_ICU_dt_COMPILE_DEFINITIONS_RELEASE )
set(icu_ICU_dt_COMPILE_OPTIONS_C_RELEASE "")
set(icu_ICU_dt_COMPILE_OPTIONS_CXX_RELEASE "")
set(icu_ICU_dt_LIBS_RELEASE )
set(icu_ICU_dt_SYSTEM_LIBS_RELEASE )
set(icu_ICU_dt_FRAMEWORK_DIRS_RELEASE )
set(icu_ICU_dt_FRAMEWORKS_RELEASE )
set(icu_ICU_dt_DEPENDENCIES_RELEASE ICU::data)
set(icu_ICU_dt_SHARED_LINK_FLAGS_RELEASE )
set(icu_ICU_dt_EXE_LINK_FLAGS_RELEASE )
# COMPOUND VARIABLES
set(icu_ICU_dt_LINKER_FLAGS_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${icu_ICU_dt_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${icu_ICU_dt_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${icu_ICU_dt_EXE_LINK_FLAGS_RELEASE}>
)
set(icu_ICU_dt_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${icu_ICU_dt_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${icu_ICU_dt_COMPILE_OPTIONS_C_RELEASE}>")
########### COMPONENT ICU::data VARIABLES ############################################

set(icu_ICU_data_INCLUDE_DIRS_RELEASE "${icu_PACKAGE_FOLDER_RELEASE}/include")
set(icu_ICU_data_LIB_DIRS_RELEASE "${icu_PACKAGE_FOLDER_RELEASE}/lib")
set(icu_ICU_data_RES_DIRS_RELEASE "${icu_PACKAGE_FOLDER_RELEASE}/res")
set(icu_ICU_data_DEFINITIONS_RELEASE "-DU_STATIC_IMPLEMENTATION")
set(icu_ICU_data_OBJECTS_RELEASE )
set(icu_ICU_data_COMPILE_DEFINITIONS_RELEASE "U_STATIC_IMPLEMENTATION")
set(icu_ICU_data_COMPILE_OPTIONS_C_RELEASE "")
set(icu_ICU_data_COMPILE_OPTIONS_CXX_RELEASE "")
set(icu_ICU_data_LIBS_RELEASE icudata)
set(icu_ICU_data_SYSTEM_LIBS_RELEASE c++)
set(icu_ICU_data_FRAMEWORK_DIRS_RELEASE )
set(icu_ICU_data_FRAMEWORKS_RELEASE )
set(icu_ICU_data_DEPENDENCIES_RELEASE )
set(icu_ICU_data_SHARED_LINK_FLAGS_RELEASE )
set(icu_ICU_data_EXE_LINK_FLAGS_RELEASE )
# COMPOUND VARIABLES
set(icu_ICU_data_LINKER_FLAGS_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${icu_ICU_data_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${icu_ICU_data_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${icu_ICU_data_EXE_LINK_FLAGS_RELEASE}>
)
set(icu_ICU_data_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${icu_ICU_data_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${icu_ICU_data_COMPILE_OPTIONS_C_RELEASE}>")