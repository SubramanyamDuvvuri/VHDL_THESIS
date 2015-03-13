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
static const char *ng0 = "/home/sduvvuri/fpgaSVN/FPGA/lib/spi_prom/trunk/simple_spiprom_interface.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_1242562249;

char *ieee_p_1242562249_sub_10420449594411817395_1035706684(char *, char *, int , int );
unsigned char ieee_p_2592010699_sub_3488546069778340532_503743352(char *, unsigned char , unsigned char );
unsigned char ieee_p_2592010699_sub_374109322130769762_503743352(char *, unsigned char );


static void work_a_3459594644_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    xsi_set_current_line(92, ng0);

LAB3:    t1 = (t0 + 4712U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 9920);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = t3;
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t8 = (t0 + 9776);
    *((int *)t8) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_3459594644_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    xsi_set_current_line(93, ng0);

LAB3:    t1 = (t0 + 4552U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 9984);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = t3;
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t8 = (t0 + 9792);
    *((int *)t8) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_3459594644_3212880686_p_2(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    unsigned char t8;
    unsigned char t9;
    char *t10;
    unsigned char t11;
    unsigned char t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;

LAB0:    xsi_set_current_line(95, ng0);

LAB3:    t1 = (t0 + 5192U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 2152U);
    t4 = *((char **)t1);
    t5 = *((unsigned char *)t4);
    t6 = ieee_p_2592010699_sub_3488546069778340532_503743352(IEEE_P_2592010699, t3, t5);
    t1 = (t0 + 2312U);
    t7 = *((char **)t1);
    t8 = *((unsigned char *)t7);
    t9 = ieee_p_2592010699_sub_3488546069778340532_503743352(IEEE_P_2592010699, t6, t8);
    t1 = (t0 + 2472U);
    t10 = *((char **)t1);
    t11 = *((unsigned char *)t10);
    t12 = ieee_p_2592010699_sub_3488546069778340532_503743352(IEEE_P_2592010699, t9, t11);
    t1 = (t0 + 10048);
    t13 = (t1 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    *((unsigned char *)t16) = t12;
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t17 = (t0 + 9808);
    *((int *)t17) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_3459594644_3212880686_p_3(char *t0)
{
    unsigned char t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    int t12;
    int t13;
    int t14;
    int t15;
    int t16;
    char *t17;

LAB0:    xsi_set_current_line(126, ng0);
    t2 = (t0 + 992U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 9824);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(127, ng0);
    t4 = (t0 + 1192U);
    t8 = *((char **)t4);
    t9 = *((unsigned char *)t8);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB8;

LAB10:    xsi_set_current_line(134, ng0);
    t2 = (t0 + 10112);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(135, ng0);
    t2 = (t0 + 10176);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(137, ng0);
    t2 = (t0 + 7008U);
    t4 = *((char **)t2);
    t12 = *((int *)t4);
    t2 = (t0 + 6288U);
    t5 = *((char **)t2);
    t13 = *((int *)t5);
    t14 = (t13 - 1);
    t1 = (t12 < t14);
    if (t1 != 0)
        goto LAB11;

LAB13:    xsi_set_current_line(140, ng0);
    t2 = (t0 + 7008U);
    t4 = *((char **)t2);
    t2 = (t4 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(141, ng0);
    t2 = (t0 + 4712U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t3 = ieee_p_2592010699_sub_374109322130769762_503743352(IEEE_P_2592010699, t1);
    t2 = (t0 + 10240);
    t5 = (t2 + 56U);
    t8 = *((char **)t5);
    t11 = (t8 + 56U);
    t17 = *((char **)t11);
    *((unsigned char *)t17) = t3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(142, ng0);
    t2 = (t0 + 4712U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t3 = (t1 == (unsigned char)2);
    if (t3 != 0)
        goto LAB14;

LAB16:    xsi_set_current_line(145, ng0);
    t2 = (t0 + 10176);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);

LAB15:
LAB12:
LAB9:    goto LAB3;

LAB5:    t4 = (t0 + 1032U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_set_current_line(128, ng0);
    t4 = (t0 + 7008U);
    t11 = *((char **)t4);
    t4 = (t11 + 0);
    *((int *)t4) = 0;
    xsi_set_current_line(129, ng0);
    t2 = (t0 + 10112);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(130, ng0);
    t2 = (t0 + 10176);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(131, ng0);
    t2 = (t0 + 10240);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    goto LAB9;

LAB11:    xsi_set_current_line(138, ng0);
    t2 = (t0 + 7008U);
    t8 = *((char **)t2);
    t15 = *((int *)t8);
    t16 = (t15 + 1);
    t2 = (t0 + 7008U);
    t11 = *((char **)t2);
    t2 = (t11 + 0);
    *((int *)t2) = t16;
    goto LAB12;

LAB14:    xsi_set_current_line(143, ng0);
    t2 = (t0 + 10112);
    t5 = (t2 + 56U);
    t8 = *((char **)t5);
    t11 = (t8 + 56U);
    t17 = *((char **)t11);
    *((unsigned char *)t17) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    goto LAB15;

}

static void work_a_3459594644_3212880686_p_4(char *t0)
{
    char t25[16];
    unsigned char t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    unsigned int t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    int t19;
    int t20;
    int t21;
    unsigned int t22;
    unsigned int t23;
    int t24;
    static char *nl0[] = {&&LAB12, &&LAB13, &&LAB14, &&LAB15, &&LAB16, &&LAB17, &&LAB18};

LAB0:    xsi_set_current_line(160, ng0);
    t2 = (t0 + 992U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 9840);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(161, ng0);
    t4 = (t0 + 1192U);
    t8 = *((char **)t4);
    t9 = *((unsigned char *)t8);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB8;

LAB10:    xsi_set_current_line(176, ng0);
    t2 = (t0 + 10496);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(178, ng0);
    t2 = (t0 + 5352U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t2 = (char *)((nl0) + t1);
    goto **((char **)t2);

LAB5:    t4 = (t0 + 1032U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_set_current_line(162, ng0);
    t4 = (t0 + 7128U);
    t11 = *((char **)t4);
    t4 = (t11 + 0);
    *((unsigned char *)t4) = (unsigned char)2;
    xsi_set_current_line(163, ng0);
    t2 = (t0 + 7248U);
    t4 = *((char **)t2);
    t2 = (t4 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(164, ng0);
    t2 = (t0 + 7368U);
    t4 = *((char **)t2);
    t2 = (t4 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(165, ng0);
    t2 = xsi_get_transient_memory(8U);
    memset(t2, 0, 8U);
    t4 = t2;
    memset(t4, (unsigned char)2, 8U);
    t5 = (t0 + 7488U);
    t8 = *((char **)t5);
    t5 = (t8 + 0);
    memcpy(t5, t2, 8U);
    xsi_set_current_line(167, ng0);
    t2 = (t0 + 10304);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(168, ng0);
    t2 = (t0 + 10368);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t2);
    xsi_set_current_line(170, ng0);
    t2 = xsi_get_transient_memory(8U);
    memset(t2, 0, 8U);
    t4 = t2;
    memset(t4, (unsigned char)2, 8U);
    t5 = (t0 + 10432);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t2, 8U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(171, ng0);
    t2 = (t0 + 10496);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(173, ng0);
    t2 = (t0 + 10560);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)0;
    xsi_driver_first_trans_fast(t2);

LAB9:    goto LAB3;

LAB11:    goto LAB9;

LAB12:    xsi_set_current_line(183, ng0);
    t5 = (t0 + 7248U);
    t8 = *((char **)t5);
    t5 = (t8 + 0);
    *((int *)t5) = 0;
    xsi_set_current_line(184, ng0);
    t2 = (t0 + 10624);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(185, ng0);
    t2 = (t0 + 2152U);
    t4 = *((char **)t2);
    t3 = *((unsigned char *)t4);
    t6 = (t3 == (unsigned char)3);
    if (t6 == 1)
        goto LAB22;

LAB23:    t1 = (unsigned char)0;

LAB24:    if (t1 != 0)
        goto LAB19;

LAB21:    t2 = (t0 + 2312U);
    t4 = *((char **)t2);
    t3 = *((unsigned char *)t4);
    t6 = (t3 == (unsigned char)3);
    if (t6 == 1)
        goto LAB33;

LAB34:    t1 = (unsigned char)0;

LAB35:    if (t1 != 0)
        goto LAB31;

LAB32:    t2 = (t0 + 2472U);
    t4 = *((char **)t2);
    t3 = *((unsigned char *)t4);
    t6 = (t3 == (unsigned char)3);
    if (t6 == 1)
        goto LAB44;

LAB45:    t1 = (unsigned char)0;

LAB46:    if (t1 != 0)
        goto LAB42;

LAB43:
LAB20:    goto LAB11;

LAB13:    xsi_set_current_line(201, ng0);
    t2 = (t0 + 5032U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t3 = (t1 == (unsigned char)3);
    if (t3 != 0)
        goto LAB53;

LAB55:
LAB54:    goto LAB11;

LAB14:    xsi_set_current_line(216, ng0);
    t2 = (t0 + 5032U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t3 = (t1 == (unsigned char)3);
    if (t3 != 0)
        goto LAB59;

LAB61:
LAB60:    goto LAB11;

LAB15:    xsi_set_current_line(237, ng0);
    t2 = (t0 + 5032U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t3 = (t1 == (unsigned char)3);
    if (t3 != 0)
        goto LAB74;

LAB76:
LAB75:    goto LAB11;

LAB16:    xsi_set_current_line(264, ng0);
    t2 = (t0 + 5032U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t3 = (t1 == (unsigned char)3);
    if (t3 != 0)
        goto LAB97;

LAB99:
LAB98:    goto LAB11;

LAB17:    xsi_set_current_line(287, ng0);
    t2 = (t0 + 4872U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t3 = (t1 == (unsigned char)3);
    if (t3 != 0)
        goto LAB106;

LAB108:
LAB107:    goto LAB11;

LAB18:    xsi_set_current_line(327, ng0);
    t2 = (t0 + 5032U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t3 = (t1 == (unsigned char)3);
    if (t3 != 0)
        goto LAB130;

LAB132:
LAB131:    goto LAB11;

LAB19:    xsi_set_current_line(186, ng0);
    t13 = (t0 + 10624);
    t15 = (t13 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    *((unsigned char *)t18) = (unsigned char)3;
    xsi_driver_first_trans_fast(t13);
    xsi_set_current_line(187, ng0);
    t2 = (t0 + 6528U);
    t4 = *((char **)t2);
    t2 = (t0 + 10432);
    t5 = (t2 + 56U);
    t8 = *((char **)t5);
    t11 = (t8 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t4, 8U);
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(188, ng0);
    t2 = (t0 + 10560);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)1;
    xsi_driver_first_trans_fast(t2);
    goto LAB20;

LAB22:    t2 = (t0 + 1992U);
    t5 = *((char **)t2);
    t2 = (t0 + 18240);
    t7 = 1;
    if (4U == 4U)
        goto LAB25;

LAB26:    t7 = 0;

LAB27:    t1 = t7;
    goto LAB24;

LAB25:    t14 = 0;

LAB28:    if (t14 < 4U)
        goto LAB29;
    else
        goto LAB27;

LAB29:    t11 = (t5 + t14);
    t12 = (t2 + t14);
    if (*((unsigned char *)t11) != *((unsigned char *)t12))
        goto LAB26;

LAB30:    t14 = (t14 + 1);
    goto LAB28;

LAB31:    xsi_set_current_line(190, ng0);
    t13 = (t0 + 10624);
    t15 = (t13 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    *((unsigned char *)t18) = (unsigned char)3;
    xsi_driver_first_trans_fast(t13);
    xsi_set_current_line(191, ng0);
    t2 = (t0 + 6648U);
    t4 = *((char **)t2);
    t2 = (t0 + 10432);
    t5 = (t2 + 56U);
    t8 = *((char **)t5);
    t11 = (t8 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t4, 8U);
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(192, ng0);
    t2 = (t0 + 10560);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)1;
    xsi_driver_first_trans_fast(t2);
    goto LAB20;

LAB33:    t2 = (t0 + 1992U);
    t5 = *((char **)t2);
    t2 = (t0 + 18244);
    t7 = 1;
    if (4U == 4U)
        goto LAB36;

LAB37:    t7 = 0;

LAB38:    t1 = t7;
    goto LAB35;

LAB36:    t14 = 0;

LAB39:    if (t14 < 4U)
        goto LAB40;
    else
        goto LAB38;

LAB40:    t11 = (t5 + t14);
    t12 = (t2 + t14);
    if (*((unsigned char *)t11) != *((unsigned char *)t12))
        goto LAB37;

LAB41:    t14 = (t14 + 1);
    goto LAB39;

LAB42:    xsi_set_current_line(194, ng0);
    t13 = (t0 + 10624);
    t15 = (t13 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    *((unsigned char *)t18) = (unsigned char)3;
    xsi_driver_first_trans_fast(t13);
    xsi_set_current_line(195, ng0);
    t2 = (t0 + 6768U);
    t4 = *((char **)t2);
    t2 = (t0 + 10432);
    t5 = (t2 + 56U);
    t8 = *((char **)t5);
    t11 = (t8 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t4, 8U);
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(196, ng0);
    t2 = (t0 + 10560);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    goto LAB20;

LAB44:    t2 = (t0 + 1992U);
    t5 = *((char **)t2);
    t2 = (t0 + 18248);
    t7 = 1;
    if (4U == 4U)
        goto LAB47;

LAB48:    t7 = 0;

LAB49:    t1 = t7;
    goto LAB46;

LAB47:    t14 = 0;

LAB50:    if (t14 < 4U)
        goto LAB51;
    else
        goto LAB49;

LAB51:    t11 = (t5 + t14);
    t12 = (t2 + t14);
    if (*((unsigned char *)t11) != *((unsigned char *)t12))
        goto LAB48;

LAB52:    t14 = (t14 + 1);
    goto LAB50;

LAB53:    xsi_set_current_line(202, ng0);
    t2 = (t0 + 7248U);
    t5 = *((char **)t2);
    t19 = *((int *)t5);
    t6 = (t19 < 8);
    if (t6 != 0)
        goto LAB56;

LAB58:    xsi_set_current_line(208, ng0);
    t2 = (t0 + 10304);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(209, ng0);
    t2 = (t0 + 7248U);
    t4 = *((char **)t2);
    t2 = (t4 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(210, ng0);
    t2 = (t0 + 10560);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);

LAB57:    goto LAB54;

LAB56:    xsi_set_current_line(203, ng0);
    t2 = (t0 + 10304);
    t8 = (t2 + 56U);
    t11 = *((char **)t8);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    *((unsigned char *)t13) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(204, ng0);
    t2 = (t0 + 6408U);
    t4 = *((char **)t2);
    t2 = (t0 + 7248U);
    t5 = *((char **)t2);
    t19 = *((int *)t5);
    t20 = (7 - t19);
    t21 = (t20 - 7);
    t14 = (t21 * -1);
    xsi_vhdl_check_range_of_index(7, 0, -1, t20);
    t22 = (1U * t14);
    t23 = (0 + t22);
    t2 = (t4 + t23);
    t1 = *((unsigned char *)t2);
    t8 = (t0 + 10368);
    t11 = (t8 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t15 = *((char **)t13);
    *((unsigned char *)t15) = t1;
    xsi_driver_first_trans_fast_port(t8);
    xsi_set_current_line(205, ng0);
    t2 = (t0 + 7248U);
    t4 = *((char **)t2);
    t19 = *((int *)t4);
    t20 = (t19 + 1);
    t2 = (t0 + 7248U);
    t5 = *((char **)t2);
    t2 = (t5 + 0);
    *((int *)t2) = t20;
    xsi_set_current_line(206, ng0);
    t2 = (t0 + 10560);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)1;
    xsi_driver_first_trans_fast(t2);
    goto LAB57;

LAB59:    xsi_set_current_line(217, ng0);
    t2 = (t0 + 10304);
    t5 = (t2 + 56U);
    t8 = *((char **)t5);
    t11 = (t8 + 56U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(218, ng0);
    t2 = (t0 + 5512U);
    t4 = *((char **)t2);
    t2 = (t0 + 7248U);
    t5 = *((char **)t2);
    t19 = *((int *)t5);
    t20 = (7 - t19);
    t21 = (t20 - 7);
    t14 = (t21 * -1);
    xsi_vhdl_check_range_of_index(7, 0, -1, t20);
    t22 = (1U * t14);
    t23 = (0 + t22);
    t2 = (t4 + t23);
    t1 = *((unsigned char *)t2);
    t8 = (t0 + 10368);
    t11 = (t8 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t15 = *((char **)t13);
    *((unsigned char *)t15) = t1;
    xsi_driver_first_trans_fast_port(t8);
    xsi_set_current_line(219, ng0);
    t2 = (t0 + 7248U);
    t4 = *((char **)t2);
    t19 = *((int *)t4);
    t1 = (t19 < 7);
    if (t1 != 0)
        goto LAB62;

LAB64:    xsi_set_current_line(223, ng0);
    t2 = (t0 + 7248U);
    t4 = *((char **)t2);
    t2 = (t4 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(224, ng0);
    t2 = (t0 + 7368U);
    t4 = *((char **)t2);
    t2 = (t4 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(225, ng0);
    t2 = (t0 + 5512U);
    t4 = *((char **)t2);
    t2 = (t0 + 6888U);
    t5 = *((char **)t2);
    t1 = 1;
    if (8U == 8U)
        goto LAB68;

LAB69:    t1 = 0;

LAB70:    if ((!(t1)) != 0)
        goto LAB65;

LAB67:    xsi_set_current_line(230, ng0);
    t2 = (t0 + 10560);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)5;
    xsi_driver_first_trans_fast(t2);

LAB66:
LAB63:    goto LAB60;

LAB62:    xsi_set_current_line(220, ng0);
    t2 = (t0 + 7248U);
    t5 = *((char **)t2);
    t20 = *((int *)t5);
    t21 = (t20 + 1);
    t2 = (t0 + 7248U);
    t8 = *((char **)t2);
    t2 = (t8 + 0);
    *((int *)t2) = t21;
    xsi_set_current_line(221, ng0);
    t2 = (t0 + 10560);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    goto LAB63;

LAB65:    xsi_set_current_line(227, ng0);
    t11 = (t0 + 10560);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t15 = (t13 + 56U);
    t16 = *((char **)t15);
    *((unsigned char *)t16) = (unsigned char)3;
    xsi_driver_first_trans_fast(t11);
    goto LAB66;

LAB68:    t14 = 0;

LAB71:    if (t14 < 8U)
        goto LAB72;
    else
        goto LAB70;

LAB72:    t2 = (t4 + t14);
    t8 = (t5 + t14);
    if (*((unsigned char *)t2) != *((unsigned char *)t8))
        goto LAB69;

LAB73:    t14 = (t14 + 1);
    goto LAB71;

LAB74:    xsi_set_current_line(238, ng0);
    t2 = (t0 + 10304);
    t5 = (t2 + 56U);
    t8 = *((char **)t5);
    t11 = (t8 + 56U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(239, ng0);
    t2 = (t0 + 2792U);
    t4 = *((char **)t2);
    t2 = (t0 + 7248U);
    t5 = *((char **)t2);
    t19 = *((int *)t5);
    t20 = (23 - t19);
    t21 = (t20 - 23);
    t14 = (t21 * -1);
    xsi_vhdl_check_range_of_index(23, 0, -1, t20);
    t22 = (1U * t14);
    t23 = (0 + t22);
    t2 = (t4 + t23);
    t1 = *((unsigned char *)t2);
    t8 = (t0 + 10368);
    t11 = (t8 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t15 = *((char **)t13);
    *((unsigned char *)t15) = t1;
    xsi_driver_first_trans_fast_port(t8);
    xsi_set_current_line(240, ng0);
    t2 = (t0 + 7248U);
    t4 = *((char **)t2);
    t19 = *((int *)t4);
    t1 = (t19 < 23);
    if (t1 != 0)
        goto LAB77;

LAB79:    xsi_set_current_line(244, ng0);
    t2 = (t0 + 7248U);
    t4 = *((char **)t2);
    t2 = (t4 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(245, ng0);
    t2 = (t0 + 7368U);
    t4 = *((char **)t2);
    t2 = (t4 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(246, ng0);
    t2 = (t0 + 5512U);
    t4 = *((char **)t2);
    t2 = (t0 + 6648U);
    t5 = *((char **)t2);
    t1 = 1;
    if (8U == 8U)
        goto LAB83;

LAB84:    t1 = 0;

LAB85:    if (t1 != 0)
        goto LAB80;

LAB82:    t2 = (t0 + 5512U);
    t4 = *((char **)t2);
    t2 = (t0 + 6768U);
    t5 = *((char **)t2);
    t1 = 1;
    if (8U == 8U)
        goto LAB91;

LAB92:    t1 = 0;

LAB93:    if (t1 != 0)
        goto LAB89;

LAB90:    xsi_set_current_line(256, ng0);
    t2 = (t0 + 6888U);
    t4 = *((char **)t2);
    t2 = (t0 + 10432);
    t5 = (t2 + 56U);
    t8 = *((char **)t5);
    t11 = (t8 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t4, 8U);
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(257, ng0);
    t2 = (t0 + 10560);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)6;
    xsi_driver_first_trans_fast(t2);

LAB81:
LAB78:    goto LAB75;

LAB77:    xsi_set_current_line(241, ng0);
    t2 = (t0 + 7248U);
    t5 = *((char **)t2);
    t20 = *((int *)t5);
    t21 = (t20 + 1);
    t2 = (t0 + 7248U);
    t8 = *((char **)t2);
    t2 = (t8 + 0);
    *((int *)t2) = t21;
    xsi_set_current_line(242, ng0);
    t2 = (t0 + 10560);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    goto LAB78;

LAB80:    xsi_set_current_line(248, ng0);
    t11 = xsi_get_transient_memory(8U);
    memset(t11, 0, 8U);
    t12 = t11;
    memset(t12, (unsigned char)2, 8U);
    t13 = (t0 + 10688);
    t15 = (t13 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t11, 8U);
    xsi_driver_first_trans_fast(t13);
    xsi_set_current_line(249, ng0);
    t2 = (t0 + 10560);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)4;
    xsi_driver_first_trans_fast(t2);
    goto LAB81;

LAB83:    t14 = 0;

LAB86:    if (t14 < 8U)
        goto LAB87;
    else
        goto LAB85;

LAB87:    t2 = (t4 + t14);
    t8 = (t5 + t14);
    if (*((unsigned char *)t2) != *((unsigned char *)t8))
        goto LAB84;

LAB88:    t14 = (t14 + 1);
    goto LAB86;

LAB89:    xsi_set_current_line(252, ng0);
    t11 = (t0 + 7128U);
    t12 = *((char **)t11);
    t11 = (t12 + 0);
    *((unsigned char *)t11) = (unsigned char)3;
    xsi_set_current_line(253, ng0);
    t2 = (t0 + 10560);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)5;
    xsi_driver_first_trans_fast(t2);
    goto LAB81;

LAB91:    t14 = 0;

LAB94:    if (t14 < 8U)
        goto LAB95;
    else
        goto LAB93;

LAB95:    t2 = (t4 + t14);
    t8 = (t5 + t14);
    if (*((unsigned char *)t2) != *((unsigned char *)t8))
        goto LAB92;

LAB96:    t14 = (t14 + 1);
    goto LAB94;

LAB97:    xsi_set_current_line(265, ng0);
    t2 = (t0 + 10304);
    t5 = (t2 + 56U);
    t8 = *((char **)t5);
    t11 = (t8 + 56U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(266, ng0);
    t2 = (t0 + 4392U);
    t4 = *((char **)t2);
    t2 = (t0 + 7248U);
    t5 = *((char **)t2);
    t19 = *((int *)t5);
    t20 = (7 - t19);
    t21 = (t20 - 7);
    t14 = (t21 * -1);
    xsi_vhdl_check_range_of_index(7, 0, -1, t20);
    t22 = (1U * t14);
    t23 = (0 + t22);
    t2 = (t4 + t23);
    t1 = *((unsigned char *)t2);
    t8 = (t0 + 10368);
    t11 = (t8 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t15 = *((char **)t13);
    *((unsigned char *)t15) = t1;
    xsi_driver_first_trans_fast_port(t8);
    xsi_set_current_line(267, ng0);
    t2 = (t0 + 7248U);
    t4 = *((char **)t2);
    t19 = *((int *)t4);
    t1 = (t19 < 7);
    if (t1 != 0)
        goto LAB100;

LAB102:    xsi_set_current_line(271, ng0);
    t2 = (t0 + 7248U);
    t4 = *((char **)t2);
    t2 = (t4 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(272, ng0);
    t2 = (t0 + 7368U);
    t4 = *((char **)t2);
    t19 = *((int *)t4);
    t20 = (128 - 1);
    t1 = (t19 < t20);
    if (t1 != 0)
        goto LAB103;

LAB105:    xsi_set_current_line(278, ng0);
    t2 = (t0 + 7368U);
    t4 = *((char **)t2);
    t2 = (t4 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(279, ng0);
    t2 = (t0 + 6888U);
    t4 = *((char **)t2);
    t2 = (t0 + 10432);
    t5 = (t2 + 56U);
    t8 = *((char **)t5);
    t11 = (t8 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t4, 8U);
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(280, ng0);
    t2 = (t0 + 10560);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)6;
    xsi_driver_first_trans_fast(t2);

LAB104:
LAB101:    goto LAB98;

LAB100:    xsi_set_current_line(268, ng0);
    t2 = (t0 + 7248U);
    t5 = *((char **)t2);
    t20 = *((int *)t5);
    t21 = (t20 + 1);
    t2 = (t0 + 7248U);
    t8 = *((char **)t2);
    t2 = (t8 + 0);
    *((int *)t2) = t21;
    xsi_set_current_line(269, ng0);
    t2 = (t0 + 10560);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)4;
    xsi_driver_first_trans_fast(t2);
    goto LAB101;

LAB103:    xsi_set_current_line(273, ng0);
    t2 = (t0 + 7368U);
    t5 = *((char **)t2);
    t21 = *((int *)t5);
    t24 = (t21 + 1);
    t2 = (t0 + 7368U);
    t8 = *((char **)t2);
    t2 = (t8 + 0);
    *((int *)t2) = t24;
    xsi_set_current_line(274, ng0);
    t2 = (t0 + 7368U);
    t4 = *((char **)t2);
    t19 = *((int *)t4);
    t2 = ieee_p_1242562249_sub_10420449594411817395_1035706684(IEEE_P_1242562249, t25, t19, 8);
    t5 = (t0 + 10688);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t2, 8U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(275, ng0);
    t2 = (t0 + 10560);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)4;
    xsi_driver_first_trans_fast(t2);
    goto LAB104;

LAB106:    xsi_set_current_line(288, ng0);
    t2 = (t0 + 7128U);
    t5 = *((char **)t2);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    if (t7 != 0)
        goto LAB109;

LAB111:    xsi_set_current_line(293, ng0);
    t2 = (t0 + 10304);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(294, ng0);
    t2 = (t0 + 1832U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t2 = (t0 + 7488U);
    t5 = *((char **)t2);
    t2 = (t0 + 7248U);
    t8 = *((char **)t2);
    t19 = *((int *)t8);
    t20 = (7 - t19);
    t21 = (t20 - 7);
    t14 = (t21 * -1);
    xsi_vhdl_check_range_of_index(7, 0, -1, t20);
    t22 = (1U * t14);
    t23 = (0 + t22);
    t2 = (t5 + t23);
    *((unsigned char *)t2) = t1;
    xsi_set_current_line(295, ng0);
    t2 = (t0 + 7248U);
    t4 = *((char **)t2);
    t19 = *((int *)t4);
    t1 = (t19 < 7);
    if (t1 != 0)
        goto LAB112;

LAB114:    xsi_set_current_line(299, ng0);
    t2 = (t0 + 7248U);
    t4 = *((char **)t2);
    t2 = (t4 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(300, ng0);
    t2 = (t0 + 5512U);
    t4 = *((char **)t2);
    t2 = (t0 + 6888U);
    t5 = *((char **)t2);
    t1 = 1;
    if (8U == 8U)
        goto LAB118;

LAB119:    t1 = 0;

LAB120:    if ((!(t1)) != 0)
        goto LAB115;

LAB117:    xsi_set_current_line(313, ng0);
    t2 = (t0 + 7488U);
    t4 = *((char **)t2);
    t19 = (0 - 7);
    t14 = (t19 * -1);
    t22 = (1U * t14);
    t23 = (0 + t22);
    t2 = (t4 + t23);
    t1 = *((unsigned char *)t2);
    t3 = (t1 == (unsigned char)2);
    if (t3 != 0)
        goto LAB127;

LAB129:    xsi_set_current_line(318, ng0);
    t2 = (t0 + 10560);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)5;
    xsi_driver_first_trans_fast(t2);

LAB128:
LAB116:
LAB113:
LAB110:    goto LAB107;

LAB109:    xsi_set_current_line(291, ng0);
    t2 = (t0 + 7128U);
    t8 = *((char **)t2);
    t2 = (t8 + 0);
    *((unsigned char *)t2) = (unsigned char)2;
    goto LAB110;

LAB112:    xsi_set_current_line(296, ng0);
    t2 = (t0 + 7248U);
    t5 = *((char **)t2);
    t20 = *((int *)t5);
    t21 = (t20 + 1);
    t2 = (t0 + 7248U);
    t8 = *((char **)t2);
    t2 = (t8 + 0);
    *((int *)t2) = t21;
    xsi_set_current_line(297, ng0);
    t2 = (t0 + 10560);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)5;
    xsi_driver_first_trans_fast(t2);
    goto LAB113;

LAB115:    xsi_set_current_line(301, ng0);
    t11 = (t0 + 7368U);
    t12 = *((char **)t11);
    t19 = *((int *)t12);
    t11 = ieee_p_1242562249_sub_10420449594411817395_1035706684(IEEE_P_1242562249, t25, t19, 8);
    t13 = (t0 + 10752);
    t15 = (t13 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t11, 8U);
    xsi_driver_first_trans_fast(t13);
    xsi_set_current_line(302, ng0);
    t2 = (t0 + 7488U);
    t4 = *((char **)t2);
    t2 = (t0 + 10816);
    t5 = (t2 + 56U);
    t8 = *((char **)t5);
    t11 = (t8 + 56U);
    t12 = *((char **)t11);
    memcpy(t12, t4, 8U);
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(303, ng0);
    t2 = (t0 + 10496);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(304, ng0);
    t2 = (t0 + 7368U);
    t4 = *((char **)t2);
    t19 = *((int *)t4);
    t20 = (128 - 1);
    t1 = (t19 < t20);
    if (t1 != 0)
        goto LAB124;

LAB126:    xsi_set_current_line(309, ng0);
    t2 = (t0 + 7368U);
    t4 = *((char **)t2);
    t2 = (t4 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(310, ng0);
    t2 = (t0 + 10560);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)6;
    xsi_driver_first_trans_fast(t2);

LAB125:    goto LAB116;

LAB118:    t14 = 0;

LAB121:    if (t14 < 8U)
        goto LAB122;
    else
        goto LAB120;

LAB122:    t2 = (t4 + t14);
    t8 = (t5 + t14);
    if (*((unsigned char *)t2) != *((unsigned char *)t8))
        goto LAB119;

LAB123:    t14 = (t14 + 1);
    goto LAB121;

LAB124:    xsi_set_current_line(305, ng0);
    t2 = (t0 + 7368U);
    t5 = *((char **)t2);
    t21 = *((int *)t5);
    t24 = (t21 + 1);
    t2 = (t0 + 7368U);
    t8 = *((char **)t2);
    t2 = (t8 + 0);
    *((int *)t2) = t24;
    xsi_set_current_line(306, ng0);
    t2 = (t0 + 10560);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)5;
    xsi_driver_first_trans_fast(t2);
    goto LAB125;

LAB127:    xsi_set_current_line(315, ng0);
    t5 = xsi_get_transient_memory(8U);
    memset(t5, 0, 8U);
    t8 = t5;
    memset(t8, (unsigned char)2, 8U);
    t11 = (t0 + 10432);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t15 = (t13 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t5, 8U);
    xsi_driver_first_trans_fast(t11);
    xsi_set_current_line(316, ng0);
    t2 = (t0 + 10560);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)6;
    xsi_driver_first_trans_fast(t2);
    goto LAB128;

LAB130:    xsi_set_current_line(328, ng0);
    t2 = (t0 + 10304);
    t5 = (t2 + 56U);
    t8 = *((char **)t5);
    t11 = (t8 + 56U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(329, ng0);
    t2 = (t0 + 5512U);
    t4 = *((char **)t2);
    t2 = (t0 + 6888U);
    t5 = *((char **)t2);
    t1 = 1;
    if (8U == 8U)
        goto LAB136;

LAB137:    t1 = 0;

LAB138:    if (t1 != 0)
        goto LAB133;

LAB135:    xsi_set_current_line(334, ng0);
    t2 = (t0 + 10560);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)0;
    xsi_driver_first_trans_fast(t2);

LAB134:    goto LAB131;

LAB133:    xsi_set_current_line(331, ng0);
    t11 = (t0 + 10560);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t15 = (t13 + 56U);
    t16 = *((char **)t15);
    *((unsigned char *)t16) = (unsigned char)2;
    xsi_driver_first_trans_fast(t11);
    goto LAB134;

LAB136:    t14 = 0;

LAB139:    if (t14 < 8U)
        goto LAB140;
    else
        goto LAB138;

LAB140:    t2 = (t4 + t14);
    t8 = (t5 + t14);
    if (*((unsigned char *)t2) != *((unsigned char *)t8))
        goto LAB137;

LAB141:    t14 = (t14 + 1);
    goto LAB139;

}


extern void work_a_3459594644_3212880686_init()
{
	static char *pe[] = {(void *)work_a_3459594644_3212880686_p_0,(void *)work_a_3459594644_3212880686_p_1,(void *)work_a_3459594644_3212880686_p_2,(void *)work_a_3459594644_3212880686_p_3,(void *)work_a_3459594644_3212880686_p_4};
	xsi_register_didat("work_a_3459594644_3212880686", "isim/NDLCOM_ECHO_TOP_isim_beh.exe.sim/work/a_3459594644_3212880686.didat");
	xsi_register_executes(pe);
}
