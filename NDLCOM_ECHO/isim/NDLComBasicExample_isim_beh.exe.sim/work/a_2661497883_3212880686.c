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
static const char *ng0 = "/home/sduvvuri/fpgaSVN/FPGA/designs/NDLCom/examples/basic/trunk/NDLComBasicExample.vhd";
extern char *IEEE_P_2592010699;
extern char *WORK_P_0199321727;
extern char *WORK_P_1620496033;
extern char *WORK_P_0079200049;
extern char *IEEE_P_1242562249;
extern char *WORK_P_3004263874;

char *ieee_p_1242562249_sub_10420449594411817395_1035706684(char *, char *, int , int );
unsigned char ieee_p_2592010699_sub_374109322130769762_503743352(char *, unsigned char );
void work_p_0199321727_sub_11450663464774703853_385979719(char *, char *, char *, unsigned int , unsigned int , char *, int , char *, char *);
void work_p_0199321727_sub_2759433519788890415_385979719(char *, char *, char *, unsigned int , unsigned int , char *, int , int , unsigned char );
char *work_p_0199321727_sub_3833549513974344379_385979719(char *, char *, char *, int );


static void work_a_2661497883_3212880686_p_0(char *t0)
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

LAB0:    xsi_set_current_line(140, ng0);

LAB3:    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = ieee_p_2592010699_sub_374109322130769762_503743352(IEEE_P_2592010699, t3);
    t1 = (t0 + 20032);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = t4;
    xsi_driver_first_trans_fast(t1);

LAB2:    t9 = (t0 + 19632);
    *((int *)t9) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_2661497883_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    xsi_set_current_line(142, ng0);

LAB3:    t1 = (t0 + 3432U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 20096);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = t3;
    xsi_driver_first_trans_delta(t1, 1U, 1, 0LL);

