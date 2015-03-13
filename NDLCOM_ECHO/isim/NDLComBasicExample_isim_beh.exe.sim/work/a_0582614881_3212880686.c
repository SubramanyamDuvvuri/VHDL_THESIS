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
static const char *ng0 = "/home/sduvvuri/fpgaSVN/FPGA/lib/rtc_mod/trunk/rtc_mod.vhd";
extern char *IEEE_P_3620187407;

char *ieee_p_3620187407_sub_2255506239096166994_3965413181(char *, char *, char *, char *, int );


static void work_a_0582614881_3212880686_p_0(char *t0)
{
    char t19[16];
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
    int t14;
    int t15;
    int t16;
    int t17;
    int t18;
    unsigned int t20;
    unsigned int t21;

LAB0:    xsi_set_current_line(54, ng0);
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
LAB3:    t2 = (t0 + 4704);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(55, ng0);
    t7 = (t0 + 1192U);
    t8 = *((char **)t7);
    t9 = *((unsigned char *)t8);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB8;

LAB10:    xsi_set_current_line(66, ng0);
    t2 = (t0 + 1512U);
    t3 = *((char **)t2);
    t1 = *((unsigned char *)t3);
    t4 = (t1 == (unsigned char)3);
    if (t4 != 0)
        goto LAB11;

LAB13:    t2 = (t0 + 2688U);
    t3 = *((char **)t2);
    t14 = *((int *)t3);
    t2 = (t0 + 2088U);
    t7 = *((char **)t2);
    t15 = *((int *)t7);
    t16 = (t15 - 1);
    t1 = (t14 < t16);
    if (t1 != 0)
        goto LAB14;

LAB15:    t2 = (t0 + 3168U);
    t3 = *((char **)t2);
    t14 = *((int *)t3);
    t1 = (t14 > 0);
    if (t1 != 0)
        goto LAB16;

LAB17:    t2 = (t0 + 3288U);
    t3 = *((char **)t2);
    t14 = *((int *)t3);
    t1 = (t14 > 0);
    if (t1 != 0)
        goto LAB18;

LAB19:    t2 = (t0 + 3408U);
    t3 = *((char **)t2);
    t14 = *((int *)t3);
    t1 = (t14 > 0);
    if (t1 != 0)
        goto LAB20;

LAB21:    xsi_set_current_line(93, ng0);
    t2 = (t0 + 2688U);
    t3 = *((char **)t2);
    t2 = (t3 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(94, ng0);
    t2 = (t0 + 2568U);
    t3 = *((char **)t2);
    t2 = (t0 + 8232U);
    t7 = ieee_p_3620187407_sub_2255506239096166994_3965413181(IEEE_P_3620187407, t19, t3, t2, 1);
    t8 = (t0 + 2568U);
    t11 = *((char **)t8);
    t8 = (t11 + 0);
    t12 = (t19 + 12U);
    t20 = *((unsigned int *)t12);
    t21 = (1U * t20);
    memcpy(t8, t7, t21);
    xsi_set_current_line(96, ng0);
    t2 = (t0 + 2808U);
    t3 = *((char **)t2);
    t14 = *((int *)t3);
    t1 = (t14 < 9);
    if (t1 != 0)
        goto LAB22;

LAB24:    xsi_set_current_line(100, ng0);
    t2 = (t0 + 2808U);
    t3 = *((char **)t2);
    t2 = (t3 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(101, ng0);
    t2 = (t0 + 2208U);
    t3 = *((char **)t2);
    t14 = *((int *)t3);
    t2 = (t0 + 3168U);
    t7 = *((char **)t2);
    t2 = (t7 + 0);
    *((int *)t2) = t14;

LAB23:    xsi_set_current_line(104, ng0);
    t2 = (t0 + 2928U);
    t3 = *((char **)t2);
    t14 = *((int *)t3);
    t1 = (t14 < 99);
    if (t1 != 0)
        goto LAB25;

LAB27:    xsi_set_current_line(108, ng0);
    t2 = (t0 + 2928U);
    t3 = *((char **)t2);
    t2 = (t3 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(109, ng0);
    t2 = (t0 + 2328U);
    t3 = *((char **)t2);
    t14 = *((int *)t3);
    t2 = (t0 + 3288U);
    t7 = *((char **)t2);
    t2 = (t7 + 0);
    *((int *)t2) = t14;

LAB26:    xsi_set_current_line(112, ng0);
    t2 = (t0 + 3048U);
    t3 = *((char **)t2);
    t14 = *((int *)t3);
    t1 = (t14 < 999);
    if (t1 != 0)
        goto LAB28;

LAB30:    xsi_set_current_line(116, ng0);
    t2 = (t0 + 3048U);
    t3 = *((char **)t2);
    t2 = (t3 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(117, ng0);
    t2 = (t0 + 2448U);
    t3 = *((char **)t2);
    t14 = *((int *)t3);
    t2 = (t0 + 3408U);
    t7 = *((char **)t2);
    t2 = (t7 + 0);
    *((int *)t2) = t14;

LAB29:
LAB12:
LAB9:    xsi_set_current_line(122, ng0);
    t2 = (t0 + 2568U);
    t3 = *((char **)t2);
    t2 = (t0 + 4784);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t11 = (t8 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t3, 64U);
    xsi_driver_first_trans_fast_port(t2);
    goto LAB3;

LAB5:    t2 = (t0 + 992U);
    t6 = xsi_signal_has_event(t2);
    t1 = t6;
    goto LAB7;

LAB8:    xsi_set_current_line(56, ng0);
    t7 = xsi_get_transient_memory(64U);
    memset(t7, 0, 64U);
    t11 = t7;
    memset(t11, (unsigned char)2, 64U);
    t12 = (t0 + 2568U);
    t13 = *((char **)t12);
    t12 = (t13 + 0);
    memcpy(t12, t7, 64U);
    xsi_set_current_line(57, ng0);
    t2 = (t0 + 2688U);
    t3 = *((char **)t2);
    t2 = (t3 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(58, ng0);
    t2 = (t0 + 2808U);
    t3 = *((char **)t2);
    t2 = (t3 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(59, ng0);
    t2 = (t0 + 2928U);
    t3 = *((char **)t2);
    t2 = (t3 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(60, ng0);
    t2 = (t0 + 3048U);
    t3 = *((char **)t2);
    t2 = (t3 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(61, ng0);
    t2 = (t0 + 3168U);
    t3 = *((char **)t2);
    t2 = (t3 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(62, ng0);
    t2 = (t0 + 3288U);
    t3 = *((char **)t2);
    t2 = (t3 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(63, ng0);
    t2 = (t0 + 3408U);
    t3 = *((char **)t2);
    t2 = (t3 + 0);
    *((int *)t2) = 0;
    goto LAB9;

LAB11:    xsi_set_current_line(67, ng0);
    t2 = (t0 + 1672U);
    t7 = *((char **)t2);
    t2 = (t0 + 2568U);
    t8 = *((char **)t2);
    t2 = (t8 + 0);
    memcpy(t2, t7, 64U);
    xsi_set_current_line(68, ng0);
    t2 = (t0 + 2688U);
    t3 = *((char **)t2);
    t2 = (t3 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(69, ng0);
    t2 = (t0 + 2808U);
    t3 = *((char **)t2);
    t2 = (t3 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(70, ng0);
    t2 = (t0 + 2928U);
    t3 = *((char **)t2);
    t2 = (t3 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(71, ng0);
    t2 = (t0 + 3048U);
    t3 = *((char **)t2);
    t2 = (t3 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(72, ng0);
    t2 = (t0 + 3168U);
    t3 = *((char **)t2);
    t2 = (t3 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(73, ng0);
    t2 = (t0 + 3288U);
    t3 = *((char **)t2);
    t2 = (t3 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(74, ng0);
    t2 = (t0 + 3408U);
    t3 = *((char **)t2);
    t2 = (t3 + 0);
    *((int *)t2) = 0;
    goto LAB12;

LAB14:    xsi_set_current_line(77, ng0);
    t2 = (t0 + 2688U);
    t8 = *((char **)t2);
    t17 = *((int *)t8);
    t18 = (t17 + 1);
    t2 = (t0 + 2688U);
    t11 = *((char **)t2);
    t2 = (t11 + 0);
    *((int *)t2) = t18;
    goto LAB12;

LAB16:    xsi_set_current_line(81, ng0);
    t2 = (t0 + 3168U);
    t7 = *((char **)t2);
    t15 = *((int *)t7);
    t16 = (t15 - 1);
    t2 = (t0 + 3168U);
    t8 = *((char **)t2);
    t2 = (t8 + 0);
    *((int *)t2) = t16;
    goto LAB12;

LAB18:    xsi_set_current_line(85, ng0);
    t2 = (t0 + 3288U);
    t7 = *((char **)t2);
    t15 = *((int *)t7);
    t16 = (t15 - 1);
    t2 = (t0 + 3288U);
    t8 = *((char **)t2);
    t2 = (t8 + 0);
    *((int *)t2) = t16;
    goto LAB12;

LAB20:    xsi_set_current_line(89, ng0);
    t2 = (t0 + 3408U);
    t7 = *((char **)t2);
    t15 = *((int *)t7);
    t16 = (t15 - 1);
    t2 = (t0 + 3408U);
    t8 = *((char **)t2);
    t2 = (t8 + 0);
    *((int *)t2) = t16;
    goto LAB12;

LAB22:    xsi_set_current_line(97, ng0);
    t2 = (t0 + 2808U);
    t7 = *((char **)t2);
    t15 = *((int *)t7);
    t16 = (t15 + 1);
    t2 = (t0 + 2808U);
    t8 = *((char **)t2);
    t2 = (t8 + 0);
    *((int *)t2) = t16;
    goto LAB23;

LAB25:    xsi_set_current_line(105, ng0);
    t2 = (t0 + 2928U);
    t7 = *((char **)t2);
    t15 = *((int *)t7);
    t16 = (t15 + 1);
    t2 = (t0 + 2928U);
    t8 = *((char **)t2);
    t2 = (t8 + 0);
    *((int *)t2) = t16;
    goto LAB26;

LAB28:    xsi_set_current_line(113, ng0);
    t2 = (t0 + 3048U);
    t7 = *((char **)t2);
    t15 = *((int *)t7);
    t16 = (t15 + 1);
    t2 = (t0 + 3048U);
    t8 = *((char **)t2);
    t2 = (t8 + 0);
    *((int *)t2) = t16;
    goto LAB29;

}


extern void work_a_0582614881_3212880686_init()
{
	static char *pe[] = {(void *)work_a_0582614881_3212880686_p_0};
	xsi_register_didat("work_a_0582614881_3212880686", "isim/NDLComBasicExample_isim_beh.exe.sim/work/a_0582614881_3212880686.didat");
	xsi_register_executes(pe);
}
