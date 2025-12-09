set(LIB_NAME lib_xcmm)
set(LIB_VERSION 0.0.0)
set(LIB_INCLUDES api)
set(LIB_DEPENDENT_MODULES "")
set(LIB_COMPILER_FLAGS -Os)

set(XCMM_RXC_DIR "src/XCMinusMinus/support/rxc")
set(XCMM_XM_OS_DIR "src/XCMinusMinus/support/xm_os/")

set(XCMM_RXC_XCORE_DIR "src/XCMinusMinus/support/rxc/target/xcore")
set(XCMM_XM_OS_XCORE_DIR "src/XCMinusMinus/support/xm_os/target/xcore")

set(LIB_INCLUDES    api
                    ${XCMM_RXC_DIR}/include
                    ${XCMM_RXC_DIR}/target/xcore/include
                    ${XCMM_XM_OS_DIR}/include
                    ${XCMM_XM_OS_DIR}/src
                    ${XCMM_XM_OS_XCORE_DIR}/include)

set(LIB_C_SRCS

                ${XCMM_XM_OS_DIR}/src/xm_os_dump_wait_state.c
                ${XCMM_XM_OS_DIR}/src/xm_os_enable_for_all_cores.c
                ${XCMM_XM_OS_DIR}/src/xm_os_fini_impl.c
                ${XCMM_XM_OS_DIR}/src/xm_os_init_impl.c
                ${XCMM_XM_OS_DIR}/src/xm_os_init_local_context_impl.c
                ${XCMM_XM_OS_DIR}/src/xm_os_init_shared_context.c
                ${XCMM_XM_OS_DIR}/src/xm_os_suspend_buffer.c
                ${XCMM_XM_OS_DIR}/src/xm_os_yield_context.c

                ${XCMM_XM_OS_DIR}/target/xcore/src/xm_os_fake_callee.c

                ${XCMM_RXC_DIR}/src/authoritative/rxc_shared_client_request_send_and_await.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_shared_notification_source_clear_as_primary.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_shared_notification_source_clear.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_shared_notification_source_raise_as_primary.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_shared_notification_source_raise.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_shared_server_configure_await.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_shared_server_complete_and_await.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_shared_server_defer_request.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_shared_server_get_tag.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_shared_server_get_request_bytes.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_shared_server_set_response_bytes.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_shared_server_clear_notification.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_shared_server_raise_notification.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_remote_client_request_send_and_await.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_remote_server_configure_await.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_remote_server_complete_and_await.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_remote_server_defer_request.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_remote_server_get_tag.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_remote_server_get_request_bytes.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_remote_server_set_response_bytes.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_remote_server_clear_notification.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_remote_server_raise_notification.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_init_shared_server.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_start_shared_server.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_configure_await_array.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_preconfigured_await.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_configure_and_await_array.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_configure_and_await_any.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_configure_and_await_one.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_get_tag.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_defer_request_if.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_defer_request.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_client_clear_notification.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_init_remote_notification_route.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_init_shared_notification_route.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_deinit_remote_notification_route.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_deinit_shared_notification_route.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_notification_endpoint_get_event_source.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_notification_endpoint_await.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_dissolve_notification_endpoint.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_dissolve_notification_source.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_init_request_envelope.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_get_response_pointer.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_get_response.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_shared_server_disable_previous_client_set.c
                ${XCMM_RXC_DIR}/src/authoritative/rxc_init_client_identification_block.c

)

set(LIB_ASM_SRCS

                ${XCMM_XM_OS_XCORE_DIR}/src/xm_os_resource_yield.S
                ${XCMM_XM_OS_XCORE_DIR}/src/xm_os_preconfigured_resource_yield_impl.S
                ${XCMM_XM_OS_XCORE_DIR}/src/xm_os_yield_suspend.S
                ${XCMM_XM_OS_XCORE_DIR}/src/xm_os_yield_with_personality_no_cc_wrapper_impl.S
                ${XCMM_XM_OS_XCORE_DIR}/src/xm_os_configure_yield_with_personality_no_cc_wrapper_impl.S
                ${XCMM_XM_OS_XCORE_DIR}/src/xm_os_personality_cc_wrapper.S
                ${XCMM_XM_OS_XCORE_DIR}/src/xm_os_yield_type_reslist.S
                ${XCMM_XM_OS_XCORE_DIR}/src/xm_os_yield_type_simple.S
                ${XCMM_XM_OS_XCORE_DIR}/src/xm_os_drain_resource_threads.S
                ${XCMM_XM_OS_XCORE_DIR}/src/xm_os_start_local_context_impl.S
                ${XCMM_XM_OS_XCORE_DIR}/src/xm_os_task_end.S
                ${XCMM_XM_OS_XCORE_DIR}/src/xm_os_yield_return_impl.S
                ${XCMM_XM_OS_XCORE_DIR}/src/xm_os_yield_to_impl.S
                ${XCMM_XM_OS_XCORE_DIR}/src/xm_os_yield_to_controlling.S

                ${XCMM_RXC_XCORE_DIR}/src/rxc_yield_personality_array_descriptor.S
)

# Ignore any CPP and XC sources for now
set(LIB_XC_SRCS "")
set(LIB_CXX_SRCS "")

XMOS_REGISTER_MODULE()
