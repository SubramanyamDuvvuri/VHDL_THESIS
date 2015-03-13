/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/sduvvuri/fpgaSVN/FPGA/lib/NDLCom/trunk/UART_mod.vhd";
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_3488768496604610246_503743352(char *, unsigned char , unsigned char );
unsigned char ieee_p_2592010699_sub_374109322130769762_503743352(char *, unsigned char );


static void work_a_3871240792_3212880686_p_0(char *t0)
{
    unsigned char t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    char *t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;

LAB0:    xsi_set_current_line(81, ng0);
    t2 = (t0 + 1032U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 9912);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(82, ng0);
    t7 = (t0 + 1192U);
    t8 = *((char **)t7);
    t9 = *((unsigned char *)t8);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB8;

LAB10:    xsi_set_current_line(86, ng0);
    t2 = (t0 + 1512U);
    t3 = *((char **)t2);
    t1 = *((unsigned char *)t3);
    t2 = (t0 + 10088);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t11 = (t8 + 56U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = t1;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(87, ng0);
    t2 = (t0 + 3752U);
    t3 = *((char **)t2);
    t1 = *((unsigned char *)t3);
    t2 = (t0 + 10152);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t11 = (t8 + 56U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = t1;
    xsi_driver_first_trans_fast(t2);

LAB9:    goto LAB3;

LAB5:    t2 = (t0 + 992U);
    t6 = xsi_signal_has_event(t2);
    t1 = t6;
    goto LAB7;

LAB8:    xsi_set_current_line(83, ng0);
    t7 = (t0 + 10088);
    t11 = (t7 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    *((unsigned char *)t14) = (unsigned char)2;
    xsi_driver_first_trans_fast(t7);
    xsi_set_current_line(84, ng0);
    t2 = (t0 + 10152);
    t3 = (t2 + 56U);
    t7 = *((char **)t3);
    t8 = (t7 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    goto LAB9;

}

static void work_a_3871240792_3212880686_p_1(char *t0)
{
    unsigned char t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    char *t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    int t12;
    int t13;
    int t14;
    char *t15;

LAB0:    xsi_set_current_line(96, ng0);
    t2 = (t0 + 1032U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 9928);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(97, ng0);
    t7 = (t0 + 1192U);
    t8 = *((char **)t7);
    t9 = *((unsigned char *)t8);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB8;

LAB10:    xsi_set_current_line(102, ng0);
    t2 = (t0 + 3912U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 == 1)
        goto LAB14;

LAB15:    t1 = (unsigned char)0;

LAB16:    if (t1 != 0)
        goto LAB11;

LAB13:    t2 = (t0 + 3912U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)2);
    if (t5 == 1)
        goto LAB19;

LAB20:    t1 = (unsigned char)0;

LAB21:    if (t1 != 0)
        goto LAB17;

LAB18:
LAB12:    xsi_set_current_line(107, ng0);
    t2 = (t0 + 6168U);
    t3 = *((char **)t2);
    t12 = *((int *)t3);
    t1 = (t12 > 2);
    if (t1 != 0)
        goto LAB22;

LAB24:    xsi_set_current_line(110, ng0);
    t2 = (t0 + 10216);
    t3 = (t2 + 56U);
    t7 = *((char **)t3);
    t8 = (t7 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);

LAB23:    xsi_set_current_line(112, ng0);
    t2 = (t0 + 4072U);
    t3 = *((char **)t2);
    t1 = *((unsigned char *)t3);
    t2 = (t0 + 10280);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t11 = (t8 + 56U);
    t15 = *((char **)t11);
    *((unsigned char *)t15) = t1;
    xsi_driver_first_trans_fast(t2);

LAB9:    goto LAB3;

LAB5:    t2 = (t0 + 992U);
    t6 = xsi_signal_has_event(t2);
    t1 = t6;
    goto LAB7;

LAB8:    xsi_set_current_line(98, ng0);
    t7 = (t0 + 6168U);
    t11 = *((char **)t7);
    t7 = (t11 + 0);
    *((int *)t7) = 3;
    xsi_set_current_line(99, ng0);
    t2 = (t0 + 10216);
    t3 = (t2 + 56U);
    t7 = *((char **)t3);
    t8 = (t7 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(100, ng0);
    t2 = (t0 + 10280);
    t3 = (t2 + 56U);
    t7 = *((char **)t3);
    t8 = (t7 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    goto LAB9;

LAB11:    xsi_set_current_line(103, ng0);
    t2 = (t0 + 6168U);
    t8 = *((char **)t2);
    t13 = *((int *)t8);
    t14 = (t13 + 1);
    t2 = (t0 + 6168U);
    t11 = *((char **)t2);
    t2 = (t11 + 0);
    *((int *)t2) = t14;
    goto LAB12;

LAB14:    t2 = (t0 + 6168U);
    t7 = *((char **)t2);
    t12 = *((int *)t7);
    t6 = (t12 < 5);
    t1 = t6;
    goto LAB16;

LAB17:    xsi_set_current_line(105, ng0);
    t2 = (t0 + 6168U);
    t8 = *((char **)t2);
    t13 = *((int *)t8);
    t14 = (t13 - 1);
    t2 = (t0 + 6168U);
    t11 = *((char **)t2);
    t2 = (t11 + 0);
    *((int *)t2) = t14;
    goto LAB12;

LAB19:    t2 = (t0 + 6168U);
    t7 = *((char **)t2);
    t12 = *((int *)t7);
    t6 = (t12 > 1);
    t1 = t6;
    goto LAB21;

LAB22:    xsi_set_current_line(108, ng0);
    t2 = (t0 + 10216);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t11 = (t8 + 56U);
    t15 = *((char **)t11);
    *((unsigned char *)t15) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    goto LAB23;

}

static void work_a_3871240792_3212880686_p_2(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    unsigned char t10;
    unsigned char t11;
    unsigned char t12;
    char *t13;
    char *t14;
    int t15;
    int t16;
    int t17;
    int t18;
    int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    static char *nl0[] = {&&LAB11, &&LAB12, &&LAB13, &&LAB14, &&LAB15};

LAB0:    xsi_set_current_line(126, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t10 = (t4 == (unsigned char)3);
    if (t10 == 1)
        goto LAB7;

LAB8:    t3 = (unsigned char)0;

LAB9:    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 9944);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(127, ng0);
    t1 = (t0 + 10344);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(128, ng0);
    t1 = (t0 + 10408);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(129, ng0);
    t1 = xsi_get_transient_memory(8U);
    memset(t1, 0, 8U);
    t2 = t1;
    memset(t2, (unsigned char)2, 8U);
    t5 = (t0 + 10472);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 8U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(130, ng0);
    t1 = (t0 + 10536);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(131, ng0);
    t1 = (t0 + 6288U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(132, ng0);
    t1 = (t0 + 6408U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(133, ng0);
    t1 = (t0 + 6528U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((unsigned char *)t1) = (unsigned char)2;
    goto LAB3;

LAB5:    xsi_set_current_line(137, ng0);
    t5 = (t0 + 2792U);
    t6 = *((char **)t5);
    t12 = *((unsigned char *)t6);
    t5 = (char *)((nl0) + t12);
    goto **((char **)t5);

LAB7:    t1 = (t0 + 992U);
    t11 = xsi_signal_has_event(t1);
    t3 = t11;
    goto LAB9;

LAB10:    goto LAB3;

LAB11:    xsi_set_current_line(140, ng0);
    t7 = (t0 + 10344);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t13 = (t9 + 56U);
    t14 = *((char **)t13);
    *((unsigned char *)t14) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t7);
    xsi_set_current_line(141, ng0);
    t1 = (t0 + 10408);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(142, ng0);
    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB16;

LAB18:    xsi_set_current_line(151, ng0);
    t1 = (t0 + 10536);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);

LAB17:    goto LAB10;

LAB12:    xsi_set_current_line(155, ng0);
    t1 = (t0 + 10344);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(156, ng0);
    t1 = (t0 + 6408U);
    t2 = *((char **)t1);
    t15 = *((int *)t2);
    t1 = (t0 + 5328U);
    t5 = *((char **)t1);
    t16 = *((int *)t5);
    t17 = (t16 - 1);
    t3 = (t15 < t17);
    if (t3 != 0)
        goto LAB19;

LAB21:    xsi_set_current_line(160, ng0);
    t1 = (t0 + 6408U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(161, ng0);
    t1 = (t0 + 10536);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);

LAB20:    goto LAB10;

LAB13:    xsi_set_current_line(165, ng0);
    t1 = (t0 + 3592U);
    t2 = *((char **)t1);
    t1 = (t0 + 6288U);
    t5 = *((char **)t1);
    t15 = *((int *)t5);
    t16 = (t15 - 7);
    t20 = (t16 * -1);
    xsi_vhdl_check_range_of_index(7, 0, -1, t15);
    t21 = (1U * t20);
    t22 = (0 + t21);
    t1 = (t2 + t22);
    t3 = *((unsigned char *)t1);
    t6 = (t0 + 10344);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t13 = *((char **)t9);
    *((unsigned char *)t13) = t3;
    xsi_driver_first_trans_fast_port(t6);
    xsi_set_current_line(166, ng0);
    t1 = (t0 + 6408U);
    t2 = *((char **)t1);
    t15 = *((int *)t2);
    t1 = (t0 + 5328U);
    t5 = *((char **)t1);
    t16 = *((int *)t5);
    t17 = (t16 - 1);
    t3 = (t15 < t17);
    if (t3 != 0)
        goto LAB22;

LAB24:    xsi_set_current_line(170, ng0);
    t1 = (t0 + 6408U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(171, ng0);
    t1 = (t0 + 3592U);
    t2 = *((char **)t1);
    t1 = (t0 + 6288U);
    t5 = *((char **)t1);
    t15 = *((int *)t5);
    t16 = (t15 - 7);
    t20 = (t16 * -1);
    xsi_vhdl_check_range_of_index(7, 0, -1, t15);
    t21 = (1U * t20);
    t22 = (0 + t21);
    t1 = (t2 + t22);
    t3 = *((unsigned char *)t1);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB25;

LAB27:
LAB26:    xsi_set_current_line(174, ng0);
    t1 = (t0 + 6288U);
    t2 = *((char **)t1);
    t15 = *((int *)t2);
    t3 = (t15 < 7);
    if (t3 != 0)
        goto LAB28;

LAB30:    t4 = (0 == 1);
    if (t4 == 1)
        goto LAB33;

LAB34:    t10 = (0 == 1);
    t3 = t10;

LAB35:    if (t3 != 0)
        goto LAB31;

LAB32:    xsi_set_current_line(180, ng0);
    t1 = (t0 + 10536);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)4;
    xsi_driver_first_trans_fast(t1);

LAB29:
LAB23:    goto LAB10;

LAB14:    xsi_set_current_line(185, ng0);
    t3 = (0 == 1);
    if (t3 != 0)
        goto LAB36;

LAB38:    xsi_set_current_line(188, ng0);
    t1 = (t0 + 6528U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = ieee_p_2592010699_sub_374109322130769762_503743352(IEEE_P_2592010699, t3);
    t1 = (t0 + 10344);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = t4;
    xsi_driver_first_trans_fast_port(t1);

LAB37:    xsi_set_current_line(191, ng0);
    t1 = (t0 + 6408U);
    t2 = *((char **)t1);
    t15 = *((int *)t2);
    t1 = (t0 + 5328U);
    t5 = *((char **)t1);
    t16 = *((int *)t5);
    t17 = (t16 - 1);
    t3 = (t15 < t17);
    if (t3 != 0)
        goto LAB39;

LAB41:    xsi_set_current_line(195, ng0);
    t1 = (t0 + 6408U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(196, ng0);
    t1 = (t0 + 10536);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)4;
    xsi_driver_first_trans_fast(t1);

LAB40:    goto LAB10;

LAB15:    xsi_set_current_line(202, ng0);
    t1 = (t0 + 10344);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(203, ng0);
    t1 = (t0 + 6408U);
    t2 = *((char **)t1);
    t15 = *((int *)t2);
    t1 = (t0 + 5328U);
    t5 = *((char **)t1);
    t16 = *((int *)t5);
    t17 = (t16 - 2);
    t3 = (t15 < t17);
    if (t3 != 0)
        goto LAB42;

LAB44:    xsi_set_current_line(207, ng0);
    t1 = (t0 + 10408);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(208, ng0);
    t1 = (t0 + 10536);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);

LAB43:    goto LAB10;

LAB16:    xsi_set_current_line(143, ng0);
    t1 = (t0 + 10344);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(144, ng0);
    t1 = (t0 + 6288U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(145, ng0);
    t1 = (t0 + 6408U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(146, ng0);
    t1 = (t0 + 6528U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((unsigned char *)t1) = (unsigned char)2;
    xsi_set_current_line(147, ng0);
    t1 = (t0 + 10408);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(148, ng0);
    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t1 = (t0 + 10472);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 8U);
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(149, ng0);
    t1 = (t0 + 10536);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)1;
    xsi_driver_first_trans_fast(t1);
    goto LAB17;

LAB19:    xsi_set_current_line(157, ng0);
    t1 = (t0 + 6408U);
    t6 = *((char **)t1);
    t18 = *((int *)t6);
    t19 = (t18 + 1);
    t1 = (t0 + 6408U);
    t7 = *((char **)t1);
    t1 = (t7 + 0);
    *((int *)t1) = t19;
    xsi_set_current_line(158, ng0);
    t1 = (t0 + 10536);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)1;
    xsi_driver_first_trans_fast(t1);
    goto LAB20;

LAB22:    xsi_set_current_line(167, ng0);
    t1 = (t0 + 6408U);
    t6 = *((char **)t1);
    t18 = *((int *)t6);
    t19 = (t18 + 1);
    t1 = (t0 + 6408U);
    t7 = *((char **)t1);
    t1 = (t7 + 0);
    *((int *)t1) = t19;
    xsi_set_current_line(168, ng0);
    t1 = (t0 + 10536);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    goto LAB23;

LAB25:    xsi_set_current_line(172, ng0);
    t6 = (t0 + 6528U);
    t7 = *((char **)t6);
    t10 = *((unsigned char *)t7);
    t11 = ieee_p_2592010699_sub_374109322130769762_503743352(IEEE_P_2592010699, t10);
    t6 = (t0 + 6528U);
    t8 = *((char **)t6);
    t6 = (t8 + 0);
    *((unsigned char *)t6) = t11;
    goto LAB26;

LAB28:    xsi_set_current_line(175, ng0);
    t1 = (t0 + 6288U);
    t5 = *((char **)t1);
    t16 = *((int *)t5);
    t17 = (t16 + 1);
    t1 = (t0 + 6288U);
    t6 = *((char **)t1);
    t1 = (t6 + 0);
    *((int *)t1) = t17;
    xsi_set_current_line(176, ng0);
    t1 = (t0 + 10536);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    goto LAB29;

LAB31:    xsi_set_current_line(178, ng0);
    t1 = (t0 + 10536);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    goto LAB29;

LAB33:    t3 = (unsigned char)1;
    goto LAB35;

LAB36:    xsi_set_current_line(186, ng0);
    t1 = (t0 + 6528U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t1 = (t0 + 10344);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = t4;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB37;

LAB39:    xsi_set_current_line(192, ng0);
    t1 = (t0 + 6408U);
    t6 = *((char **)t1);
    t18 = *((int *)t6);
    t19 = (t18 + 1);
    t1 = (t0 + 6408U);
    t7 = *((char **)t1);
    t1 = (t7 + 0);
    *((int *)t1) = t19;
    xsi_set_current_line(193, ng0);
    t1 = (t0 + 10536);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    goto LAB40;

LAB42:    xsi_set_current_line(204, ng0);
    t1 = (t0 + 6408U);
    t6 = *((char **)t1);
    t18 = *((int *)t6);
    t19 = (t18 + 1);
    t1 = (t0 + 6408U);
    t7 = *((char **)t1);
    t1 = (t7 + 0);
    *((int *)t1) = t19;
    xsi_set_current_line(205, ng0);
    t1 = (t0 + 10536);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)4;
    xsi_driver_first_trans_fast(t1);
    goto LAB43;

}

static void work_a_3871240792_3212880686_p_3(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    unsigned char t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;

LAB0:    xsi_set_current_line(216, ng0);

LAB3:    t1 = (t0 + 4392U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 1992U);
    t4 = *((char **)t1);
    t5 = *((unsigned char *)t4);
    t6 = ieee_p_2592010699_sub_374109322130769762_503743352(IEEE_P_2592010699, t5);
    t7 = ieee_p_2592010699_sub_3488768496604610246_503743352(IEEE_P_2592010699, t3, t6);
    t1 = (t0 + 10600);
    t8 = (t1 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    *((unsigned char *)t11) = t7;
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t12 = (t0 + 9960);
    *((int *)t12) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_3871240792_3212880686_p_4(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    unsigned char t10;
    unsigned char t11;
    unsigned char t12;
    int t13;
    int t14;
    int t15;
    int t16;
    int t17;
    int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    char *t22;
    char *t23;
    static char *nl0[] = {&&LAB11, &&LAB12, &&LAB13, &&LAB14, &&LAB15, &&LAB16, &&LAB17};

LAB0:    xsi_set_current_line(229, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t10 = (t4 == (unsigned char)3);
    if (t10 == 1)
        goto LAB7;

LAB8:    t3 = (unsigned char)0;

LAB9:    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 9976);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(230, ng0);
    t1 = (t0 + 6648U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(231, ng0);
    t1 = (t0 + 6768U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(232, ng0);
    t1 = (t0 + 6888U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(233, ng0);
    t1 = (t0 + 7008U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(234, ng0);
    t1 = (t0 + 7128U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((unsigned char *)t1) = (unsigned char)2;
    xsi_set_current_line(235, ng0);
    t1 = (t0 + 10664);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(236, ng0);
    t1 = (t0 + 10728);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(237, ng0);
    t1 = xsi_get_transient_memory(8U);
    memset(t1, 0, 8U);
    t2 = t1;
    memset(t2, (unsigned char)2, 8U);
    t5 = (t0 + 10792);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 8U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(238, ng0);
    t1 = (t0 + 10856);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    goto LAB3;

LAB5:    xsi_set_current_line(242, ng0);
    t5 = (t0 + 2952U);
    t6 = *((char **)t5);
    t12 = *((unsigned char *)t6);
    t5 = (char *)((nl0) + t12);
    goto **((char **)t5);

LAB7:    t1 = (t0 + 992U);
    t11 = xsi_signal_has_event(t1);
    t3 = t11;
    goto LAB9;

LAB10:    goto LAB3;

LAB11:    xsi_set_current_line(246, ng0);
    t7 = (t0 + 6648U);
    t8 = *((char **)t7);
    t7 = (t8 + 0);
    *((int *)t7) = 0;
    xsi_set_current_line(247, ng0);
    t1 = (t0 + 6768U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(248, ng0);
    t1 = (t0 + 6888U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(249, ng0);
    t1 = (t0 + 7008U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(250, ng0);
    t1 = (t0 + 7128U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((unsigned char *)t1) = (unsigned char)2;
    xsi_set_current_line(251, ng0);
    t1 = (t0 + 10664);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(253, ng0);
    t1 = (t0 + 4072U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t10 = (t4 == (unsigned char)2);
    if (t10 == 1)
        goto LAB21;

LAB22:    t3 = (unsigned char)0;

LAB23:    if (t3 != 0)
        goto LAB18;

LAB20:    xsi_set_current_line(260, ng0);
    t1 = (t0 + 10856);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);

LAB19:    goto LAB10;

LAB12:    xsi_set_current_line(265, ng0);
    t1 = (t0 + 6888U);
    t2 = *((char **)t1);
    t13 = *((int *)t2);
    t14 = (t13 + 1);
    t1 = (t0 + 6888U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    *((int *)t1) = t14;
    xsi_set_current_line(266, ng0);
    t1 = (t0 + 4072U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB24;

LAB26:    t1 = (t0 + 4072U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t10 = (t4 == (unsigned char)2);
    if (t10 == 1)
        goto LAB29;

LAB30:    t3 = (unsigned char)0;

LAB31:    if (t3 != 0)
        goto LAB27;

LAB28:    xsi_set_current_line(278, ng0);
    t1 = (t0 + 6768U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(279, ng0);
    t1 = (t0 + 7008U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(280, ng0);
    t1 = (t0 + 10728);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(281, ng0);
    t1 = (t0 + 10856);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);

LAB25:    goto LAB10;

LAB13:    xsi_set_current_line(286, ng0);
    t1 = (t0 + 6888U);
    t2 = *((char **)t1);
    t13 = *((int *)t2);
    t1 = (t0 + 5448U);
    t5 = *((char **)t1);
    t14 = *((int *)t5);
    t1 = (t0 + 5568U);
    t6 = *((char **)t1);
    t15 = *((int *)t6);
    t16 = (t14 + t15);
    t3 = (t13 < t16);
    if (t3 != 0)
        goto LAB32;

LAB34:    xsi_set_current_line(294, ng0);
    t1 = (t0 + 6888U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(296, ng0);
    t1 = (t0 + 7008U);
    t2 = *((char **)t1);
    t13 = *((int *)t2);
    t1 = (t0 + 5808U);
    t5 = *((char **)t1);
    t14 = *((int *)t5);
    t3 = (t13 > t14);
    if (t3 != 0)
        goto LAB38;

LAB40:    xsi_set_current_line(302, ng0);
    t1 = (t0 + 10856);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);

LAB39:
LAB33:    goto LAB10;

LAB14:    xsi_set_current_line(311, ng0);
    t1 = (t0 + 6888U);
    t2 = *((char **)t1);
    t13 = *((int *)t2);
    t1 = (t0 + 5448U);
    t5 = *((char **)t1);
    t14 = *((int *)t5);
    t1 = (t0 + 5688U);
    t6 = *((char **)t1);
    t15 = *((int *)t6);
    t16 = (t14 + t15);
    t17 = (t16 - 1);
    t3 = (t13 >= t17);
    if (t3 != 0)
        goto LAB41;

LAB43:    xsi_set_current_line(324, ng0);
    t1 = (t0 + 6888U);
    t2 = *((char **)t1);
    t13 = *((int *)t2);
    t14 = (t13 + 1);
    t1 = (t0 + 6888U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    *((int *)t1) = t14;
    xsi_set_current_line(325, ng0);
    t1 = (t0 + 10856);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);

LAB42:    goto LAB10;

LAB15:    xsi_set_current_line(330, ng0);
    t1 = (t0 + 6888U);
    t2 = *((char **)t1);
    t13 = *((int *)t2);
    t1 = (t0 + 5448U);
    t5 = *((char **)t1);
    t14 = *((int *)t5);
    t15 = (t14 - 1);
    t3 = (t13 < t15);
    if (t3 != 0)
        goto LAB47;

LAB49:    xsi_set_current_line(339, ng0);
    t1 = (t0 + 6888U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(341, ng0);
    t1 = (t0 + 5448U);
    t2 = *((char **)t1);
    t13 = *((int *)t2);
    t1 = (t0 + 7008U);
    t5 = *((char **)t1);
    t14 = *((int *)t5);
    t15 = (t13 - t14);
    t1 = (t0 + 5808U);
    t6 = *((char **)t1);
    t16 = *((int *)t6);
    t3 = (t15 <= t16);
    if (t3 != 0)
        goto LAB53;

LAB55:    t1 = (t0 + 7008U);
    t2 = *((char **)t1);
    t13 = *((int *)t2);
    t1 = (t0 + 5808U);
    t5 = *((char **)t1);
    t14 = *((int *)t5);
    t3 = (t13 <= t14);
    if (t3 != 0)
        goto LAB59;

LAB60:    xsi_set_current_line(355, ng0);
    t1 = (t0 + 10728);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(356, ng0);
    t1 = (t0 + 10856);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);

LAB54:    xsi_set_current_line(359, ng0);
    t1 = (t0 + 6648U);
    t2 = *((char **)t1);
    t13 = *((int *)t2);
    t14 = (t13 + 1);
    t1 = (t0 + 6648U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    *((int *)t1) = t14;

LAB48:    goto LAB10;

LAB16:    xsi_set_current_line(363, ng0);
    t3 = (0 == 1);
    if (t3 != 0)
        goto LAB61;

LAB63:    t3 = (0 == 1);
    if (t3 != 0)
        goto LAB67;

LAB68:    xsi_set_current_line(378, ng0);
    t1 = (t0 + 10856);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)6;
    xsi_driver_first_trans_fast(t1);

LAB62:    goto LAB10;

LAB17:    xsi_set_current_line(383, ng0);
    t1 = (t0 + 6888U);
    t2 = *((char **)t1);
    t13 = *((int *)t2);
    t1 = (t0 + 5568U);
    t5 = *((char **)t1);
    t14 = *((int *)t5);
    t3 = (t13 < t14);
    if (t3 != 0)
        goto LAB72;

LAB74:    xsi_set_current_line(392, ng0);
    t1 = (t0 + 5568U);
    t2 = *((char **)t1);
    t13 = *((int *)t2);
    t1 = (t0 + 7008U);
    t5 = *((char **)t1);
    t14 = *((int *)t5);
    t15 = (t13 - t14);
    t1 = (t0 + 5808U);
    t6 = *((char **)t1);
    t16 = *((int *)t6);
    t3 = (t15 > t16);
    if (t3 != 0)
        goto LAB78;

LAB80:    xsi_set_current_line(399, ng0);
    t1 = (t0 + 6888U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(400, ng0);
    t1 = (t0 + 10856);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(401, ng0);
    t1 = (t0 + 10664);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);

LAB79:
LAB73:    goto LAB10;

LAB18:    xsi_set_current_line(256, ng0);
    t1 = (t0 + 10856);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)1;
    xsi_driver_first_trans_fast(t1);
    goto LAB19;

LAB21:    t1 = (t0 + 4232U);
    t5 = *((char **)t1);
    t11 = *((unsigned char *)t5);
    t12 = (t11 == (unsigned char)3);
    t3 = t12;
    goto LAB23;

LAB24:    xsi_set_current_line(269, ng0);
    t1 = (t0 + 10856);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    goto LAB25;

LAB27:    xsi_set_current_line(273, ng0);
    t1 = (t0 + 6768U);
    t7 = *((char **)t1);
    t15 = *((int *)t7);
    t16 = (t15 + 1);
    t1 = (t0 + 6768U);
    t8 = *((char **)t1);
    t1 = (t8 + 0);
    *((int *)t1) = t16;
    xsi_set_current_line(274, ng0);
    t1 = (t0 + 10856);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)1;
    xsi_driver_first_trans_fast(t1);
    goto LAB25;

LAB29:    t1 = (t0 + 6768U);
    t5 = *((char **)t1);
    t13 = *((int *)t5);
    t1 = (t0 + 5928U);
    t6 = *((char **)t1);
    t14 = *((int *)t6);
    t11 = (t13 < t14);
    t3 = t11;
    goto LAB31;

LAB32:    xsi_set_current_line(288, ng0);
    t1 = (t0 + 6888U);
    t7 = *((char **)t1);
    t17 = *((int *)t7);
    t18 = (t17 + 1);
    t1 = (t0 + 6888U);
    t8 = *((char **)t1);
    t1 = (t8 + 0);
    *((int *)t1) = t18;
    xsi_set_current_line(289, ng0);
    t1 = (t0 + 10856);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(290, ng0);
    t1 = (t0 + 4072U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB35;

LAB37:
LAB36:    goto LAB33;

LAB35:    xsi_set_current_line(291, ng0);
    t1 = (t0 + 7008U);
    t5 = *((char **)t1);
    t13 = *((int *)t5);
    t14 = (t13 + 1);
    t1 = (t0 + 7008U);
    t6 = *((char **)t1);
    t1 = (t6 + 0);
    *((int *)t1) = t14;
    goto LAB36;

LAB38:    xsi_set_current_line(298, ng0);
    t1 = (t0 + 10728);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(299, ng0);
    t1 = (t0 + 10856);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    goto LAB39;

LAB41:    xsi_set_current_line(312, ng0);
    t1 = (t0 + 6888U);
    t7 = *((char **)t1);
    t1 = (t7 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(313, ng0);
    t1 = (t0 + 7008U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(315, ng0);
    t1 = (t0 + 6648U);
    t2 = *((char **)t1);
    t13 = *((int *)t2);
    t1 = (t0 + 6048U);
    t5 = *((char **)t1);
    t14 = *((int *)t5);
    t3 = (t13 >= t14);
    if (t3 != 0)
        goto LAB44;

LAB46:    xsi_set_current_line(320, ng0);
    t1 = (t0 + 10856);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)4;
    xsi_driver_first_trans_fast(t1);

LAB45:    goto LAB42;

LAB44:    xsi_set_current_line(317, ng0);
    t1 = (t0 + 10856);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)5;
    xsi_driver_first_trans_fast(t1);
    goto LAB45;

LAB47:    xsi_set_current_line(332, ng0);
    t1 = (t0 + 6888U);
    t6 = *((char **)t1);
    t16 = *((int *)t6);
    t17 = (t16 + 1);
    t1 = (t0 + 6888U);
    t7 = *((char **)t1);
    t1 = (t7 + 0);
    *((int *)t1) = t17;
    xsi_set_current_line(333, ng0);
    t1 = (t0 + 10856);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)4;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(334, ng0);
    t1 = (t0 + 4072U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB50;

LAB52:
LAB51:    goto LAB48;

LAB50:    xsi_set_current_line(335, ng0);
    t1 = (t0 + 7008U);
    t5 = *((char **)t1);
    t13 = *((int *)t5);
    t14 = (t13 + 1);
    t1 = (t0 + 7008U);
    t6 = *((char **)t1);
    t1 = (t6 + 0);
    *((int *)t1) = t14;
    goto LAB51;

LAB53:    xsi_set_current_line(343, ng0);
    t1 = (t0 + 6648U);
    t7 = *((char **)t1);
    t17 = *((int *)t7);
    t18 = (t17 - 7);
    t19 = (t18 * -1);
    t20 = (1 * t19);
    t21 = (0U + t20);
    t1 = (t0 + 10792);
    t8 = (t1 + 56U);
    t9 = *((char **)t8);
    t22 = (t9 + 56U);
    t23 = *((char **)t22);
    *((unsigned char *)t23) = (unsigned char)3;
    xsi_driver_first_trans_delta(t1, t21, 1, 0LL);
    xsi_set_current_line(344, ng0);
    t1 = (t0 + 10856);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(345, ng0);
    t1 = (t0 + 6648U);
    t2 = *((char **)t1);
    t13 = *((int *)t2);
    t1 = (t0 + 6048U);
    t5 = *((char **)t1);
    t14 = *((int *)t5);
    t15 = (t14 - 0);
    t16 = (t15 - 0);
    t3 = (t13 < t16);
    if (t3 != 0)
        goto LAB56;

LAB58:
LAB57:    goto LAB54;

LAB56:    xsi_set_current_line(346, ng0);
    t1 = (t0 + 7128U);
    t6 = *((char **)t1);
    t4 = *((unsigned char *)t6);
    t10 = ieee_p_2592010699_sub_374109322130769762_503743352(IEEE_P_2592010699, t4);
    t1 = (t0 + 7128U);
    t7 = *((char **)t1);
    t1 = (t7 + 0);
    *((unsigned char *)t1) = t10;
    goto LAB57;

LAB59:    xsi_set_current_line(350, ng0);
    t1 = (t0 + 6648U);
    t6 = *((char **)t1);
    t15 = *((int *)t6);
    t16 = (t15 - 7);
    t19 = (t16 * -1);
    t20 = (1 * t19);
    t21 = (0U + t20);
    t1 = (t0 + 10792);
    t7 = (t1 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t22 = *((char **)t9);
    *((unsigned char *)t22) = (unsigned char)2;
    xsi_driver_first_trans_delta(t1, t21, 1, 0LL);
    xsi_set_current_line(351, ng0);
    t1 = (t0 + 10856);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(352, ng0);
    t1 = (t0 + 7128U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 7128U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    *((unsigned char *)t1) = t3;
    goto LAB54;

LAB61:    xsi_set_current_line(364, ng0);
    t1 = (t0 + 7128U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t1 = (t0 + 3432U);
    t5 = *((char **)t1);
    t1 = (t0 + 6048U);
    t6 = *((char **)t1);
    t13 = *((int *)t6);
    t14 = (t13 - 1);
    t15 = (t14 - 7);
    t19 = (t15 * -1);
    t20 = (1U * t19);
    t21 = (0 + t20);
    t1 = (t5 + t21);
    t10 = *((unsigned char *)t1);
    t11 = (t4 == t10);
    if (t11 != 0)
        goto LAB64;

LAB66:    xsi_set_current_line(367, ng0);
    t1 = (t0 + 10728);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(368, ng0);
    t1 = (t0 + 10856);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);

LAB65:    goto LAB62;

LAB64:    xsi_set_current_line(365, ng0);
    t7 = (t0 + 10856);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t22 = (t9 + 56U);
    t23 = *((char **)t22);
    *((unsigned char *)t23) = (unsigned char)6;
    xsi_driver_first_trans_fast(t7);
    goto LAB65;

LAB67:    xsi_set_current_line(371, ng0);
    t1 = (t0 + 7128U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t1 = (t0 + 3432U);
    t5 = *((char **)t1);
    t1 = (t0 + 6048U);
    t6 = *((char **)t1);
    t13 = *((int *)t6);
    t14 = (t13 - 1);
    t15 = (t14 - 7);
    t19 = (t15 * -1);
    t20 = (1U * t19);
    t21 = (0 + t20);
    t1 = (t5 + t21);
    t10 = *((unsigned char *)t1);
    t11 = (t4 != t10);
    if (t11 != 0)
        goto LAB69;

LAB71:    xsi_set_current_line(374, ng0);
    t1 = (t0 + 10728);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(375, ng0);
    t1 = (t0 + 10856);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);

LAB70:    goto LAB62;

LAB69:    xsi_set_current_line(372, ng0);
    t7 = (t0 + 10856);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t22 = (t9 + 56U);
    t23 = *((char **)t22);
    *((unsigned char *)t23) = (unsigned char)6;
    xsi_driver_first_trans_fast(t7);
    goto LAB70;

LAB72:    xsi_set_current_line(385, ng0);
    t1 = (t0 + 6888U);
    t6 = *((char **)t1);
    t15 = *((int *)t6);
    t16 = (t15 + 1);
    t1 = (t0 + 6888U);
    t7 = *((char **)t1);
    t1 = (t7 + 0);
    *((int *)t1) = t16;
    xsi_set_current_line(386, ng0);
    t1 = (t0 + 10856);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)6;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(387, ng0);
    t1 = (t0 + 4072U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB75;

LAB77:
LAB76:    goto LAB73;

LAB75:    xsi_set_current_line(388, ng0);
    t1 = (t0 + 7008U);
    t5 = *((char **)t1);
    t13 = *((int *)t5);
    t14 = (t13 + 1);
    t1 = (t0 + 7008U);
    t6 = *((char **)t1);
    t1 = (t6 + 0);
    *((int *)t1) = t14;
    goto LAB76;

LAB78:    xsi_set_current_line(394, ng0);
    t1 = (t0 + 6888U);
    t7 = *((char **)t1);
    t1 = (t7 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(395, ng0);
    t1 = (t0 + 10856);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(396, ng0);
    t1 = (t0 + 10728);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB79;

}

static void work_a_3871240792_3212880686_p_5(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    unsigned char t10;
    unsigned char t11;
    unsigned char t12;
    unsigned char t13;
    unsigned char t14;
    char *t15;
    char *t16;
    char *t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    static char *nl0[] = {&&LAB11, &&LAB12, &&LAB13};

LAB0:    xsi_set_current_line(418, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t10 = (t4 == (unsigned char)3);
    if (t10 == 1)
        goto LAB7;

LAB8:    t3 = (unsigned char)0;

LAB9:    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 9992);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(419, ng0);
    t1 = (t0 + 10920);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(420, ng0);
    t1 = xsi_get_transient_memory(8U);
    memset(t1, 0, 8U);
    t2 = t1;
    memset(t2, (unsigned char)2, 8U);
    t5 = (t0 + 10984);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 8U);
    xsi_driver_first_trans_fast_port(t5);
    xsi_set_current_line(421, ng0);
    t1 = (t0 + 11048);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    goto LAB3;

LAB5:    xsi_set_current_line(425, ng0);
    t5 = (t0 + 3112U);
    t6 = *((char **)t5);
    t12 = *((unsigned char *)t6);
    t5 = (char *)((nl0) + t12);
    goto **((char **)t5);

LAB7:    t1 = (t0 + 992U);
    t11 = xsi_signal_has_event(t1);
    t3 = t11;
    goto LAB9;

LAB10:    goto LAB3;

LAB11:    xsi_set_current_line(428, ng0);
    t7 = (t0 + 3272U);
    t8 = *((char **)t7);
    t13 = *((unsigned char *)t8);
    t14 = (t13 == (unsigned char)3);
    if (t14 != 0)
        goto LAB14;

LAB16:    xsi_set_current_line(433, ng0);
    t1 = (t0 + 11048);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);

LAB15:    goto LAB10;

LAB12:    xsi_set_current_line(437, ng0);
    t1 = (t0 + 2472U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB17;

LAB19:    xsi_set_current_line(441, ng0);
    t1 = (t0 + 11048);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)1;
    xsi_driver_first_trans_fast(t1);

LAB18:    goto LAB10;

LAB13:    xsi_set_current_line(445, ng0);
    t1 = (t0 + 2472U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t10 = (t4 == (unsigned char)2);
    if (t10 == 1)
        goto LAB23;

LAB24:    t3 = (unsigned char)0;

LAB25:    if (t3 != 0)
        goto LAB20;

LAB22:    xsi_set_current_line(448, ng0);
    t1 = (t0 + 11048);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);

LAB21:    goto LAB10;

LAB14:    xsi_set_current_line(429, ng0);
    t7 = (t0 + 10920);
    t9 = (t7 + 56U);
    t15 = *((char **)t9);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    *((unsigned char *)t17) = (unsigned char)3;
    xsi_driver_first_trans_fast(t7);
    xsi_set_current_line(430, ng0);
    t1 = (t0 + 3432U);
    t2 = *((char **)t1);
    t18 = (7 - 7);
    t19 = (t18 * 1U);
    t20 = (0 + t19);
    t1 = (t2 + t20);
    t5 = (t0 + 10984);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 8U);
    xsi_driver_first_trans_fast_port(t5);
    xsi_set_current_line(431, ng0);
    t1 = (t0 + 11048);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)1;
    xsi_driver_first_trans_fast(t1);
    goto LAB15;

LAB17:    xsi_set_current_line(438, ng0);
    t1 = (t0 + 10920);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(439, ng0);
    t1 = (t0 + 11048);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    goto LAB18;

LAB20:    xsi_set_current_line(446, ng0);
    t1 = (t0 + 11048);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    goto LAB21;

LAB23:    t1 = (t0 + 3272U);
    t5 = *((char **)t1);
    t11 = *((unsigned char *)t5);
    t12 = (t11 == (unsigned char)2);
    t3 = t12;
    goto LAB25;

}

static void work_a_3871240792_3212880686_p_6(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    unsigned char t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;

LAB0:    xsi_set_current_line(456, ng0);

LAB3:    t1 = (t0 + 4552U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 2472U);
    t4 = *((char **)t1);
    t5 = *((unsigned char *)t4);
    t6 = ieee_p_2592010699_sub_374109322130769762_503743352(IEEE_P_2592010699, t5);
    t7 = ieee_p_2592010699_sub_3488768496604610246_503743352(IEEE_P_2592010699, t3, t6);
    t1 = (t0 + 11112);
    t8 = (t1 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    *((unsigned char *)t11) = t7;
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t12 = (t0 + 10008);
    *((int *)t12) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_3871240792_3212880686_init()
{
	static char *pe[] = {(void *)work_a_3871240792_3212880686_p_0,(void *)work_a_3871240792_3212880686_p_1,(void *)work_a_3871240792_3212880686_p_2,(void *)work_a_3871240792_3212880686_p_3,(void *)work_a_3871240792_3212880686_p_4,(void *)work_a_3871240792_3212880686_p_5,(void *)work_a_3871240792_3212880686_p_6};
	xsi_register_didat("work_a_3871240792_3212880686", "isim/NDLCOM_ECHO_TOP_isim_beh.exe.sim/work/a_3871240792_3212880686.didat");
	xsi_register_executes(pe);
}
