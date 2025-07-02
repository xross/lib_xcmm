set(LIB_NAME lib_xcmm)
set(LIB_VERSION 0.0.0)
set(LIB_INCLUDES api)
set(LIB_DEPENDENT_MODULES "")
set(LIB_COMPILER_FLAGS -O3)

set(XCMM_SUPPORT_SRC_DIR "src/XCMinusMinus/support/src")
set(XCMM_SUPPORT_API_DIR "src/XCMinusMinus/support/api")

set(LIB_INCLUDES    api
                    ${XCMM_SUPPORT_API_DIR}
)



set(LIB_C_SRCS  ${XCMM_SUPPORT_SRC_DIR}/context_lock.c
                ${XCMM_SUPPORT_SRC_DIR}/notifier.c
                ${XCMM_SUPPORT_SRC_DIR}/remote_transport_support.c
                ${XCMM_SUPPORT_SRC_DIR}/vthread_inlines.c
                ${XCMM_SUPPORT_SRC_DIR}/vthread_default_dtor.c
                ${XCMM_SUPPORT_SRC_DIR}/vthread_default_case_guard.c
                ${XCMM_SUPPORT_SRC_DIR}/vthread_default_case_config.c
                ${XCMM_SUPPORT_SRC_DIR}/xsystem/startup.c
                ${XCMM_SUPPORT_SRC_DIR}/yield_contexts.c
                ${XCMM_SUPPORT_SRC_DIR}/yield2.c
                ${XCMM_SUPPORT_SRC_DIR}/xm_os_enable_for_all_cores.c
                ${XCMM_SUPPORT_SRC_DIR}/xm_os_dump_wait_state.c
                ${XCMM_SUPPORT_SRC_DIR}/transport.c
)

set(LIB_ASM_SRCS    ${XCMM_SUPPORT_SRC_DIR}/server_await_transaction_on_any.S
                    ${XCMM_SUPPORT_SRC_DIR}/server_defer_transaction.S
                    ${XCMM_SUPPORT_SRC_DIR}/server_preconfigured_await.S
                    ${XCMM_SUPPORT_SRC_DIR}/vthread_wait.S
                    ${XCMM_SUPPORT_SRC_DIR}/input_yield.S
                    ${XCMM_SUPPORT_SRC_DIR}/begin_context.S
                    ${XCMM_SUPPORT_SRC_DIR}/xm_os_yield.S
                    ${XCMM_SUPPORT_SRC_DIR}/xm_os_yield_type_simple.S
                    ${XCMM_SUPPORT_SRC_DIR}/xm_os_yield_type_reslist.S
                    ${XCMM_SUPPORT_SRC_DIR}/xm_os_yield_type_custom.S
                    ${XCMM_SUPPORT_SRC_DIR}/xm_os_yield_suspend.S
                    ${XCMM_SUPPORT_SRC_DIR}/xm_os_yield_suspend.S
                    ${XCMM_SUPPORT_SRC_DIR}/xm_os_resource_yield_new.S
                    ${XCMM_SUPPORT_SRC_DIR}/rxc_yield_personality_array_descriptor.S
)

# Ignore any CPP and XC sources for now
set(LIB_XC_SRCS "")
set(LIB_CXX_SRCS "")

XMOS_REGISTER_MODULE()
