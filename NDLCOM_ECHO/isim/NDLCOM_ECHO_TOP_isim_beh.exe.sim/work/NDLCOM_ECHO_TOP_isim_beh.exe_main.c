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

#include "xsi.h"

struct XSI_INFO xsi_info;

char *IEEE_P_2592010699;
char *STD_STANDARD;
char *IEEE_P_3499444699;
char *IEEE_P_3620187407;
char *WORK_P_2501009807;
char *IEEE_P_1242562249;
char *WORK_P_2157098741;
char *IEEE_P_3972351953;
char *WORK_P_0289099879;
char *WORK_P_1959778622;
char *WORK_P_2412471419;
char *WORK_P_1238151018;
char *WORK_P_1620496033;
char *WORK_P_3004263874;
char *WORK_P_0199321727;
char *WORK_P_0079200049;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    ieee_p_2592010699_init();
    ieee_p_1242562249_init();
    work_p_2501009807_init();
    work_p_1238151018_init();
    work_p_1620496033_init();
    work_p_2412471419_init();
    work_p_3004263874_init();
    work_p_0079200049_init();
    work_p_0199321727_init();
    ieee_p_3499444699_init();
    ieee_p_3620187407_init();
    work_p_2157098741_init();
    ieee_p_3972351953_init();
    work_p_0289099879_init();
    work_a_0582614881_3212880686_init();
    work_p_1959778622_init();
    work_a_3898001175_3212880686_init();
    work_a_3930816929_3212880686_init();
    work_a_3871240792_3212880686_init();
    work_a_2633178274_3212880686_init();
    work_a_3142625882_3212880686_init();
    work_a_2445124471_3212880686_init();
    work_a_3459594644_3212880686_init();
    work_a_2921997880_3212880686_init();
    work_a_0889727244_3212880686_init();
    work_a_0414255901_3212880686_init();
    work_a_1082748125_3212880686_init();


    xsi_register_tops("work_a_1082748125_3212880686");

    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    IEEE_P_3499444699 = xsi_get_engine_memory("ieee_p_3499444699");
    IEEE_P_3620187407 = xsi_get_engine_memory("ieee_p_3620187407");
    WORK_P_2501009807 = xsi_get_engine_memory("work_p_2501009807");
    IEEE_P_1242562249 = xsi_get_engine_memory("ieee_p_1242562249");
    WORK_P_2157098741 = xsi_get_engine_memory("work_p_2157098741");
    IEEE_P_3972351953 = xsi_get_engine_memory("ieee_p_3972351953");
    WORK_P_0289099879 = xsi_get_engine_memory("work_p_0289099879");
    WORK_P_1959778622 = xsi_get_engine_memory("work_p_1959778622");
    WORK_P_2412471419 = xsi_get_engine_memory("work_p_2412471419");
    WORK_P_1238151018 = xsi_get_engine_memory("work_p_1238151018");
    WORK_P_1620496033 = xsi_get_engine_memory("work_p_1620496033");
    WORK_P_3004263874 = xsi_get_engine_memory("work_p_3004263874");
    WORK_P_0199321727 = xsi_get_engine_memory("work_p_0199321727");
    WORK_P_0079200049 = xsi_get_engine_memory("work_p_0079200049");

    return xsi_run_simulation(argc, argv);

}