LAB2:    t8 = (t0 + 19648);
    *((int *)t8) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_2661497883_3212880686_p_2(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    xsi_set_current_line(143, ng0);

LAB3:    t1 = (t0 + 5032U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 20160);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = t3;
    xsi_driver_first_trans_delta(t1, 0U, 1, 0LL);

LAB2:    t8 = (t0 + 19664);
    *((int *)t8) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_2661497883_3212880686_p_3(char *t0)
{
    char t18[16];
    unsigned char t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    char *t9;
    unsigned char t10;
    unsigned char t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    int t19;
    unsigned int t20;
    int t21;
    int t22;
    int t23;
    int t24;
    unsigned int t25;
    unsigned int t26;
    char *t27;

LAB0:    xsi_set_current_line(205, ng0);
    t2 = (t0 + 992U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 19680);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(206, ng0);
    t8 = (t0 + 3112U);
    t9 = *((char **)t8);
    t10 = *((unsigned char *)t9);
    t11 = (t10 == (unsigned char)3);
    if (t11 != 0)
        goto LAB8;

LAB10:    xsi_set_current_line(215, ng0);
    t2 = (t0 + 20352);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(217, ng0);
    t2 = (t0 + 9672U);
    t4 = *((char **)t2);
    t2 = ((WORK_P_1620496033) + 1168U);
    t5 = *((char **)t2);
    t19 = *((int *)t5);
    t2 = work_p_0199321727_sub_3833549513974344379_385979719(WORK_P_0199321727, t18, t4, t19);
    t8 = (t18 + 12U);
    t20 = *((unsigned int *)t8);
    t20 = (t20 * 1U);
    t1 = (8U != t20);
    if (t1 == 1)
        goto LAB11;

LAB12:    t9 = (t0 + 20224);
    t12 = (t9 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t2, 8U);
    xsi_driver_first_trans_fast(t9);
    xsi_set_current_line(219, ng0);
    t2 = (t0 + 9672U);
    t4 = *((char **)t2);
    t2 = ((WORK_P_1620496033) + 4648U);
    t5 = *((char **)t2);
    t19 = *((int *)t5);
    t2 = work_p_0199321727_sub_3833549513974344379_385979719(WORK_P_0199321727, t18, t4, t19);
    t8 = ((WORK_P_1620496033) + 5608U);
    t9 = *((char **)t8);
    t21 = *((int *)t9);
    t8 = (t18 + 0U);
    t22 = *((int *)t8);
    t12 = (t18 + 8U);
    t23 = *((int *)t12);
    t24 = (t21 - t22);
    t20 = (t24 * t23);
    t25 = (1U * t20);
    t26 = (0 + t25);
    t13 = (t2 + t26);
    t1 = *((unsigned char *)t13);
    t14 = (t0 + 14248U);
    t15 = *((char **)t14);
    t14 = (t15 + 0);
    *((unsigned char *)t14) = t1;
    xsi_set_current_line(220, ng0);
    t2 = (t0 + 14248U);
    t4 = *((char **)t2);
    t3 = *((unsigned char *)t4);
    t6 = (t3 == (unsigned char)3);
    if (t6 == 1)
        goto LAB16;

LAB17:    t1 = (unsigned char)0;

LAB18:    if (t1 != 0)
        goto LAB13;

LAB15:
LAB14:    xsi_set_current_line(223, ng0);
    t2 = (t0 + 14248U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t2 = (t0 + 14128U);
    t5 = *((char **)t2);
    t2 = (t5 + 0);
    *((unsigned char *)t2) = t1;
    xsi_set_current_line(225, ng0);
    t2 = (t0 + 14368U);
    t4 = *((char **)t2);
    t3 = *((unsigned char *)t4);
    t6 = (t3 == (unsigned char)3);
    if (t6 == 1)
        goto LAB22;

LAB23:    t1 = (unsigned char)0;

LAB24:    if (t1 != 0)
        goto LAB19;

LAB21:
LAB20:    xsi_set_current_line(230, ng0);
    t2 = (t0 + 9672U);
    t4 = *((char **)t2);
    t2 = ((WORK_P_1620496033) + 4648U);
    t5 = *((char **)t2);
    t19 = *((int *)t5);
    t2 = work_p_0199321727_sub_3833549513974344379_385979719(WORK_P_0199321727, t18, t4, t19);
    t8 = ((WORK_P_1620496033) + 4768U);
    t9 = *((char **)t8);
    t21 = *((int *)t9);
    t8 = (t18 + 0U);
    t22 = *((int *)t8);
    t12 = (t18 + 8U);
    t23 = *((int *)t12);
    t24 = (t21 - t22);
    t20 = (t24 * t23);
    t25 = (1U * t20);
    t26 = (0 + t25);
    t13 = (t2 + t26);
    t1 = *((unsigned char *)t13);
    t14 = (t0 + 20288);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t27 = *((char **)t17);
    *((unsigned char *)t27) = t1;
    xsi_driver_first_trans_fast(t14);
    xsi_set_current_line(233, ng0);
    t2 = (t0 + 9672U);
    t4 = *((char **)t2);
    t2 = ((WORK_P_1620496033) + 10768U);
    t5 = *((char **)t2);
    t19 = *((int *)t5);
    t2 = work_p_0199321727_sub_3833549513974344379_385979719(WORK_P_0199321727, t18, t4, t19);
    t8 = (t18 + 12U);
    t20 = *((unsigned int *)t8);
    t20 = (t20 * 1U);
    t1 = (16U != t20);
    if (t1 == 1)
        goto LAB25;

LAB26:    t9 = (t0 + 20416);
    t12 = (t9 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t2, 16U);
    xsi_driver_first_trans_delta(t9, 240U, 16U, 0LL);
    xsi_set_current_line(236, ng0);
    t2 = xsi_get_transient_memory(16U);
    memset(t2, 0, 16U);
    t4 = t2;
    memset(t4, (unsigned char)2, 16U);
    t5 = (t0 + 20416);
    t8 = (t5 + 56U);
    t9 = *((char **)t8);
    t12 = (t9 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t2, 16U);
    xsi_driver_first_trans_delta(t5, 224U, 16U, 0LL);
    xsi_set_current_line(239, ng0);
    t2 = xsi_get_transient_memory(16U);
    memset(t2, 0, 16U);
    t4 = t2;
    memset(t4, (unsigned char)2, 16U);
    t5 = (t0 + 20416);
    t8 = (t5 + 56U);
    t9 = *((char **)t8);
    t12 = (t9 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t2, 16U);
    xsi_driver_first_trans_delta(t5, 208U, 16U, 0LL);

LAB9:    goto LAB3;

LAB5:    t4 = (t0 + 1032U);
    t5 = *((char **)t4);
    t4 = (t5 + 0);
    t6 = *((unsigned char *)t4);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_set_current_line(207, ng0);
    t8 = xsi_get_transient_memory(8U);
    memset(t8, 0, 8U);
    t12 = t8;
    memset(t12, (unsigned char)2, 8U);
    t13 = (t0 + 20224);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    memcpy(t17, t8, 8U);
    xsi_driver_first_trans_fast(t13);
    xsi_set_current_line(208, ng0);
    t2 = (t0 + 20288);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(209, ng0);
    t2 = (t0 + 20352);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(210, ng0);
    t2 = (t0 + 14128U);
    t4 = *((char **)t2);
    t2 = (t4 + 0);
    *((unsigned char *)t2) = (unsigned char)2;
    xsi_set_current_line(211, ng0);
    t2 = (t0 + 14248U);
    t4 = *((char **)t2);
    t2 = (t4 + 0);
    *((unsigned char *)t2) = (unsigned char)2;
    xsi_set_current_line(212, ng0);
    t2 = (t0 + 14368U);
    t4 = *((char **)t2);
    t2 = (t4 + 0);
    *((unsigned char *)t2) = (unsigned char)2;
    goto LAB9;

LAB11:    xsi_size_not_matching(8U, t20, 0);
    goto LAB12;

LAB13:    xsi_set_current_line(221, ng0);
    t2 = (t0 + 14368U);
    t8 = *((char **)t2);
    t2 = (t8 + 0);
    *((unsigned char *)t2) = (unsigned char)3;
    goto LAB14;

LAB16:    t2 = (t0 + 14128U);
    t5 = *((char **)t2);
    t7 = *((unsigned char *)t5);
    t10 = (t7 == (unsigned char)2);
    t1 = t10;
    goto LAB18;

LAB19:    xsi_set_current_line(226, ng0);
    t2 = (t0 + 20352);
    t8 = (t2 + 56U);
    t9 = *((char **)t8);
    t12 = (t9 + 56U);
    t13 = *((char **)t12);
    *((unsigned char *)t13) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(227, ng0);
    t2 = (t0 + 14368U);
    t4 = *((char **)t2);
    t2 = (t4 + 0);
    *((unsigned char *)t2) = (unsigned char)2;
    goto LAB20;

LAB22:    t2 = (t0 + 9832U);
    t5 = *((char **)t2);
    t7 = *((unsigned char *)t5);
    t10 = (t7 == (unsigned char)2);
    t1 = t10;
    goto LAB24;

LAB25:    xsi_size_not_matching(16U, t20, 0);
    goto LAB26;

}

static void work_a_2661497883_3212880686_p_4(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;

LAB0:    xsi_set_current_line(277, ng0);

LAB3:    t1 = (t0 + 20480);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);

LAB2:
LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_2661497883_3212880686_p_5(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;

LAB0:    xsi_set_current_line(278, ng0);

LAB3:    t1 = (t0 + 20544);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);

LAB2:
LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_2661497883_3212880686_p_6(char *t0)
{
    unsigned char t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    char *t9;
    unsigned char t10;
    unsigned char t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;

LAB0:    xsi_set_current_line(282, ng0);
    t2 = (t0 + 992U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 19696);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(283, ng0);
    t8 = (t0 + 3112U);
    t9 = *((char **)t8);
    t10 = *((unsigned char *)t9);
    t11 = (t10 == (unsigned char)3);
    if (t11 != 0)
        goto LAB8;

LAB10:    xsi_set_current_line(287, ng0);
    t2 = (t0 + 6152U);
    t4 = *((char **)t2);
    t3 = *((unsigned char *)t4);
    t6 = (t3 == (unsigned char)3);
    if (t6 == 1)
        goto LAB14;

LAB15:    t1 = (unsigned char)0;

LAB16:    if (t1 != 0)
        goto LAB11;

LAB13:    t2 = (t0 + 7912U);
    t4 = *((char **)t2);
    t3 = *((unsigned char *)t4);
    t6 = (t3 == (unsigned char)3);
    if (t6 == 1)
        goto LAB19;

LAB20:    t1 = (unsigned char)0;

LAB21:    if (t1 != 0)
        goto LAB17;

LAB18:    xsi_set_current_line(292, ng0);
    t2 = (t0 + 20608);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(293, ng0);
    t2 = (t0 + 20672);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);

LAB12:
LAB9:    goto LAB3;

LAB5:    t4 = (t0 + 1032U);
    t5 = *((char **)t4);
    t4 = (t5 + 0);
    t6 = *((unsigned char *)t4);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_set_current_line(284, ng0);
    t8 = (t0 + 20608);
    t12 = (t8 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    *((unsigned char *)t15) = (unsigned char)2;
    xsi_driver_first_trans_fast(t8);
    xsi_set_current_line(285, ng0);
    t2 = (t0 + 20672);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    goto LAB9;

LAB11:    xsi_set_current_line(288, ng0);
    t2 = (t0 + 20608);
    t8 = (t2 + 56U);
    t9 = *((char **)t8);
    t12 = (t9 + 56U);
    t13 = *((char **)t12);
    *((unsigned char *)t13) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    goto LAB12;

LAB14:    t2 = (t0 + 8072U);
    t5 = *((char **)t2);
    t7 = *((unsigned char *)t5);
    t10 = (t7 == (unsigned char)2);
    t1 = t10;
    goto LAB16;

LAB17:    xsi_set_current_line(290, ng0);
    t2 = (t0 + 20672);
    t8 = (t2 + 56U);
    t9 = *((char **)t8);
    t12 = (t9 + 56U);
    t13 = *((char **)t12);
    *((unsigned char *)t13) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    goto LAB12;

LAB19:    t2 = (t0 + 6312U);
    t5 = *((char **)t2);
    t7 = *((unsigned char *)t5);
    t10 = (t7 == (unsigned char)2);
    t1 = t10;
    goto LAB21;

}

static void work_a_2661497883_3212880686_p_7(char *t0)
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
    char *t10;
    char *t11;
    unsigned char t12;
    unsigned char t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;

LAB0:    xsi_set_current_line(299, ng0);
    t1 = (t0 + 6312U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB3;

LAB4:    t10 = (t0 + 8072U);
    t11 = *((char **)t10);
    t12 = *((unsigned char *)t11);
    t13 = (t12 == (unsigned char)3);
    if (t13 != 0)
        goto LAB5;

LAB6:
LAB7:    t19 = xsi_get_transient_memory(4U);
    memset(t19, 0, 4U);
    t20 = t19;
    memset(t20, (unsigned char)2, 4U);
    t21 = (t0 + 20736);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t19, 4U);
    xsi_driver_first_trans_fast(t21);

LAB2:    t26 = (t0 + 19712);
    *((int *)t26) = 1;

LAB1:    return;
LAB3:    t1 = (t0 + 6472U);
    t5 = *((char **)t1);
    t1 = (t0 + 20736);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t5, 4U);
    xsi_driver_first_trans_fast(t1);
    goto LAB2;

LAB5:    t10 = (t0 + 8232U);
    t14 = *((char **)t10);
    t10 = (t0 + 20736);
    t15 = (t10 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t14, 4U);
    xsi_driver_first_trans_fast(t10);
    goto LAB2;

LAB8:    goto LAB2;

}

