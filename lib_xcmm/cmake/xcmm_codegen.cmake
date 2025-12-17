# Function to generate JSONs from TD files
function(xcmm_generate_jsons_from_td)
    # Parse arguments
    set(options)
    set(oneValueArgs TARGET SEARCH_DIR OUT_DIR)
    set(multiValueArgs INCLUDE_DIRS)
    cmake_parse_arguments(XCMM_GEN "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    if(NOT XCMM_GEN_TARGET)
        message(FATAL_ERROR "xcmm_generate_jsons_from_td: TARGET argument is required")
    endif()

    if(NOT XCMM_GEN_SEARCH_DIR)
        set(XCMM_GEN_SEARCH_DIR ${CMAKE_CURRENT_SOURCE_DIR})
    endif()

    if(NOT XCMM_GEN_OUT_DIR)
        set(XCMM_GEN_OUT_DIR ${CMAKE_CURRENT_BINARY_DIR})
    endif()

    # Find llvm-tblgen
    find_program(LLVM_TBLGEN_EXECUTABLE NAMES llvm-tblgen)
    if(NOT LLVM_TBLGEN_EXECUTABLE)
        message(FATAL_ERROR "llvm-tblgen not found")
    endif()

    # Discover all .td files
    file(GLOB TD_FILES "${XCMM_GEN_SEARCH_DIR}/*.td")
    
    # Reconfigure when .td set changes
    set_property(DIRECTORY APPEND PROPERTY CMAKE_CONFIGURE_DEPENDS "${XCMM_GEN_SEARCH_DIR}/*.td")

    set(GENERATED_JSONS "")
    
    # Prepare include flags
    set(INCLUDE_FLAGS "")
    foreach(INC_DIR ${XCMM_GEN_INCLUDE_DIRS})
        list(APPEND INCLUDE_FLAGS "-I${INC_DIR}")
    endforeach()

    foreach(TD_FILE ${TD_FILES})
        get_filename_component(TD_NAME ${TD_FILE} NAME_WE)
        set(JSON_FILE ${XCMM_GEN_OUT_DIR}/${TD_NAME}.json)
        
        add_custom_command(
            OUTPUT ${JSON_FILE}
            COMMAND ${LLVM_TBLGEN_EXECUTABLE}
            ${INCLUDE_FLAGS}
            ${TD_FILE} --dump-json -o ${JSON_FILE}
            DEPENDS ${TD_FILE}
            COMMENT "Generating ${TD_NAME}.json using llvm-tblgen"
        )
        list(APPEND GENERATED_JSONS ${JSON_FILE})
    endforeach()

    # Expose the list of generated JSONs to the caller via a property on the target
    set_property(TARGET ${XCMM_GEN_TARGET} PROPERTY XCMM_GENERATED_JSONS "${GENERATED_JSONS}")
endfunction()

# Function to generate RPC stubs from JSON files
function(xcmm_generate_rpc_stubs)
    # Parse arguments
    set(options)
    set(oneValueArgs TARGET JSON_DIR OUT_DIR GEN_SCRIPT)
    set(multiValueArgs JSON_FILES)
    cmake_parse_arguments(XCMM_STUB "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    if(NOT XCMM_STUB_TARGET)
        message(FATAL_ERROR "xcmm_generate_rpc_stubs: TARGET argument is required")
    endif()

    if(NOT XCMM_STUB_OUT_DIR)
        set(XCMM_STUB_OUT_DIR ${CMAKE_CURRENT_BINARY_DIR}/generated)
    endif()

    if(NOT XCMM_STUB_GEN_SCRIPT)
        message(FATAL_ERROR "xcmm_generate_rpc_stubs: GEN_SCRIPT argument is required")
    endif()

    # If JSON_FILES are not provided explicitly, try to get them from the target property
    if(NOT XCMM_STUB_JSON_FILES)
        get_property(XCMM_STUB_JSON_FILES TARGET ${XCMM_STUB_TARGET} PROPERTY XCMM_GENERATED_JSONS)
    endif()

    if(NOT XCMM_STUB_JSON_FILES)
        message(WARNING "xcmm_generate_rpc_stubs: No JSON files found to process")
        return()
    endif()

    file(MAKE_DIRECTORY ${XCMM_STUB_OUT_DIR})

    set(GENERATED_STUBS "")
    foreach(JSON_FILE ${XCMM_STUB_JSON_FILES})
        get_filename_component(JSON_NAME ${JSON_FILE} NAME_WE)
        set(OUT_H ${XCMM_STUB_OUT_DIR}/${JSON_NAME}_gen.h)
        set(OUT_C ${XCMM_STUB_OUT_DIR}/${JSON_NAME}_gen.inc.c)
        
        add_custom_command(
            OUTPUT ${OUT_H} ${OUT_C}
            COMMAND ${XCMM_STUB_GEN_SCRIPT}
                    -os ${OUT_C}
                    -oh ${OUT_H}
                    --header-name ${JSON_NAME}_gen.h
                    ${JSON_FILE}
            DEPENDS ${JSON_FILE} ${XCMM_STUB_GEN_SCRIPT}
            COMMENT "Generating RPC stubs for ${JSON_NAME}.json"
        )
        list(APPEND GENERATED_STUBS ${OUT_H} ${OUT_C})
    endforeach()

    # Create a specific codegen target for this call to ensure stubs are generated
    # before the dependent target is built.
    set(CODEGEN_TARGET_NAME ${XCMM_STUB_TARGET}_codegen)
    
    if(NOT TARGET ${CODEGEN_TARGET_NAME})
        add_custom_target(${CODEGEN_TARGET_NAME} DEPENDS ${GENERATED_STUBS})
        add_dependencies(${XCMM_STUB_TARGET} ${CODEGEN_TARGET_NAME})
    endif()

    # Add include directory to the target
    target_include_directories(${XCMM_STUB_TARGET} INTERFACE ${XCMM_STUB_OUT_DIR})
endfunction()
