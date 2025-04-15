#include <xcore/chanend.h>
#include "remote_transport_support.h"

#define CT_PAUSE 2

static inline void send_short(remote_link_t t, short v)
{
    send_bytes(t, (const unsigned char *)&v, sizeof(short));
}

static inline short receive_short(remote_link_t t)
{
    short res;
    receive_bytes(t, &res, sizeof(short));
    return res;
}

inline void server_deserialise_i(remote_link_t t, int *r0)
{
    *r0 = chanend_in_word(t);
}

inline void client_serialise_i(remote_link_t t, int a0)
{
    chanend_out_word(t, a0);
    chanend_out_control_token(t, CT_PAUSE);
}

inline void server_deserialise_c(remote_link_t t, uint8_t *r0)
{
    *r0 = chanend_in_byte(t);
}

inline void client_serialise_c(remote_link_t t, uint8_t a0)
{
    chanend_out_byte(t, a0);
    chanend_out_control_token(t, CT_PAUSE);
}

inline void server_deserialise_v(remote_link_t t)
{
}

inline void client_serialise_v(remote_link_t t)
{
}

inline void server_deserialise_jsc(remote_link_t t, unsigned *r0, short *r1, char *r2)
{
    *r0 = chanend_in_word(t);
    *r1 = receive_short(t);
    *r2 = chanend_in_byte(t);
}

inline void client_serialise_jsc(remote_link_t t, unsigned a0, short a1, char a2)
{
    chanend_out_word(t, a0);
    send_short(t, a1);
    chanend_out_byte(t, a2);
    chanend_out_control_token(t, CT_PAUSE);
}

inline void server_return_v(remote_link_t t)
{
    chanend_out_end_token(t);
}

inline void client_await_result_v(remote_link_t t)
{
    chanend_check_end_token(t);
}

inline void server_return_i(remote_link_t t, int a0)
{
    chanend_out_word(t, a0);
    chanend_out_end_token(t);
}

inline void client_await_result_i(remote_link_t t, int *r0)
{
    *r0 = chanend_in_word(t);
    chanend_check_end_token(t);
}

inline void server_return_c(remote_link_t t, uint8_t a0)
{
    chanend_out_byte(t, a0);
    chanend_out_end_token(t);
}

inline void client_await_result_c(remote_link_t t, uint8_t *r0)
{
    *r0 = chanend_in_byte(t);
    chanend_check_end_token(t);
}
