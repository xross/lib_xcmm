#pragma once
#include <xcore/chanend.h>

#ifdef __cplusplus
extern "C"
{
#endif
    typedef unsigned long remote_link_t;
    typedef unsigned char transaction_tag_t;
    typedef unsigned server_flag_t;

    inline void send_bytes(remote_link_t t, const void *bytes, unsigned long num)
    {
        for (int i = 0; i < num; i += 1)
            chanend_out_byte(t, ((const unsigned char *)bytes)[i]);
    }

    inline void receive_bytes(remote_link_t t, void *bytes, unsigned long num)
    {
        for (int i = 0; i < num; i += 1)
            ((unsigned char *)bytes)[i] = chanend_in_byte(t);
    }

    inline transaction_tag_t server_await_transaction(remote_link_t t)
    {
        transaction_tag_t tag = chanend_in_byte(t);
        chanend_out_end_token(t);
        return tag;
    }

    inline void client_request_transaction(remote_link_t t, transaction_tag_t tag)
    {
        const int ctPause = 2;
        chanend_out_byte(t, tag);
        chanend_out_control_token(t, ctPause);
        chanend_check_end_token(t);
    }

    inline void client_send_flag(remote_link_t t, server_flag_t f)
    {
        chanend_out_byte(t, f);
        //TODO: Should pause?!
    }

    inline server_flag_t server_receive_flag(remote_link_t t)
    {
        return chanend_in_byte(t);
    }

#ifdef __cplusplus
}
#endif