static void work_a_2661497883_3212880686_p_8(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    unsigned char t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    unsigned char t13;
    unsigned char t14;
    char *t15;
    unsigned char t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;

LAB0:    xsi_set_current_line(302, ng0);
    t1 = (t0 + 6312U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB3;

LAB4:    t11 = (t0 + 8072U);
    t12 = *((char **)t11);
    t13 = *((unsigned char *)t12);
    t14 = (t13 == (unsigned char)3);
    if (t14 != 0)
        goto LAB5;

LAB6:
LAB7:    t21 = (t0 + 20800);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    *((unsigned char *)t25) = (unsigned char)2;
    xsi_driver_first_trans_fast(t21);

LAB2:    t26 = (t0 + 19728);
    *((int *)t26) = 1;

LAB1:    return;
LAB3:    t1 = (t0 + 6632U);
    t5 = *((char **)t1);
    t6 = *((unsigned char *)t5);
    t1 = (t0 + 20800);
    t7 = (t1 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = t6;
    xsi_driver_first_trans_fast(t1);
    goto LAB2;

LAB5:    t11 = (t0 + 8392U);
    t15 = *((char **)t11);
    t16 = *((unsigned char *)t15);
    t11 = (t0 + 20800);
    t17 = (t11 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    *((unsigned char *)t20) = t16;
    xsi_driver_first_trans_fast(t11);
    goto LAB2;

LAB8:    goto LAB2;

}

static void work_a_2661497883_3212880686_p_9(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    unsigned char t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    unsigned char t13;
    unsigned char t14;
    char *t15;
    unsigned char t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;

LAB0:    xsi_set_current_line(305, ng0);
    t1 = (t0 + 6312U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB3;

LAB4:    t11 = (t0 + 8072U);
    t12 = *((char **)t11);
    t13 = *((unsigned char *)t12);
    t14 = (t13 == (unsigned char)3);
    if (t14 != 0)
        goto LAB5;

LAB6:
LAB7:    t21 = (t0 + 20864);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    *((unsigned char *)t25) = (unsigned char)2;
    xsi_driver_first_trans_fast(t21);

LAB2:    t26 = (t0 + 19744);
    *((int *)t26) = 1;

LAB1:    return;
LAB3:    t1 = (t0 + 6792U);
    t5 = *((char **)t1);
    t6 = *((unsigned char *)t5);
    t1 = (t0 + 20864);
    t7 = (t1 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = t6;
    xsi_driver_first_trans_fast(t1);
    goto LAB2;

LAB5:    t11 = (t0 + 8552U);
    t15 = *((char **)t11);
    t16 = *((unsigned char *)t15);
    t11 = (t0 + 20864);
    t17 = (t11 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    *((unsigned char *)t20) = t16;
    xsi_driver_first_trans_fast(t11);
    goto LAB2;

LAB8:    goto LAB2;

}

static void work_a_2661497883_3212880686_p_10(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    unsigned char t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    unsigned char t13;
    unsigned char t14;
    char *t15;
    unsigned char t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;

LAB0:    xsi_set_current_line(308, ng0);
    t1 = (t0 + 6312U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB3;

LAB4:    t11 = (t0 + 8072U);
    t12 = *((char **)t11);
    t13 = *((unsigned char *)t12);
    t14 = (t13 == (unsigned char)3);
    if (t14 != 0)
        goto LAB5;

LAB6:
LAB7:    t21 = (t0 + 20928);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    *((unsigned char *)t25) = (unsigned char)2;
    xsi_driver_first_trans_fast(t21);

LAB2:    t26 = (t0 + 19760);
    *((int *)t26) = 1;

LAB1:    return;
LAB3:    t1 = (t0 + 6952U);
    t5 = *((char **)t1);
    t6 = *((unsigned char *)t5);
    t1 = (t0 + 20928);
    t7 = (t1 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = t6;
    xsi_driver_first_trans_fast(t1);
    goto LAB2;

LAB5:    t11 = (t0 + 8712U);
    t15 = *((char **)t11);
    t16 = *((unsigned char *)t15);
    t11 = (t0 + 20928);
    t17 = (t11 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    *((unsigned char *)t20) = t16;
    xsi_driver_first_trans_fast(t11);
    goto LAB2;

LAB8:    goto LAB2;

}

static void work_a_2661497883_3212880686_p_11(char *t0)
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
    char *t10;
    char *t11;
    unsigned char t12;
    unsigned char t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;

LAB0:    xsi_set_current_line(311, ng0);
    t1 = (t0 + 6312U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB3;

LAB4:    t10 = (t0 + 8072U);
    t11 = *((char **)t10);
    t12 = *((unsigned char *)t11);
    t13 = (t12 == (unsigned char)3);
    if (t13 != 0)
        goto LAB5;

LAB6:
LAB7:    t19 = xsi_get_transient_memory(24U);
    memset(t19, 0, 24U);
    t20 = t19;
    memset(t20, (unsigned char)2, 24U);
    t21 = (t0 + 20992);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t19, 24U);
    xsi_driver_first_trans_fast(t21);

LAB2:    t26 = (t0 + 19776);
    *((int *)t26) = 1;

LAB1:    return;
LAB3:    t1 = (t0 + 7112U);
    t5 = *((char **)t1);
    t1 = (t0 + 20992);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t5, 24U);
    xsi_driver_first_trans_fast(t1);
    goto LAB2;

LAB5:    t10 = (t0 + 8872U);
    t14 = *((char **)t10);
    t10 = (t0 + 20992);
    t15 = (t10 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t14, 24U);
    xsi_driver_first_trans_fast(t10);
    goto LAB2;

LAB8:    goto LAB2;

}

static void work_a_2661497883_3212880686_p_12(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    unsigned char t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    unsigned char t13;
    unsigned char t14;
    char *t15;
    unsigned char t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;

LAB0:    xsi_set_current_line(314, ng0);
    t1 = (t0 + 6312U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB3;

LAB4:    t11 = (t0 + 8072U);
    t12 = *((char **)t11);
    t13 = *((unsigned char *)t12);
    t14 = (t13 == (unsigned char)3);
    if (t14 != 0)
        goto LAB5;

LAB6:
LAB7:    t21 = (t0 + 21056);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    *((unsigned char *)t25) = (unsigned char)2;
    xsi_driver_first_trans_fast(t21);

LAB2:    t26 = (t0 + 19792);
    *((int *)t26) = 1;

LAB1:    return;
LAB3:    t1 = (t0 + 7592U);
    t5 = *((char **)t1);
    t6 = *((unsigned char *)t5);
    t1 = (t0 + 21056);
    t7 = (t1 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = t6;
    xsi_driver_first_trans_fast(t1);
    goto LAB2;

LAB5:    t11 = (t0 + 9352U);
    t15 = *((char **)t11);
    t16 = *((unsigned char *)t15);
    t11 = (t0 + 21056);
    t17 = (t11 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    *((unsigned char *)t20) = t16;
    xsi_driver_first_trans_fast(t11);
    goto LAB2;

LAB8:    goto LAB2;

}

static void work_a_2661497883_3212880686_p_13(char *t0)
{
    char t15[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    unsigned char t12;
    unsigned char t13;
    char *t14;
    char *t16;
    char *t17;
    unsigned int t18;
    unsigned char t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;

LAB0:    xsi_set_current_line(317, ng0);
    t1 = (t0 + 6312U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB3;

LAB4:    t10 = (t0 + 8072U);
    t11 = *((char **)t10);
    t12 = *((unsigned char *)t11);
    t13 = (t12 == (unsigned char)3);
    if (t13 != 0)
        goto LAB5;

LAB6:
LAB9:    t25 = xsi_get_transient_memory(8U);
    memset(t25, 0, 8U);
    t26 = t25;
    memset(t26, (unsigned char)2, 8U);
    t27 = (t0 + 21120);
    t28 = (t27 + 56U);
    t29 = *((char **)t28);
    t30 = (t29 + 56U);
    t31 = *((char **)t30);
    memcpy(t31, t25, 8U);
    xsi_driver_first_trans_fast(t27);

LAB2:    t32 = (t0 + 19808);
    *((int *)t32) = 1;

LAB1:    return;
LAB3:    t1 = (t0 + 7272U);
    t5 = *((char **)t1);
    t1 = (t0 + 21120);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t5, 8U);
    xsi_driver_first_trans_fast(t1);
    goto LAB2;

LAB5:    t10 = (t0 + 9032U);
    t14 = *((char **)t10);
    t16 = ((IEEE_P_2592010699) + 4000);
    t17 = (t0 + 35456U);
    t10 = xsi_base_array_concat(t10, t15, t16, (char)99, (unsigned char)2, (char)97, t14, t17, (char)101);
    t18 = (1U + 7U);
    t19 = (8U != t18);
    if (t19 == 1)
        goto LAB7;

LAB8:    t20 = (t0 + 21120);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    memcpy(t24, t10, 8U);
    xsi_driver_first_trans_fast(t20);
    goto LAB2;

LAB7:    xsi_size_not_matching(8U, t18, 0);
    goto LAB8;

LAB10:    goto LAB2;

}

static void work_a_2661497883_3212880686_p_14(char *t0)
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
    char *t10;
    char *t11;
    unsigned char t12;
    unsigned char t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;

LAB0:    xsi_set_current_line(320, ng0);
    t1 = (t0 + 6312U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB3;

LAB4:    t10 = (t0 + 8072U);
    t11 = *((char **)t10);
    t12 = *((unsigned char *)t11);
    t13 = (t12 == (unsigned char)3);
    if (t13 != 0)
        goto LAB5;

LAB6:
LAB7:    t19 = xsi_get_transient_memory(8U);
    memset(t19, 0, 8U);
    t20 = t19;
    memset(t20, (unsigned char)2, 8U);
    t21 = (t0 + 21184);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t19, 8U);
    xsi_driver_first_trans_fast(t21);

LAB2:    t26 = (t0 + 19824);
    *((int *)t26) = 1;

LAB1:    return;
LAB3:    t1 = (t0 + 7432U);
    t5 = *((char **)t1);
    t1 = (t0 + 21184);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t5, 8U);
    xsi_driver_first_trans_fast(t1);
    goto LAB2;

LAB5:    t10 = (t0 + 9192U);
    t14 = *((char **)t10);
    t10 = (t0 + 21184);
    t15 = (t10 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t14, 8U);
    xsi_driver_first_trans_fast(t10);
    goto LAB2;

LAB8:    goto LAB2;

}

static void work_a_2661497883_3212880686_p_15(char *t0)
{
    char t15[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    unsigned char t12;
    unsigned char t13;
    char *t14;
    char *t16;
    char *t17;
    unsigned int t18;
    unsigned char t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;

LAB0:    xsi_set_current_line(323, ng0);
    t1 = (t0 + 6312U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB3;

LAB4:    t10 = (t0 + 8072U);
    t11 = *((char **)t10);
    t12 = *((unsigned char *)t11);
    t13 = (t12 == (unsigned char)3);
    if (t13 != 0)
        goto LAB5;

LAB6:
LAB9:    t25 = xsi_get_transient_memory(8U);
    memset(t25, 0, 8U);
    t26 = t25;
    memset(t26, (unsigned char)2, 8U);
    t27 = (t0 + 21248);
    t28 = (t27 + 56U);
    t29 = *((char **)t28);
    t30 = (t29 + 56U);
    t31 = *((char **)t30);
    memcpy(t31, t25, 8U);
    xsi_driver_first_trans_fast(t27);

LAB2:    t32 = (t0 + 19840);
    *((int *)t32) = 1;

LAB1:    return;
LAB3:    t1 = (t0 + 7752U);
    t5 = *((char **)t1);
    t1 = (t0 + 21248);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t5, 8U);
    xsi_driver_first_trans_fast(t1);
    goto LAB2;

LAB5:    t10 = (t0 + 9512U);
    t14 = *((char **)t10);
    t16 = ((IEEE_P_2592010699) + 4000);
    t17 = (t0 + 35488U);
    t10 = xsi_base_array_concat(t10, t15, t16, (char)99, (unsigned char)2, (char)97, t14, t17, (char)101);
    t18 = (1U + 7U);
    t19 = (8U != t18);
    if (t19 == 1)
        goto LAB7;

LAB8:    t20 = (t0 + 21248);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    memcpy(t24, t10, 8U);
    xsi_driver_first_trans_fast(t20);
    goto LAB2;

LAB7:    xsi_size_not_matching(8U, t18, 0);
    goto LAB8;

LAB10:    goto LAB2;

}

static void work_a_2661497883_3212880686_p_16(char *t0)
{
    char t23[8];
    char t24[8];
    char t25[8];
    char t26[8];
    char t27[16];
    char t29[8];
    unsigned char t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    char *t9;
    unsigned char t10;
    unsigned char t11;
    char *t12;
    unsigned int t13;
    char *t14;
    unsigned char t15;
    unsigned int t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    int t22;
    int t28;

LAB0:    xsi_set_current_line(334, ng0);
    t2 = (t0 + 992U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 19856);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(335, ng0);
    t8 = (t0 + 3112U);
    t9 = *((char **)t8);
    t10 = *((unsigned char *)t9);
    t11 = (t10 == (unsigned char)3);
    if (t11 != 0)
        goto LAB8;

LAB10:    xsi_set_current_line(339, ng0);
    t2 = (t0 + 19120);
    t4 = (t0 + 9632U);
    t5 = (t0 + 21312);
    t8 = ((WORK_P_1620496033) + 1288U);
    t9 = *((char **)t8);
    t22 = *((int *)t9);
    t8 = ((WORK_P_0079200049) + 1168U);
    t12 = *((char **)t8);
    memcpy(t23, t12, 8U);
    t8 = ((WORK_P_0079200049) + 4192U);
    work_p_0199321727_sub_11450663464774703853_385979719(WORK_P_0199321727, t2, t4, 0U, 0U, t5, t22, t23, t8);
    xsi_set_current_line(340, ng0);
    t2 = (t0 + 19120);
    t4 = (t0 + 9632U);
    t5 = (t0 + 21312);
    t8 = ((WORK_P_1620496033) + 1408U);
    t9 = *((char **)t8);
    t22 = *((int *)t9);
    t8 = ((WORK_P_0079200049) + 1288U);
    t12 = *((char **)t8);
    memcpy(t24, t12, 8U);
    t8 = ((WORK_P_0079200049) + 4208U);
    work_p_0199321727_sub_11450663464774703853_385979719(WORK_P_0199321727, t2, t4, 0U, 0U, t5, t22, t24, t8);
    xsi_set_current_line(341, ng0);
    t2 = (t0 + 19120);
    t4 = (t0 + 9632U);
    t5 = (t0 + 21312);
    t8 = ((WORK_P_1620496033) + 1528U);
    t9 = *((char **)t8);
    t22 = *((int *)t9);
    t8 = ((WORK_P_0079200049) + 1408U);
    t12 = *((char **)t8);
    memcpy(t25, t12, 8U);
    t8 = ((WORK_P_0079200049) + 4224U);
    work_p_0199321727_sub_11450663464774703853_385979719(WORK_P_0199321727, t2, t4, 0U, 0U, t5, t22, t25, t8);
    xsi_set_current_line(342, ng0);
    t2 = (t0 + 19120);
    t4 = (t0 + 9632U);
    t5 = (t0 + 21312);
    t8 = ((WORK_P_1620496033) + 1648U);
    t9 = *((char **)t8);
    t22 = *((int *)t9);
    t8 = ((WORK_P_0079200049) + 1528U);
    t12 = *((char **)t8);
    memcpy(t26, t12, 8U);
    t8 = ((WORK_P_0079200049) + 4240U);
    work_p_0199321727_sub_11450663464774703853_385979719(WORK_P_0199321727, t2, t4, 0U, 0U, t5, t22, t26, t8);
    xsi_set_current_line(344, ng0);
    t2 = (t0 + 19120);
    t4 = (t0 + 9632U);
    t5 = (t0 + 21312);
    t8 = ((WORK_P_1620496033) + 1768U);
    t9 = *((char **)t8);
    t22 = *((int *)t9);
    t8 = ((WORK_P_3004263874) + 1168U);
    t12 = *((char **)t8);
    t28 = *((int *)t12);
    t8 = ieee_p_1242562249_sub_10420449594411817395_1035706684(IEEE_P_1242562249, t27, t28, 8);
    memcpy(t29, t8, 8U);
    work_p_0199321727_sub_11450663464774703853_385979719(WORK_P_0199321727, t2, t4, 0U, 0U, t5, t22, t29, t27);
    xsi_set_current_line(347, ng0);
    t2 = (t0 + 19120);
    t4 = (t0 + 9632U);
    t5 = (t0 + 21312);
    t8 = ((WORK_P_1620496033) + 10768U);
    t9 = *((char **)t8);
    t22 = *((int *)t9);
    t8 = ((WORK_P_1620496033) + 10888U);
    t12 = *((char **)t8);
    t28 = *((int *)t12);
    t8 = (t0 + 3432U);
    t14 = *((char **)t8);
    t1 = *((unsigned char *)t14);
    work_p_0199321727_sub_2759433519788890415_385979719(WORK_P_0199321727, t2, t4, 0U, 0U, t5, t22, t28, t1);

LAB9:    goto LAB3;

LAB5:    t4 = (t0 + 1032U);
    t5 = *((char **)t4);
    t4 = (t5 + 0);
    t6 = *((unsigned char *)t4);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_set_current_line(336, ng0);
    t8 = xsi_get_transient_memory(456U);
    memset(t8, 0, 456U);
    t12 = t8;
    t13 = (8U * 1U);
    t14 = t12;
    memset(t14, (unsigned char)2, t13);
    t15 = (t13 != 0);
    if (t15 == 1)
        goto LAB11;

LAB12:    t17 = (t0 + 21312);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t8, 456U);
    xsi_driver_first_trans_delta(t17, 1104U, 456U, 0LL);
    goto LAB9;

LAB11:    t16 = (456U / t13);
    xsi_mem_set_data(t12, t12, t13, t16);
    goto LAB12;

}


extern void work_a_2661497883_3212880686_init()
{
	static char *pe[] = {(void *)work_a_2661497883_3212880686_p_0,(void *)work_a_2661497883_3212880686_p_1,(void *)work_a_2661497883_3212880686_p_2,(void *)work_a_2661497883_3212880686_p_3,(void *)work_a_2661497883_3212880686_p_4,(void *)work_a_2661497883_3212880686_p_5,(void *)work_a_2661497883_3212880686_p_6,(void *)work_a_2661497883_3212880686_p_7,(void *)work_a_2661497883_3212880686_p_8,(void *)work_a_2661497883_3212880686_p_9,(void *)work_a_2661497883_3212880686_p_10,(void *)work_a_2661497883_3212880686_p_11,(void *)work_a_2661497883_3212880686_p_12,(void *)work_a_2661497883_3212880686_p_13,(void *)work_a_2661497883_3212880686_p_14,(void *)work_a_2661497883_3212880686_p_15,(void *)work_a_2661497883_3212880686_p_16};
	xsi_register_didat("work_a_2661497883_3212880686", "isim/NDLComBasicExample_isim_beh.exe.sim/work/a_2661497883_3212880686.didat");
	xsi_register_executes(pe);
}
