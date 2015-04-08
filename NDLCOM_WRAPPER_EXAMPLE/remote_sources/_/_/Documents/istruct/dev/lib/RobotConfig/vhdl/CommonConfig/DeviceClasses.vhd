-- GENERATED FILE. DO NOT MODIFY, CHANGES WILL BE LOST!

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.register_types.all;

package deviceclasses is

    -- ------------------------ --
    -- DeviceClass Register Ids --
    -- ------------------------ --

    -- NDLCom
    constant NDLCom_NODE_ID                            : integer := 0;  --! Current node id

    -- FPGAJoint
    constant FPGAJoint_SYNTHESIS_YEAR                  : integer := 1;  --! Synthesis date (year)
    constant FPGAJoint_SYNTHESIS_MONTH                 : integer := 2;  --! Synthesis date (month)
    constant FPGAJoint_SYNTHESIS_DAY                   : integer := 3;  --! Synthesis date (day)
    constant FPGAJoint_SYNTHESIS_AUTHOR                : integer := 4;  --! Synthesis author

    -- BLDCJoint
    constant BLDCJoint_STACK_VERSION                   : integer := 5;  --! BLDC Stack version (V1-V3 = 1-3, BLDC2 = 4)
    constant BLDCJoint_TICKS_PER_TURN                  : integer := 6;  --! Encoder ticks per turn (360 degree at joint)
    constant BLDCJoint_INVERT_CONFIG                   : integer := 10;  --! Configuration register to invert PWM, Pos/Speed, Current, ...
        constant BLDCJoint_INVERT_CONFIG_PWM_BIT                : integer := 0; --! Invert PWM
        constant BLDCJoint_INVERT_CONFIG_POS_BIT                : integer := 1; --! Invert Pos/Speed
        constant BLDCJoint_INVERT_CONFIG_CUR_BIT                : integer := 2; --! Invert Current
        constant BLDCJoint_INVERT_CONFIG_ABS_POS_BIT            : integer := 3; --! Invert Absolute Position
    constant BLDCJoint_ABS_POS_OFFSET                  : integer := 14;  --! Absolute position sensor offset, signed ticks
    constant BLDCJoint_ICHAUS_GCC                      : integer := 16;  --! iC-Haus gcc (amplitude ratio) configuration value
    constant BLDCJoint_ICHAUS_VOSS                     : integer := 17;  --! iC-Haus voss (sine offset) configuration value
    constant BLDCJoint_ICHAUS_VOSC                     : integer := 18;  --! iC-Haus vosc (cosine offset) configuration value
    constant BLDCJoint_CUR_FILTER_DAMPING              : integer := 19;  --! Filter damping setting x -> damping 2**-x (bits 4-0) for current
    constant BLDCJoint_VEL_FILTER_DAMPING              : integer := 20;  --! Filter damping setting x -> damping 2**-x (bits 4-0) for velocity
    constant BLDCJoint_ACC_FILTER_DAMPING              : integer := 21;  --! Filter damping setting x -> damping 2**-x (bits 4-0) for acceleration
    constant BLDCJoint_PWM_FILTER_DAMPING              : integer := 22;  --! Filter damping setting x -> damping 2**-x (bits 4-0) for acceleration
    constant BLDCJoint_INIT_ERROR_IGNORE               : integer := 23;  --! Initial error ignore settings (Errors -> Warnings)
    constant BLDCJoint_INIT_ERROR_DISABLE              : integer := 24;  --! Initial error disable settings
    constant BLDCJoint_ERROR_IGNORE                    : integer := 25;  --! Register to set error ignore bits (Errors -> Warnings)
    constant BLDCJoint_ERROR_DISABLE                   : integer := 26;  --! Register to set error disable bits
    constant BLDCJoint_POS_MIN_HARD_LIMIT              : integer := 27;  --! Position lower bound hard-limit
    constant BLDCJoint_POS_MAX_HARD_LIMIT              : integer := 28;  --! Position upper bound hard-limit
    constant BLDCJoint_VEL_HARD_LIMIT                  : integer := 29;  --! Speed hard-limit
    constant BLDCJoint_CUR_HARD_LIMIT                  : integer := 30;  --! Current hard-limit
    constant BLDCJoint_MAX_TEMP_LIMIT                  : integer := 31;  --! Temperature limit
    constant BLDCJoint_CONFIG                          : integer := 266;  --! Configuration register (enable, drive mode, ...)
        constant BLDCJoint_CONFIG_ENABLE_CMD_BIT                : integer := 0; --! Enable command
        constant BLDCJoint_CONFIG_INTERPOLATOR_BIT              : integer := 1; --! Enable interpolator
        constant BLDCJoint_CONFIG_DIRECT_PWM_BIT                : integer := 2; --! Enable direct pwm
        constant BLDCJoint_CONFIG_ZERO_POS_BIT                  : integer := 3; --! Set position offset, so that this position is zero.
        constant BLDCJoint_CONFIG_RESET_POS_BIT                 : integer := 4; --! Set incremental encoder position to absolute position
        constant BLDCJoint_CONFIG_RESET_ERRORS_BIT              : integer := 5; --! Trigger reset of error flags
        constant BLDCJoint_CONFIG_OPEN_BRAKE_BIT                : integer := 6; --! Open the brake
        constant BLDCJoint_CONFIG_WRITE_SETTINGS_BIT            : integer := 7; --! Write settings trigger
        constant BLDCJoint_CONFIG_DEBUG_MODE_BIT                : integer := 11; --! Enable debug mode
    constant BLDCJoint_DIRECT_PWM                      : integer := 272;  --! Direct PWM
    constant BLDCJoint_WARNING                         : integer := 516;  --! Actual joint warning state
        constant BLDCJoint_WARNING_INIT_BIT                     : integer := 0; --! Initialization fail
        constant BLDCJoint_WARNING_POSITIONDIFFERENCE_BIT       : integer := 1; --! Position difference between incremental and absolute encoder too large
        constant BLDCJoint_WARNING_POS_HARD_LIMIT_BIT           : integer := 2; --! Position value out of hard limits
        constant BLDCJoint_WARNING_VEL_HARD_LIMIT_BIT           : integer := 3; --! Velocity value out of hard limits
        constant BLDCJoint_WARNING_CUR_HARD_LIMIT_BIT           : integer := 4; --! Current value out of hard limits
        constant BLDCJoint_WARNING_COMMTIMEOUTANY_BIT           : integer := 5; --! Timeout since any communication
        constant BLDCJoint_WARNING_COMMTIMEOUTARMCMD_BIT        : integer := 6; --! Timeout since last arm command message
        constant BLDCJoint_WARNING_TEMPERATURE_BIT              : integer := 7; --! Temperature to high
        constant BLDCJoint_WARNING_SENSOR_ICHAUS_BIT            : integer := 8; --! Absolute pos. sensor failed
        constant BLDCJoint_WARNING_SENSOR_OPTO_BIT              : integer := 9; --! Optical pos. sensor failed
        constant BLDCJoint_WARNING_SENSOR_HALL_BIT              : integer := 10; --! Hall sensor failed
        constant BLDCJoint_WARNING_SENSOR_CURRENT_BIT           : integer := 11; --! Current sensor failed
        constant BLDCJoint_WARNING_FRICTION_IDENT_BIT           : integer := 12; --! Friction identification failed
        constant BLDCJoint_WARNING_VOLTAGE_BIT                  : integer := 13; --! Voltage to high
        constant BLDCJoint_WARNING_CTRL_LIMIT_BIT               : integer := 14; --! One of the controller values saturated
        constant BLDCJoint_WARNING_TELEMETRY_TIMEOUT_BIT        : integer := 15; --! Telemetry timeout at MCS
        constant BLDCJoint_WARNING_MOTOR_HALL_DATA_BIT          : integer := 16; --! Motor: hall values are invalid
        constant BLDCJoint_WARNING_MOTOR_INCR_DATA_BIT          : integer := 17; --! Motor: incremental encoder values are invalid
    constant BLDCJoint_ERROR                           : integer := 518;  --! Actual joint error state
        constant BLDCJoint_ERROR_INIT_BIT                       : integer := 0; --! Initialization fail
        constant BLDCJoint_ERROR_POSITIONDIFFERENCE_BIT         : integer := 1; --! Position difference between incremental and absolute encoder too large
        constant BLDCJoint_ERROR_POS_HARD_LIMIT_BIT             : integer := 2; --! Position value out of hard limits
        constant BLDCJoint_ERROR_VEL_HARD_LIMIT_BIT             : integer := 3; --! Velocity value out of hard limits
        constant BLDCJoint_ERROR_CUR_HARD_LIMIT_BIT             : integer := 4; --! Current value out of hard limits
        constant BLDCJoint_ERROR_COMMTIMEOUTANY_BIT             : integer := 5; --! Timeout since any communication
        constant BLDCJoint_ERROR_COMMTIMEOUTARMCMD_BIT          : integer := 6; --! Timeout since last arm command message
        constant BLDCJoint_ERROR_TEMPERATURE_BIT                : integer := 7; --! Temperature to high
        constant BLDCJoint_ERROR_SENSOR_ICHAUS_BIT              : integer := 8; --! Absolute pos. sensor failed
        constant BLDCJoint_ERROR_SENSOR_OPTO_BIT                : integer := 9; --! Optical pos. sensor failed
        constant BLDCJoint_ERROR_SENSOR_HALL_BIT                : integer := 10; --! Hall sensor failed
        constant BLDCJoint_ERROR_SENSOR_CURRENT_BIT             : integer := 11; --! Current sensor failed
        constant BLDCJoint_ERROR_FRICTION_IDENT_BIT             : integer := 12; --! Friction identification failed
        constant BLDCJoint_ERROR_VOLTAGE_BIT                    : integer := 13; --! Voltage to high
        constant BLDCJoint_ERROR_CTRL_LIMIT_BIT                 : integer := 14; --! One of the controller values saturated
        constant BLDCJoint_ERROR_TELEMETRY_TIMEOUT_BIT          : integer := 15; --! Telemetry timeout at MCS
        constant BLDCJoint_ERROR_MOTOR_HALL_DATA_BIT            : integer := 16; --! Motor: hall values are invalid
        constant BLDCJoint_ERROR_MOTOR_INCR_DATA_BIT            : integer := 17; --! Motor: incremental encoder values are invalid
    constant BLDCJoint_TEMPERATURE0                    : integer := 540;  --! Actual temperature 0
    constant BLDCJoint_TEMPERATURE1                    : integer := 542;  --! Actual temperature 1
    constant BLDCJoint_STATE                           : integer := 550;  --! Actual joint state
        constant BLDCJoint_STATE_ENABLE_BIT                     : integer := 0; --! Motor enable flag
        constant BLDCJoint_STATE_WARNINGFLAG_BIT                : integer := 1; --! Joint in warning condition
        constant BLDCJoint_STATE_ERRORFLAG_BIT                  : integer := 2; --! Joint in error condition
        constant BLDCJoint_STATE_TELEMETRY_AVAILABLE_BIT        : integer := 7; --! Telemetry available flag
        constant BLDCJoint_STATE_ENABLE_CMD_BIT                 : integer := 8; --! Enable command
        constant BLDCJoint_STATE_INTERPOLATOR_BIT               : integer := 9; --! Interpolator flag
        constant BLDCJoint_STATE_HALL0_BIT                      : integer := 12; --! Hall Signal 0
        constant BLDCJoint_STATE_HALL1_BIT                      : integer := 13; --! Hall Signal 1
        constant BLDCJoint_STATE_HALL2_BIT                      : integer := 14; --! Hall Signal 2
        constant BLDCJoint_STATE_PROM_BUSY_BIT                  : integer := 15; --! EEPROM Busy
    constant BLDCJoint_ABSOLUTE_POSITION               : integer := 551;  --! Absolute Position (iCHaus)
    constant BLDCJoint_POSITION                        : integer := 552;  --! Position (Encoder)
    constant BLDCJoint_SPEED                           : integer := 553;  --! Speed (Encoder)
    constant BLDCJoint_PWM                             : integer := 554;  --! (Actual) PWM
    constant BLDCJoint_VOLTAGE                         : integer := 555;  --! Voltage
    constant BLDCJoint_CURRENT                         : integer := 556;  --! Current
    constant BLDCJoint_TEMPERATURE                     : integer := 557;  --! Temperature
    constant BLDCJoint_DESIRED_POSITION                : integer := 558;  --! Desired Position
    constant BLDCJoint_CTRL_PWM                        : integer := 559;  --! Control PWM
    constant BLDCJoint_DEBUG1                          : integer := 560;  --! Debug Value 1
    constant BLDCJoint_DEBUG2                          : integer := 561;  --! Debug Value 2
    constant BLDCJoint_DEBUG3                          : integer := 562;  --! Debug Value 3
    constant BLDCJoint_DEBUG4                          : integer := 563;  --! Debug Value 4
    constant BLDCJoint_DEBUG5                          : integer := 564;  --! Debug Value 5

    -- CascadedController
    constant CascadedController_POS_P                  : integer := 32;  --! Proportional gain for the position control loop
    constant CascadedController_POS_I                  : integer := 36;  --! Integral gain for the position control loop
    constant CascadedController_POS_D                  : integer := 40;  --! Derivative gain for the position control loop
    constant CascadedController_VEL_P                  : integer := 44;  --! Proportional gain for the velocity control loop
    constant CascadedController_VEL_I                  : integer := 48;  --! Integral gain for the velocity control loop
    constant CascadedController_VEL_D                  : integer := 52;  --! Derivative gain for the velocity control loop
    constant CascadedController_CUR_P                  : integer := 56;  --! Proportional gain for the current control loop
    constant CascadedController_CUR_I                  : integer := 60;  --! Integral gain for the current control loop
    constant CascadedController_CUR_D                  : integer := 64;  --! Derivative gain for the current control loop
    constant CascadedController_POS_DEAD_ZONE          : integer := 68;  --! Dead zone for the position controller
    constant CascadedController_VEL_DEAD_ZONE          : integer := 70;  --! Dead zone for the velocity controller
    constant CascadedController_CUR_DEAD_ZONE          : integer := 74;  --! Dead zone for the current controller
    constant CascadedController_POS_MAX_ERROR_INTEGRAL : integer := 76;  --! Maximum integral value for position control loop
    constant CascadedController_VEL_MAX_ERROR_INTEGRAL : integer := 78;  --! Maximum integral value for velocity control loop
    constant CascadedController_CUR_MAX_ERROR_INTEGRAL : integer := 80;  --! Maximum integral value for current control loop
    constant CascadedController_POS_MAX_CTRL_VAL       : integer := 82;  --! Maximum output of the position control loop
    constant CascadedController_VEL_MAX_CTRL_VAL       : integer := 84;  --! Maximum output of the velocity control loop
    constant CascadedController_CUR_MAX_CTRL_VAL       : integer := 86;  --! Maximum output of the current controll loop
    constant CascadedController_POS_MIN                : integer := 88;  --! Minimum permissible position
    constant CascadedController_POS_MAX                : integer := 90;  --! Maximum permissible position
    constant CascadedController_VEL_MAX                : integer := 92;  --! Maximum permissible velocity
    constant CascadedController_CUR_MAX                : integer := 96;  --! Maximum permissible current
    constant CascadedController_CTRL_MODE              : integer := 98;  --! Sets Controlmode: 0=SETPWM, 1=CTRLCUR, 2=CTRLVEL_CC, 3=CTRLPOS_CC, 4=CTRLVEL, 5=CTRLPOS, 9=CTRLACC_CTC, 11=CTRLVEL_CTC, 19=CTRLPOS_CTC
        constant CascadedController_CTRL_MODE_SETPWM_VALUE        : integer := 0; --! Direct PWM
        constant CascadedController_CTRL_MODE_CTRLCUR_VALUE       : integer := 1; --! Current control
        constant CascadedController_CTRL_MODE_CTRLVEL_CC_VALUE    : integer := 2; --! Velocity-Current cascade
        constant CascadedController_CTRL_MODE_CTRLPOS_CC_VALUE    : integer := 3; --! Position-Velocity-Current cascade
        constant CascadedController_CTRL_MODE_CTRLVEL_VALUE       : integer := 4; --! Velocity control
        constant CascadedController_CTRL_MODE_CTRLPOS_VALUE       : integer := 5; --! Position control
        constant CascadedController_CTRL_MODE_CTRLPOSVEL_CC_VALUE : integer := 6; --! Position-Velocity cascade
        constant CascadedController_CTRL_MODE_UNDEFINED_VALUE     : integer := 255; --! Undefined value
    constant CascadedController_POS_REF                : integer := 256;  --! Position Reference
    constant CascadedController_VEL_REF                : integer := 258;  --! Velocity Reference
    constant CascadedController_ACC_REF                : integer := 262;  --! Acceleration Reference
    constant CascadedController_CUR_REF                : integer := 264;  --! Current Reference
    constant CascadedController_ACTIVE_SATURATIONS     : integer := 512;  --! Shows which saturaturations of control values are reached

    -- MotionController_General
    constant MotionController_General_MOTION_MODE      : integer := 0;  --! MotionMode: 0=Stop, 1=Walking, 2=JointSpaceSequence, 4=TwoLegged, 5=StandUp, 6=SitDown, 7=RandomWalk
        constant MotionController_General_MOTION_MODE_STOP_VALUE  : integer := 0; --! No Motion
        constant MotionController_General_MOTION_MODE_WALKING_FOUR_LEGGED_VALUE : integer := 1; --! Four Legged Walking
        constant MotionController_General_MOTION_MODE_JOINT_SPACE_SEQUENCE_VALUE : integer := 2; --! JointSpaceSequence
        constant MotionController_General_MOTION_MODE_DRIVING_VALUE : integer := 3; --! Driving
        constant MotionController_General_MOTION_MODE_WALKING_TWO_LEGGED_VALUE : integer := 4; --! Two legged Walking
        constant MotionController_General_MOTION_MODE_STAND_UP_VALUE : integer := 5; --! Standup
        constant MotionController_General_MOTION_MODE_SIT_DOWN_VALUE : integer := 6; --! SitDown
        constant MotionController_General_MOTION_MODE_RANDOM_WALK_DEMO_VALUE : integer := 7; --! random walk demo
    constant MotionController_General_MOTORS_ENABLE    : integer := 1;  --! Bit mask to enable(1) or disable(0) the motors
    constant MotionController_General_CLKSYNC_ENABLE   : integer := 2;  --! Config for Clock Syncronisation
        constant MotionController_General_CLKSYNC_ENABLE_PINGPONG_BIT : integer := 0; --! Enable RTT measurements
        constant MotionController_General_CLKSYNC_ENABLE_SYNC_BIT : integer := 1; --! Enable remote clock syncronisation
        constant MotionController_General_CLKSYNC_ENABLE_DELAYADJ_BIT : integer := 2; --! Enable delay adjustment (needs bit 1 to be set)
        constant MotionController_General_CLKSYNC_ENABLE_DEBUG_BIT : integer := 3; --! Enable debug output on console
        constant MotionController_General_CLKSYNC_ENABLE_RESET_BIT : integer := 4; --! Reset all values
        constant MotionController_General_CLKSYNC_ENABLE_INFO_BIT : integer := 5; --! Send ClockInfo packets to GUI
    constant MotionController_General_CLKSYNC_PERIOD   : integer := 3;  --! A value in units of 10 ms for the period between a RTT measurement and a SYNC packet
    constant MotionController_General_LOGGING_NORMAL_ENABLE : integer := 4;  --! LoggingThread: Enable normal log by writing 1, disable by writing 0. See stdout for more info
    constant MotionController_General_LOGGING_EMERGENCY_TRIGGER : integer := 5;  --! LoggingThread: write a 1 to trigger saving the last x seconds of logdata
    constant MotionController_General_LOGGING_EMERGENCY_KEEPTIME_SECONDS : integer := 6;  --! LoggingThread: keeptime for emergency log in seconds
    constant MotionController_General_POSTURE_DEMO_ENABLE : integer := 7;  --! write one to enable posture demo, write 0 to trigger abort prematurely
    constant MotionController_General_SEQUENCE_DEMO    : integer := 8;  --! '1' stand up motion, '2' go down motion and '0' to abort
        constant MotionController_General_SEQUENCE_DEMO_IDLE_VALUE : integer := 0; --! No demo
        constant MotionController_General_SEQUENCE_DEMO_STANDUP_VALUE : integer := 1; --! Stand up motion
        constant MotionController_General_SEQUENCE_DEMO_GODOWN_VALUE : integer := 2; --! Go down motion
        constant MotionController_General_SEQUENCE_DEMO_STANDINGSPINE_VALUE : integer := 3; --! Standing spine motion
        constant MotionController_General_SEQUENCE_DEMO_WIVE_VALUE : integer := 4; --! Wive motion
        constant MotionController_General_SEQUENCE_DEMO_BOW_VALUE : integer := 5; --! Bow motion
        constant MotionController_General_SEQUENCE_DEMO_LIFT_ARM_VALUE : integer := 6; --! Lift the arm for the two-legged demo (hack for the Halleneinweihung)
        constant MotionController_General_SEQUENCE_DEMO_PUT_DOWN_ARM_VALUE : integer := 7; --! Put down the arm (hack for the Halleneinweihung)
        constant MotionController_General_SEQUENCE_DEMO_STOP_VALUE : integer := 254; --! Stop actual demo
        constant MotionController_General_SEQUENCE_DEMO_ABORT_VALUE : integer := 255; --! Abort actual demo
    constant MotionController_General_KRAFTAUSGLEICH   : integer := 9;  --! zero to disable and delete stored offsets. one for updating operation, two for normal operation after update
    constant MotionController_General_KRAFTAUSGLEICH_MAX_OFFSET : integer := 10;  --! max offset in mm
    constant MotionController_General_KRAFTAUSGLEICH_GAIN : integer := 11;  --! offset gain (0.005 works)
    constant MotionController_General_HEAD_CONTROL_DIRECT : integer := 12;  --! Head control direct
    constant MotionController_General_RANDOM_WALK_LEG_ID : integer := 13;  --! LegId for RandomWalk
    constant MotionController_General_GLOBAL_SUPPORT_POLYGON_REFERENCE_FRAME : integer := 14;  --! 0 for grav, 1 for rest

    -- MotionController_Balance
    constant MotionController_Balance_BALANCE_ENABLE   : integer := 1500;  --! Balance enable (0:off, 1:enable)
    constant MotionController_Balance_BALANCE_ENABLE_PLOT : integer := 1501;  --! Balance:EnablePlots (0:off)
    constant MotionController_Balance_BALANCE_SCALING_X : integer := 1505;  --! Balance:Scaling of shift (X)
    constant MotionController_Balance_BALANCE_SCALING_Y : integer := 1506;  --! Balance:Scaling of shift (Y)
    constant MotionController_Balance_BALANCE_SCALING_Z : integer := 1507;  --! Balance:Scaling of shift (Z)
    constant MotionController_Balance_BALANCE_SCALING_PITCH : integer := 1508;  --! Balance:Scaling of rotation (Pitch/mm)
    constant MotionController_Balance_BALANCE_SCALING_ROLL : integer := 1509;  --! Balance:Scaling of rotation (Roll/mm)
    constant MotionController_Balance_BALANCE_OFFSET_X : integer := 1510;  --! Balance: Offset gain in x
    constant MotionController_Balance_BALANCE_OFFSET_Y : integer := 1511;  --! Balance: Offset gain in y
    constant MotionController_Balance_BALANCE_OFFSET_Z : integer := 1512;  --! Balance: Offset gain in z
    constant MotionController_Balance_BALANCE_DAMPING_X : integer := 1513;  --! Balance: Damping in x
    constant MotionController_Balance_BALANCE_DAMPING_Y : integer := 1514;  --! Balance: Damping in y
    constant MotionController_Balance_BALANCE_DAMPING_Z : integer := 1515;  --! Balance: Damping in z
    constant MotionController_Balance_BALANCE_DISTU_GAIN_X : integer := 1516;  --! Balance: Disturbance gain in x
    constant MotionController_Balance_BALANCE_DISTU_GAIN_Y : integer := 1517;  --! Balance: Disturbance gain in y
    constant MotionController_Balance_BALANCE_DISTU_GAIN_Z : integer := 1518;  --! Balance: Disturbance gain in z

    -- MotionController_WalkControl
    constant MotionController_WalkControl_GAIT         : integer := 1000;  --! Gait (STAND(0), CRAWL(1), TIMED(2))
    constant MotionController_WalkControl_HANDLE_DETECTED_STATE : integer := 1001;  --! Handle detected state (Early-Touchdown)
    constant MotionController_WalkControl_LAST_WALKING_STATE_AS_DETECTED : integer := 1002;  --! Use last walking state as detected state (ignoring sensor data)
    constant MotionController_WalkControl_CYCLE_TIME   : integer := 1011;  --! Cycle time (in ms)
    constant MotionController_WalkControl_MAX_DISTANCE_STANCE : integer := 1012;  --! Max. distance of feet (robot frame) during stance phase (in mm)
    constant MotionController_WalkControl_SWING_POS_OFFSET_X : integer := 1013;  --! x-position offset in leg swing phase (in mm)
    constant MotionController_WalkControl_SWING_POS_OFFSET_Y : integer := 1014;  --! y-position offset in leg swing phase (in mm)
    constant MotionController_WalkControl_SWING_POS_OFFSET_Z : integer := 1015;  --! z-position offset in leg swing phase (in mm)
    constant MotionController_WalkControl_DCSOP_SHIFT_X : integer := 1016;  --! x value for a dcsop shift (in mm)
    constant MotionController_WalkControl_DCSOP_SHIFT_Y : integer := 1017;  --! y value for a dcsop shift (in mm)
    constant MotionController_WalkControl_DCSOP_SHIFT_Z : integer := 1018;  --! z value for a dcsop shift (in mm)
    constant MotionController_WalkControl_BODY_ROTATION_YAW : integer := 1019;  --! yaw (z-Axis) body rotation (in degree)
    constant MotionController_WalkControl_BODY_ROTATION_PITCH : integer := 1020;  --! pitch (y-Axis) body rotation (in degree)
    constant MotionController_WalkControl_BODY_ROTATION_ROLL : integer := 1021;  --! roll (x-Axis) body rotation (in degree)
    constant MotionController_WalkControl_CENTER_POS_FRONT_X : integer := 1022;  --! x-distance from front feet to robot center (in mm)
    constant MotionController_WalkControl_CENTER_POS_FRONT_ABS_Y : integer := 1023;  --! y-distance from front feet to robot center (in mm)
    constant MotionController_WalkControl_CENTER_POS_REAR_X : integer := 1024;  --! x-distance from rear feet to robot center (in mm)
    constant MotionController_WalkControl_CENTER_POS_REAR_ABS_Y : integer := 1025;  --! y-distance from front feet to robot center (in mm)
    constant MotionController_WalkControl_CENTER_POS_Z : integer := 1026;  --! Distance from ground to robot center (in mm)
    constant MotionController_WalkControl_CENTER_POS_Z_DELTA_FL : integer := 1027;  --! Difference FL to common CENTER_POS_Z (in mm)
    constant MotionController_WalkControl_CENTER_POS_Z_DELTA_FR : integer := 1028;  --! Difference FR to common CENTER_POS_Z (in mm)
    constant MotionController_WalkControl_CENTER_POS_Z_DELTA_RL : integer := 1029;  --! Difference RL to common CENTER_POS_Z (in mm)
    constant MotionController_WalkControl_CENTER_POS_Z_DELTA_RR : integer := 1030;  --! Difference RR to common CENTER_POS_Z (in mm)
    constant MotionController_WalkControl_CENTER_POS_FRONT_Z : integer := 1031;  --! Z-distance from front feet to robot center (in mm)
    constant MotionController_WalkControl_CENTER_POS_REAR_Z : integer := 1032;  --! Z-distance from rear feet to robot center (in mm)
    constant MotionController_WalkControl_BODY_OVER_GROUND_SHIFT_Z : integer := 1033;  --! z value for the bodyheight over the support plane (in mm)
    constant MotionController_WalkControl_SPINE_OFFSET_ROT_YAW : integer := 1035;  --! Spine: hip2body rotation offset yaw (in deg)
    constant MotionController_WalkControl_SPINE_OFFSET_ROT_PITCH : integer := 1036;  --! Spine: hip2body rotation offset pitch (in deg)
    constant MotionController_WalkControl_SPINE_OFFSET_ROT_ROLL : integer := 1037;  --! Spine: hip2body rotation offset roll (in deg)
    constant MotionController_WalkControl_REAR_PITCH_TOUCHDOWN : integer := 1041;  --! Pitch angle of the rear feet to ground at touchdown (in deg)
    constant MotionController_WalkControl_REAR_PITCH_TOEOFF : integer := 1042;  --! Pitch angle of the rear feet to ground at toe-off(in deg)
    constant MotionController_WalkControl_REAR_PITCH_MIDSWING : integer := 1043;  --! Pitch angle of the rear feet to ground at mid-swing(in deg)
    constant MotionController_WalkControl_FRONT_YAW    : integer := 1044;  --! Yaw angle of the feet (angle is for left side, right is mirrored. in degree.)
    constant MotionController_WalkControl_JOINT_ANGLES_REQUEST_FILTER : integer := 1045;  --! Filter joint angles request (0: off, 1: on)
    constant MotionController_WalkControl_JOINT_ANGLES_REQUEST_FILTER_SLOWER : integer := 1046;  --! Allow slower velocity by filtered joint angles request (0: off, 1: on)
    constant MotionController_WalkControl_JOINT_ANGLES_REQUEST_FILTER_FASTER : integer := 1047;  --! Allow a little bit faster velocity by filtered joint angles request (0: off, 1: on)
    constant MotionController_WalkControl_USE_ANKLE_JOINT_OFFSETS : integer := 1048;  --! Use ankle joint offsets for the virtual spring (0: off, 1: on)
    constant MotionController_WalkControl_SPINE_OFFSET_TRANS_X : integer := 1049;  --! Spine: hip2body translation offset in x (in mm)
    constant MotionController_WalkControl_SPINE_OFFSET_TRANS_Y : integer := 1050;  --! Spine: hip2body translation offset in y (in mm)
    constant MotionController_WalkControl_SPINE_OFFSET_TRANS_Z : integer := 1051;  --! Spine: hip2body translation offset in z (in mm)
    constant MotionController_WalkControl_GAIT_TIMED_SWINGUP_PROGRESS_FL : integer := 1052;  --! Timed walking gait: trigger swing-up phase of leg FL at this cycle progress value.
    constant MotionController_WalkControl_GAIT_TIMED_SWINGUP_PROGRESS_FR : integer := 1053;  --! Timed walking gait: trigger swing-up phase of leg FR at this cycle progress value.
    constant MotionController_WalkControl_GAIT_TIMED_SWINGUP_PROGRESS_RL : integer := 1054;  --! Timed walking gait: trigger swing-up phase of leg RL at this cycle progress value.
    constant MotionController_WalkControl_GAIT_TIMED_SWINGUP_PROGRESS_RR : integer := 1055;  --! Timed walking gait: trigger swing-up phase of leg RR at this cycle progress value.
    constant MotionController_WalkControl_GAIT_TIMED_SWING_FRACTION : integer := 1056;  --! Timed walking gait: fraction of walking cycle for swing-phase (ie. 0.25 for crawl).
    constant MotionController_WalkControl_FLOOR_ESTIMATOR_FIXED_FLOOR_OFFSET_Z : integer := 1064;  --! FloorEstimator:fixedFloorOffsetZ
    constant MotionController_WalkControl_FLOOR_ESTIMATOR_ENABLE_DEBUG_PLOTS : integer := 1065;  --! FloorEstimation: enable debug plots
    constant MotionController_WalkControl_FLOOR_ESTIMATOR_HYPER_PLANE_ESTIMATION : integer := 1066;  --! MotionFloorEstimatorModule:hyperPlaneEstimation
    constant MotionController_WalkControl_FLOOR_ESTIMATOR_FILTER_LENGTH : integer := 1067;  --! MotionFloorEstimatorModule:filterLength
    constant MotionController_WalkControl_FL_OFFSET_X  : integer := 1070;  --! FL offset x [mm]
    constant MotionController_WalkControl_FL_OFFSET_Y  : integer := 1071;  --! FL offset y [mm]
    constant MotionController_WalkControl_FL_OFFSET_Z  : integer := 1072;  --! FL offset z [mm]
    constant MotionController_WalkControl_FR_OFFSET_X  : integer := 1073;  --! FR offset x [mm]
    constant MotionController_WalkControl_FR_OFFSET_Y  : integer := 1074;  --! FR offset y [mm]
    constant MotionController_WalkControl_FR_OFFSET_Z  : integer := 1075;  --! FR offset z [mm]
    constant MotionController_WalkControl_RL_OFFSET_X  : integer := 1076;  --! RL offset x [mm]
    constant MotionController_WalkControl_RL_OFFSET_Y  : integer := 1077;  --! RL offset y [mm]
    constant MotionController_WalkControl_RL_OFFSET_Z  : integer := 1078;  --! RL offset z [mm]
    constant MotionController_WalkControl_RR_OFFSET_X  : integer := 1079;  --! RR offset x [mm]
    constant MotionController_WalkControl_RR_OFFSET_Y  : integer := 1080;  --! RR offset y [mm]
    constant MotionController_WalkControl_RR_OFFSET_Z  : integer := 1081;  --! RR offset z [mm]
    constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_X : integer := 1100;  --! Spine: scale supporting x (-1..1)
    constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_Y : integer := 1101;  --! Spine: scale supporting y (-1..1)
    constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_Z : integer := 1102;  --! Spine: scale supporting z (-1..1)
    constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_YAW : integer := 1103;  --! Spine: scale supporting yaw (-1..1)
    constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_PITCH : integer := 1104;  --! Spine: scale supporting pitch (-1..1)
    constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_ROLL : integer := 1105;  --! Spine: scale supporting roll (-1..1)
    constant MotionController_WalkControl_SPINE_SUPPORT_HIPSHOULDER_WEIGHT : integer := 1112;  --! Spine: weight for spine support between Hip/Shoulder (0..1)

    -- MotionController_WalkTwoLeggedControl
    constant MotionController_WalkTwoLeggedControl_HANDLE_DETECTED_STATE : integer := 2001;  --! Handle detected state (Early-Touchdown)
    constant MotionController_WalkTwoLeggedControl_CYCLE_TIME : integer := 2011;  --! Cycle time (in ms)
    constant MotionController_WalkTwoLeggedControl_MAX_DISTANCE_STANCE : integer := 2012;  --! Max. distance of feet (robot frame) during stance phase (in mm)
    constant MotionController_WalkTwoLeggedControl_SWING_POS_OFFSET_FRONT_X : integer := 2013;  --! x-position offset in leg swing phase (front) (in mm)
    constant MotionController_WalkTwoLeggedControl_SWING_POS_OFFSET_FRONT_Y : integer := 2014;  --! y-position offset in leg swing phase (front) (in mm)
    constant MotionController_WalkTwoLeggedControl_SWING_POS_OFFSET_FRONT_Z : integer := 2015;  --! z-position offset in leg swing phase (front) (in mm)
    constant MotionController_WalkTwoLeggedControl_SWING_POS_OFFSET_REAR_X : integer := 2016;  --! x-position offset in leg swing phase (rear) (in mm)
    constant MotionController_WalkTwoLeggedControl_SWING_POS_OFFSET_REAR_Y : integer := 2017;  --! y-position offset in leg swing phase (rear) (in mm)
    constant MotionController_WalkTwoLeggedControl_SWING_POS_OFFSET_REAR_Z : integer := 2018;  --! z-position offset in leg swing phase (rear) (in mm)
    constant MotionController_WalkTwoLeggedControl_CENTER_POS_FRONT_X : integer := 2022;  --! x-distance from front feet to robot center (in mm)
    constant MotionController_WalkTwoLeggedControl_CENTER_POS_FRONT_ABS_Y : integer := 2023;  --! y-distance from front feet to robot center (in mm)
    constant MotionController_WalkTwoLeggedControl_CENTER_POS_FRONT_Z : integer := 2024;  --! z-distance from front feet to robot center (in mm)
    constant MotionController_WalkTwoLeggedControl_CENTER_POS_REAR_X : integer := 2025;  --! x-distance from rear feet to robot center (in mm)
    constant MotionController_WalkTwoLeggedControl_CENTER_POS_REAR_ABS_Y : integer := 2026;  --! y-distance from rear feet to robot center (in mm)
    constant MotionController_WalkTwoLeggedControl_CENTER_POS_REAR_Z : integer := 2027;  --! z-distance from rear feet to robot center (in mm)
    constant MotionController_WalkTwoLeggedControl_CENTER_POS_Z_DELTA_FL : integer := 2028;  --! Difference FL to common CENTER_POS_Z (in mm)
    constant MotionController_WalkTwoLeggedControl_CENTER_POS_Z_DELTA_FR : integer := 2029;  --! Difference FR to common CENTER_POS_Z (in mm)
    constant MotionController_WalkTwoLeggedControl_CENTER_POS_Z_DELTA_RL : integer := 2030;  --! Difference RL to common CENTER_POS_Z (in mm)
    constant MotionController_WalkTwoLeggedControl_CENTER_POS_Z_DELTA_RR : integer := 2031;  --! Difference RR to common CENTER_POS_Z (in mm)
    constant MotionController_WalkTwoLeggedControl_FIXED_FRONT_LEGS : integer := 2032;  --! MotionIkModule: Enable front legs fixed to body frame
    constant MotionController_WalkTwoLeggedControl_TWO_LEGGED_DESIRED_ZMP_OFFSET_IN_X : integer := 2050;  --! Offset to the desired ZMP in x for two legged walking (in mm)
    constant MotionController_WalkTwoLeggedControl_TWO_LEGGED_DESIRED_ZMP_OFFSET_IN_Y : integer := 2051;  --! Offset to the desired ZMP in y for two legged walking (in mm)
    constant MotionController_WalkTwoLeggedControl_TWO_LEGGED_DESIRED_ZMP_OFFSET_IN_Z : integer := 2052;  --! Offset to the desired ZMP in z for two legged walking (in mm)

    -- MotionController_SendToPc
    constant MotionController_SendToPc_SEND_ROBOT_STATUS : integer := 20;  --! Send robot status (1:on, 0:off)
    constant MotionController_SendToPc_SEND_REQUESTED_JOINT_POSE : integer := 21;  --! Send requested joint pose (1:on, 0:off)
    constant MotionController_SendToPc_SEND_MEASURED_JOINT_POSE : integer := 22;  --! Send measured joint pose (1:on, 0:off)
    constant MotionController_SendToPc_SEND_DESIRED_MOTOR_POSITIONS : integer := 23;  --! Send desired motor positions (1:on, 0:off)
    constant MotionController_SendToPc_SEND_MEASURED_MOTOR_POSITIONS : integer := 24;  --! Send measured motor positions (1:on, 0:off)
    constant MotionController_SendToPc_SEND_REQUESTED_SPEED : integer := 25;  --! Send requested speed (1:on, 0:off)
    constant MotionController_SendToPc_SEND_MEASURED_SPEED : integer := 26;  --! Send measured speed (1:on, 0:off)
    constant MotionController_SendToPc_SEND_MEASURED_ICHAUS_POSITION : integer := 27;  --! Send measured ic-haus positions (1:on, 0:off)
    constant MotionController_SendToPc_SEND_CURRENT    : integer := 28;  --! Send motor current (1:on, 0:off)
    constant MotionController_SendToPc_SEND_PWM        : integer := 29;  --! Send motor PWM (1:on, 0:off)
    constant MotionController_SendToPc_SEND_TEMPERATURE : integer := 30;  --! Send motor temperature (1:on, 0:off)
    constant MotionController_SendToPc_SEND_BLDCJOINT_TELEMETRY_ID : integer := 31;  --! Send telemetry of this BLDC joint (joint id, 0: off)
    constant MotionController_SendToPc_SEND_ANKLEJOINT_TELEMETRY_ID : integer := 32;  --! Send telemetry of this ankle joint (joint id, 0: off)
    constant MotionController_SendToPc_SEND_SPINE_TELEMETRY : integer := 33;  --! Send telemetry of the spine joint (1: on, 0: off)
    constant MotionController_SendToPc_SEND_HEAD_TELEMETRY : integer := 34;  --! Send telemetry of head joint (1: on, 0: off)
    constant MotionController_SendToPc_SEND_FT_SENSOR_VALUES : integer := 35;  --! Send feet FT Sensor values (1: on, 0: off)
    constant MotionController_SendToPc_SEND_WALKING_STATE : integer := 36;  --! Send walking state (1: on, 0: off)
    constant MotionController_SendToPc_SEND_IMUS       : integer := 37;  --! Send raw data from the two Xsens Imu (id1/2) and the virtual Imu in rest system (id3) (1: on, 0: off)
    constant MotionController_SendToPc_SEND_FILTERED_WALKING_SPEED : integer := 39;  --! Send walking state (1: on, 0: off)
    constant MotionController_SendToPc_SEND_GLOBAL_SUPPORT_POLYGON : integer := 40;  --! Send walking state (1: on, 0: off)

    -- PicoBlazeArray
    constant PicoBlazeArray_INPUT                      : integer := 1;  --! Input register mapped to KCPSM6
    constant PicoBlazeArray_OUTPUT                     : integer := 2;  --! Output register mapped to KCPSM6

    -- mdaq2
    constant mdaq2_BACKUP                              : integer := 1;  --! 0: Idle >0: Trigger backup of important registers to flash memory
    constant mdaq2_DC_EN                               : integer := 2;  --! 0: Drift Compensation disabled. >0: Drift Compensation enabled (default).
    constant mdaq2_VOUT_5V                             : integer := 3;  --! Measured voltage on 5V output rail
    constant mdaq2_VOUT_DAC                            : integer := 4;  --! Voltage at the DAC output
    constant mdaq2_DEF_FREQ                            : integer := 5;  --! Default calling frequency of Jobs
    constant mdaq2_TERM_RESISTANCE                     : integer := 6;  --! Termination resistance at analog inputs
    constant mdaq2_RTC_DRIFT                           : integer := 7;  --! Real time clock drift in ppm
    constant mdaq2_FT_REMOTE                           : integer := 8;  --! 0: FT Measurement disabled >0: Id of the receiving node
    constant mdaq2_FT_FREQ                             : integer := 9;  --! Transmission frequency of new FT data
    constant mdaq2_FT_SENSOR                           : integer := 10;  --! 0: undefined >0: See ForceTorqueData.h in RobotConfig
    constant mdaq2_FT_GAIN                             : integer := 11;  --! Sets amplification of raw signals to 10^{0-3}
    constant mdaq2_FT_OFFSET                           : integer := 12;  --! 1: Trigger offset compensation of FT vector
    constant mdaq2_FT_FILTER_TYPE                      : integer := 13;  --! 0: No Filtering 1: Butterworth 2: Median 3: Moving Average
    constant mdaq2_FT_FILTER_LEN                       : integer := 14;  --! Length of the buffer used for filtering
    constant mdaq2_FT_FILTER_ORDER                     : integer := 15;  --! Order of the butterworth filter
    constant mdaq2_FT_FILTER_CUTOFF                    : integer := 16;  --! Normalized cutoff frequency of the butterworth filter
    constant mdaq2_FT_FILTER_ATT                       : integer := 17;  --! Attenuation at cutoff frequency of the butterworth filter
    constant mdaq2_FT_AJC_REMOTE                       : integer := 18;  --! 0: Virtual springs disabled >0: Id of the receiving node
    constant mdaq2_RESERVED                            : integer := 19;  --! Might be used in the future
    constant mdaq2_FT_AJC_PITCHCONST                   : integer := 20;  --! Torsion spring constant at pitch DOF
    constant mdaq2_FT_AJC_PITCHLIMIT                   : integer := 21;  --! Allowed range (+/-) of pitch offset
    constant mdaq2_FT_AJC_ROLLCONST                    : integer := 22;  --! Torsion spring constant at roll DOF
    constant mdaq2_FT_AJC_ROLLLIMIT                    : integer := 23;  --! Allowed range (+/-) of pitch offset
    constant mdaq2_FT_AJC_INERTIA                      : integer := 24;  --! Moment of inertia seen by the ankle joint
    constant mdaq2_SA_REMOTE                           : integer := 25;  --! 0: SA Measurement disabled >0: Id of the receiving node
    constant mdaq2_SA_FREQ                             : integer := 26;  --! Transmission frequency of new SA data
    constant mdaq2_SA_STATE                            : integer := 27;  --! Register handling calibration data exchanges (do not use manually)
    constant mdaq2_SA_MODE                             : integer := 28;  --! 0-1: Floating point 2-3: Integer
    constant mdaq2_SA_OUTPUT                           : integer := 29;  --! 0: Conductances 1: Forces
    constant mdaq2_SA_SCALE                            : integer := 30;  --! Scaling of the transmitted values
    constant mdaq2_SA_OFFSET                           : integer := 31;  --! 1: Trigger offset compensation of each taxel
    constant mdaq2_SCOPE_REMOTE                        : integer := 32;  --! 0: Scope disabled >0: Id of the receiving node
    constant mdaq2_SCOPE_FREQ                          : integer := 33;  --! Transmission frequency of new Scope data
    constant mdaq2_SCOPE_MODE                          : integer := 34;  --! Bit0-1: 0: Manual select 1: 8CH differential 2: 15CH single-ended
        constant mdaq2_SCOPE_MODE_TXRAW_BIT                     : integer := 7; --! Transmit raw ADC values
    constant mdaq2_SCOPE_IN_POS                        : integer := 35;  --! Positive input channel (manual select)
    constant mdaq2_SCOPE_IN_NEG                        : integer := 36;  --! Negative input channel (manual select)
    constant mdaq2_SCOPE_OUT                           : integer := 37;  --! Output channel (manual select)
    constant mdaq2_SCOPE_GAIN                          : integer := 38;  --! Output channel (manual select)
    constant mdaq2_TC77_REMOTE                         : integer := 39;  --! 0: TC77 disabled >0: Id of the receiving node
    constant mdaq2_TC77_FREQ                           : integer := 40;  --! Transmission frequency of new temperature data
    constant mdaq2_LIS3_REMOTE                         : integer := 41;  --! 0: LIS3 disabled >0: Id of the receiving node
    constant mdaq2_LIS3_FREQ                           : integer := 42;  --! Transmission frequency of new acceleration data
    constant mdaq2_LIS3_SCALE                          : integer := 43;  --! 0: +/- 2G range >0: +/- 6G range
    constant mdaq2_SI1120_REMOTE                       : integer := 44;  --! 0: SI1120 disabled >0: Id of the receiving node
    constant mdaq2_SI1120_FREQ                         : integer := 45;  --! Transmission frequency of new distance data
    constant mdaq2_SI1120_CALIBRATE                    : integer := 46;  --! 0->1: (Re-)calibration of the SI1120 distance sensor
    constant mdaq2_ANGLE_REMOTE                        : integer := 47;  --! 0: Angle measurements disabled >0: Id of the receiving node
    constant mdaq2_ANGLE_FREQ                          : integer := 48;  --! Transmission frequency of new angular data
    constant mdaq2_ANGLE_OUTPUT                        : integer := 49;  --! 0: foot angles
    constant mdaq2_ANGLE_OFFSET                        : integer := 50;  --! 0->1: Trigger offset compensation
    constant mdaq2_POLY_REMOTE                         : integer := 51;  --! 0: Polygon handler disabled >0: Id of the receiving node
    constant mdaq2_POLY_THRESH                         : integer := 52;  --! Threshold for polygon calculations
    constant mdaq2_PD_REMOTE                           : integer := 53;  --! 0: Phase detection disabled >0: Id of the receiving node
    constant mdaq2_PD_LOW                              : integer := 54;  --! Lower threshold in N
    constant mdaq2_PD_HIGH                             : integer := 55;  --! Higher threshold in N
    constant mdaq2_FT_OFFSET_0                         : integer := 56;  --! FT: Offset for Fx
    constant mdaq2_FT_OFFSET_1                         : integer := 57;  --! FT: Offset for Fy
    constant mdaq2_FT_OFFSET_2                         : integer := 58;  --! FT: Offset for Fz
    constant mdaq2_FT_OFFSET_3                         : integer := 59;  --! FT: Offset for Tx
    constant mdaq2_FT_OFFSET_4                         : integer := 60;  --! FT: Offset for Ty
    constant mdaq2_FT_OFFSET_5                         : integer := 61;  --! FT: Offset for Tz
    constant mdaq2_ANGLE_OFFSET_0                      : integer := 62;  --! ANGLE: Offset 0 (sign denotes orientation, abs is the offset)
    constant mdaq2_ANGLE_OFFSET_1                      : integer := 63;  --! ANGLE: Offset 1 (sign denotes orientation, abs is the offset)
    constant mdaq2_ANGLE_OFFSET_2                      : integer := 64;  --! ANGLE: Offset 2 (sign denotes orientation, abs is the offset)
    constant mdaq2_ANGLE_OFFSET_3                      : integer := 65;  --! ANGLE: Offset 3 (sign denotes orientation, abs is the offset)
    constant mdaq2_FT_ANGLE_X                          : integer := 66;  --! FT: Angle X for XYZ Trafo in deg
    constant mdaq2_FT_ANGLE_Y                          : integer := 67;  --! FT: Angle Y for XYZ Trafo in deg
    constant mdaq2_FT_ANGLE_Z                          : integer := 68;  --! FT: Angle Z for XYZ Trafo in deg
    constant mdaq2_LIS3_ANGLE_X                        : integer := 69;  --! LIS3: Angle X for XYZ Trafo in deg
    constant mdaq2_LIS3_ANGLE_Y                        : integer := 70;  --! LIS3: Angle Y for XYZ Trafo in deg
    constant mdaq2_LIS3_ANGLE_Z                        : integer := 71;  --! LIS3: Angle Z for XYZ Trafo in deg

    -- DMSBoard
    constant DMSBoard_VOUT_5V                          : integer := 1;  --! Measured voltage on 5V output rail
    constant DMSBoard_FT_FREQ                          : integer := 6;  --! Transmission frequency of new FT data
    constant DMSBoard_FT_SENSOR                        : integer := 7;  --! 0: undefined 1: FT11129 2: FT11481 3: FT11483 4: FT11484 5: FTSpine
    constant DMSBoard_FT_GAIN                          : integer := 8;  --! Sets amplification of raw signals to 10^{0-3}
    constant DMSBoard_FT_OFFSET                        : integer := 9;  --! 1: Trigger offset compensation of FT vector
    constant DMSBoard_FT_FILTER_TYPE                   : integer := 10;  --! 0: No Filtering 1: Butterworth 2: Median 3: Moving Average
    constant DMSBoard_FT_FILTER_LEN                    : integer := 11;  --! Length of the buffer used for filtering
    constant DMSBoard_FT_FILTER_ORDER                  : integer := 12;  --! Order of the butterworth filter
    constant DMSBoard_FT_FILTER_CUTOFF                 : integer := 13;  --! Normalized cutoff frequency of the butterworth filter
    constant DMSBoard_FT_FILTER_ATT                    : integer := 14;  --! Attenuation at cutoff frequency of the butterworth filter


    -- ------------------------------------- --
    -- Old DeviceClasses output (deprecated) --
    -- ------------------------------------- --

      subtype NDLCom_NODE_ID_RANGE is Natural range 0 downto 0; -- 1

      subtype FPGAJoint_SYNTHESIS_YEAR_RANGE is Natural range 1 downto 1; -- 1
      subtype FPGAJoint_SYNTHESIS_MONTH_RANGE is Natural range 2 downto 2; -- 1
      subtype FPGAJoint_SYNTHESIS_DAY_RANGE is Natural range 3 downto 3; -- 1
      subtype FPGAJoint_SYNTHESIS_AUTHOR_RANGE is Natural range 4 downto 4; -- 1

      subtype BLDCJoint_STACK_VERSION_RANGE is Natural range 5 downto 5; -- 1
      constant BLDCJoint_TICKS_PER_TURN_0                  : integer := 6; -- 
      constant BLDCJoint_TICKS_PER_TURN_1                  : integer := 7; -- 
      constant BLDCJoint_TICKS_PER_TURN_2                  : integer := 8; -- 
      constant BLDCJoint_TICKS_PER_TURN_3                  : integer := 9; -- 
      subtype BLDCJoint_TICKS_PER_TURN_RANGE is Natural range 9 downto 6; -- 4
      subtype BLDCJoint_INVERT_CONFIG_RANGE is Natural range 10 downto 10; -- 1
      constant BLDCJoint_ABS_POS_OFFSET_0                  : integer := 14; -- 
      constant BLDCJoint_ABS_POS_OFFSET_1                  : integer := 15; -- 
      subtype BLDCJoint_ABS_POS_OFFSET_RANGE is Natural range 15 downto 14; -- 2
      subtype BLDCJoint_ICHAUS_GCC_RANGE is Natural range 16 downto 16; -- 1
      subtype BLDCJoint_ICHAUS_VOSS_RANGE is Natural range 17 downto 17; -- 1
      subtype BLDCJoint_ICHAUS_VOSC_RANGE is Natural range 18 downto 18; -- 1
      subtype BLDCJoint_CUR_FILTER_DAMPING_RANGE is Natural range 19 downto 19; -- 1
      subtype BLDCJoint_VEL_FILTER_DAMPING_RANGE is Natural range 20 downto 20; -- 1
      subtype BLDCJoint_ACC_FILTER_DAMPING_RANGE is Natural range 21 downto 21; -- 1
      subtype BLDCJoint_PWM_FILTER_DAMPING_RANGE is Natural range 22 downto 22; -- 1
      constant BLDCJoint_INIT_ERROR_IGNORE_0               : integer := 23; -- 
      constant BLDCJoint_INIT_ERROR_IGNORE_1               : integer := 24; -- 
      constant BLDCJoint_INIT_ERROR_IGNORE_2               : integer := 25; -- 
      constant BLDCJoint_INIT_ERROR_IGNORE_3               : integer := 26; -- 
      subtype BLDCJoint_INIT_ERROR_IGNORE_RANGE is Natural range 26 downto 23; -- 4
      constant BLDCJoint_INIT_ERROR_DISABLE_0              : integer := 24; -- 
      constant BLDCJoint_INIT_ERROR_DISABLE_1              : integer := 25; -- 
      constant BLDCJoint_INIT_ERROR_DISABLE_2              : integer := 26; -- 
      constant BLDCJoint_INIT_ERROR_DISABLE_3              : integer := 27; -- 
      subtype BLDCJoint_INIT_ERROR_DISABLE_RANGE is Natural range 27 downto 24; -- 4
      constant BLDCJoint_ERROR_IGNORE_0                    : integer := 25; -- 
      constant BLDCJoint_ERROR_IGNORE_1                    : integer := 26; -- 
      constant BLDCJoint_ERROR_IGNORE_2                    : integer := 27; -- 
      constant BLDCJoint_ERROR_IGNORE_3                    : integer := 28; -- 
      subtype BLDCJoint_ERROR_IGNORE_RANGE is Natural range 28 downto 25; -- 4
      constant BLDCJoint_ERROR_DISABLE_0                   : integer := 26; -- 
      constant BLDCJoint_ERROR_DISABLE_1                   : integer := 27; -- 
      constant BLDCJoint_ERROR_DISABLE_2                   : integer := 28; -- 
      constant BLDCJoint_ERROR_DISABLE_3                   : integer := 29; -- 
      subtype BLDCJoint_ERROR_DISABLE_RANGE is Natural range 29 downto 26; -- 4
      constant BLDCJoint_POS_MIN_HARD_LIMIT_0              : integer := 27; -- 
      constant BLDCJoint_POS_MIN_HARD_LIMIT_1              : integer := 28; -- 
      subtype BLDCJoint_POS_MIN_HARD_LIMIT_RANGE is Natural range 28 downto 27; -- 2
      constant BLDCJoint_POS_MAX_HARD_LIMIT_0              : integer := 28; -- 
      constant BLDCJoint_POS_MAX_HARD_LIMIT_1              : integer := 29; -- 
      subtype BLDCJoint_POS_MAX_HARD_LIMIT_RANGE is Natural range 29 downto 28; -- 2
      constant BLDCJoint_VEL_HARD_LIMIT_0                  : integer := 29; -- 
      constant BLDCJoint_VEL_HARD_LIMIT_1                  : integer := 30; -- 
      constant BLDCJoint_VEL_HARD_LIMIT_2                  : integer := 31; -- 
      constant BLDCJoint_VEL_HARD_LIMIT_3                  : integer := 32; -- 
      subtype BLDCJoint_VEL_HARD_LIMIT_RANGE is Natural range 32 downto 29; -- 4
      constant BLDCJoint_CUR_HARD_LIMIT_0                  : integer := 30; -- 
      constant BLDCJoint_CUR_HARD_LIMIT_1                  : integer := 31; -- 
      subtype BLDCJoint_CUR_HARD_LIMIT_RANGE is Natural range 31 downto 30; -- 2
      constant BLDCJoint_MAX_TEMP_LIMIT_0                  : integer := 31; -- 
      constant BLDCJoint_MAX_TEMP_LIMIT_1                  : integer := 32; -- 
      subtype BLDCJoint_MAX_TEMP_LIMIT_RANGE is Natural range 32 downto 31; -- 2
      constant BLDCJoint_CONFIG_0                          : integer := 266; -- 
      constant BLDCJoint_CONFIG_1                          : integer := 267; -- 
      subtype BLDCJoint_CONFIG_RANGE is Natural range 267 downto 266; -- 2
        constant BLDCJoint_CONFIG_0_ENABLE_CMD_BIT                : integer := 0; --! Enable command
        constant BLDCJoint_CONFIG_0_INTERPOLATOR_BIT              : integer := 1; --! Enable interpolator
        constant BLDCJoint_CONFIG_0_DIRECT_PWM_BIT                : integer := 2; --! Enable direct pwm
        constant BLDCJoint_CONFIG_0_ZERO_POS_BIT                  : integer := 3; --! Set position offset, so that this position is zero.
        constant BLDCJoint_CONFIG_0_RESET_POS_BIT                 : integer := 4; --! Set incremental encoder position to absolute position
        constant BLDCJoint_CONFIG_0_RESET_ERRORS_BIT              : integer := 5; --! Trigger reset of error flags
        constant BLDCJoint_CONFIG_0_OPEN_BRAKE_BIT                : integer := 6; --! Open the brake
        constant BLDCJoint_CONFIG_0_WRITE_SETTINGS_BIT            : integer := 7; --! Write settings trigger
        constant BLDCJoint_CONFIG_1_DEBUG_MODE_BIT                : integer := 3; --! Enable debug mode
      constant BLDCJoint_DIRECT_PWM_0                      : integer := 272; -- 
      constant BLDCJoint_DIRECT_PWM_1                      : integer := 273; -- 
      subtype BLDCJoint_DIRECT_PWM_RANGE is Natural range 273 downto 272; -- 2
      constant BLDCJoint_WARNING_0                         : integer := 516; -- 
      constant BLDCJoint_WARNING_1                         : integer := 517; -- 
      constant BLDCJoint_WARNING_2                         : integer := 518; -- 
      constant BLDCJoint_WARNING_3                         : integer := 519; -- 
      subtype BLDCJoint_WARNING_RANGE is Natural range 519 downto 516; -- 4
        constant BLDCJoint_WARNING_0_INIT_BIT                     : integer := 0; --! Initialization fail
        constant BLDCJoint_WARNING_0_POSITIONDIFFERENCE_BIT       : integer := 1; --! Position difference between incremental and absolute encoder too large
        constant BLDCJoint_WARNING_0_POS_HARD_LIMIT_BIT           : integer := 2; --! Position value out of hard limits
        constant BLDCJoint_WARNING_0_VEL_HARD_LIMIT_BIT           : integer := 3; --! Velocity value out of hard limits
        constant BLDCJoint_WARNING_0_CUR_HARD_LIMIT_BIT           : integer := 4; --! Current value out of hard limits
        constant BLDCJoint_WARNING_0_COMMTIMEOUTANY_BIT           : integer := 5; --! Timeout since any communication
        constant BLDCJoint_WARNING_0_COMMTIMEOUTARMCMD_BIT        : integer := 6; --! Timeout since last arm command message
        constant BLDCJoint_WARNING_0_TEMPERATURE_BIT              : integer := 7; --! Temperature to high
        constant BLDCJoint_WARNING_1_SENSOR_ICHAUS_BIT            : integer := 0; --! Absolute pos. sensor failed
        constant BLDCJoint_WARNING_1_SENSOR_OPTO_BIT              : integer := 1; --! Optical pos. sensor failed
        constant BLDCJoint_WARNING_1_SENSOR_HALL_BIT              : integer := 2; --! Hall sensor failed
        constant BLDCJoint_WARNING_1_SENSOR_CURRENT_BIT           : integer := 3; --! Current sensor failed
        constant BLDCJoint_WARNING_1_FRICTION_IDENT_BIT           : integer := 4; --! Friction identification failed
        constant BLDCJoint_WARNING_1_VOLTAGE_BIT                  : integer := 5; --! Voltage to high
        constant BLDCJoint_WARNING_1_CTRL_LIMIT_BIT               : integer := 6; --! One of the controller values saturated
        constant BLDCJoint_WARNING_1_TELEMETRY_TIMEOUT_BIT        : integer := 7; --! Telemetry timeout at MCS
        constant BLDCJoint_WARNING_2_MOTOR_HALL_DATA_BIT          : integer := 0; --! Motor: hall values are invalid
        constant BLDCJoint_WARNING_2_MOTOR_INCR_DATA_BIT          : integer := 1; --! Motor: incremental encoder values are invalid
      constant BLDCJoint_ERROR_0                           : integer := 518; -- 
      constant BLDCJoint_ERROR_1                           : integer := 519; -- 
      constant BLDCJoint_ERROR_2                           : integer := 520; -- 
      constant BLDCJoint_ERROR_3                           : integer := 521; -- 
      subtype BLDCJoint_ERROR_RANGE is Natural range 521 downto 518; -- 4
        constant BLDCJoint_ERROR_0_INIT_BIT                       : integer := 0; --! Initialization fail
        constant BLDCJoint_ERROR_0_POSITIONDIFFERENCE_BIT         : integer := 1; --! Position difference between incremental and absolute encoder too large
        constant BLDCJoint_ERROR_0_POS_HARD_LIMIT_BIT             : integer := 2; --! Position value out of hard limits
        constant BLDCJoint_ERROR_0_VEL_HARD_LIMIT_BIT             : integer := 3; --! Velocity value out of hard limits
        constant BLDCJoint_ERROR_0_CUR_HARD_LIMIT_BIT             : integer := 4; --! Current value out of hard limits
        constant BLDCJoint_ERROR_0_COMMTIMEOUTANY_BIT             : integer := 5; --! Timeout since any communication
        constant BLDCJoint_ERROR_0_COMMTIMEOUTARMCMD_BIT          : integer := 6; --! Timeout since last arm command message
        constant BLDCJoint_ERROR_0_TEMPERATURE_BIT                : integer := 7; --! Temperature to high
        constant BLDCJoint_ERROR_1_SENSOR_ICHAUS_BIT              : integer := 0; --! Absolute pos. sensor failed
        constant BLDCJoint_ERROR_1_SENSOR_OPTO_BIT                : integer := 1; --! Optical pos. sensor failed
        constant BLDCJoint_ERROR_1_SENSOR_HALL_BIT                : integer := 2; --! Hall sensor failed
        constant BLDCJoint_ERROR_1_SENSOR_CURRENT_BIT             : integer := 3; --! Current sensor failed
        constant BLDCJoint_ERROR_1_FRICTION_IDENT_BIT             : integer := 4; --! Friction identification failed
        constant BLDCJoint_ERROR_1_VOLTAGE_BIT                    : integer := 5; --! Voltage to high
        constant BLDCJoint_ERROR_1_CTRL_LIMIT_BIT                 : integer := 6; --! One of the controller values saturated
        constant BLDCJoint_ERROR_1_TELEMETRY_TIMEOUT_BIT          : integer := 7; --! Telemetry timeout at MCS
        constant BLDCJoint_ERROR_2_MOTOR_HALL_DATA_BIT            : integer := 0; --! Motor: hall values are invalid
        constant BLDCJoint_ERROR_2_MOTOR_INCR_DATA_BIT            : integer := 1; --! Motor: incremental encoder values are invalid
      constant BLDCJoint_TEMPERATURE0_0                    : integer := 540; -- 
      constant BLDCJoint_TEMPERATURE0_1                    : integer := 541; -- 
      subtype BLDCJoint_TEMPERATURE0_RANGE is Natural range 541 downto 540; -- 2
      constant BLDCJoint_TEMPERATURE1_0                    : integer := 542; -- 
      constant BLDCJoint_TEMPERATURE1_1                    : integer := 543; -- 
      subtype BLDCJoint_TEMPERATURE1_RANGE is Natural range 543 downto 542; -- 2
      constant BLDCJoint_STATE_0                           : integer := 550; -- 
      constant BLDCJoint_STATE_1                           : integer := 551; -- 
      subtype BLDCJoint_STATE_RANGE is Natural range 551 downto 550; -- 2
        constant BLDCJoint_STATE_0_ENABLE_BIT                     : integer := 0; --! Motor enable flag
        constant BLDCJoint_STATE_0_WARNINGFLAG_BIT                : integer := 1; --! Joint in warning condition
        constant BLDCJoint_STATE_0_ERRORFLAG_BIT                  : integer := 2; --! Joint in error condition
        constant BLDCJoint_STATE_0_TELEMETRY_AVAILABLE_BIT        : integer := 7; --! Telemetry available flag
        constant BLDCJoint_STATE_1_ENABLE_CMD_BIT                 : integer := 0; --! Enable command
        constant BLDCJoint_STATE_1_INTERPOLATOR_BIT               : integer := 1; --! Interpolator flag
        constant BLDCJoint_STATE_1_HALL0_BIT                      : integer := 4; --! Hall Signal 0
        constant BLDCJoint_STATE_1_HALL1_BIT                      : integer := 5; --! Hall Signal 1
        constant BLDCJoint_STATE_1_HALL2_BIT                      : integer := 6; --! Hall Signal 2
        constant BLDCJoint_STATE_1_PROM_BUSY_BIT                  : integer := 7; --! EEPROM Busy
      constant BLDCJoint_ABSOLUTE_POSITION_0               : integer := 551; -- 
      constant BLDCJoint_ABSOLUTE_POSITION_1               : integer := 552; -- 
      subtype BLDCJoint_ABSOLUTE_POSITION_RANGE is Natural range 552 downto 551; -- 2
      constant BLDCJoint_POSITION_0                        : integer := 552; -- 
      constant BLDCJoint_POSITION_1                        : integer := 553; -- 
      subtype BLDCJoint_POSITION_RANGE is Natural range 553 downto 552; -- 2
      constant BLDCJoint_SPEED_0                           : integer := 553; -- 
      constant BLDCJoint_SPEED_1                           : integer := 554; -- 
      constant BLDCJoint_SPEED_2                           : integer := 555; -- 
      constant BLDCJoint_SPEED_3                           : integer := 556; -- 
      subtype BLDCJoint_SPEED_RANGE is Natural range 556 downto 553; -- 4
      constant BLDCJoint_PWM_0                             : integer := 554; -- 
      constant BLDCJoint_PWM_1                             : integer := 555; -- 
      subtype BLDCJoint_PWM_RANGE is Natural range 555 downto 554; -- 2
      constant BLDCJoint_VOLTAGE_0                         : integer := 555; -- 
      constant BLDCJoint_VOLTAGE_1                         : integer := 556; -- 
      subtype BLDCJoint_VOLTAGE_RANGE is Natural range 556 downto 555; -- 2
      constant BLDCJoint_CURRENT_0                         : integer := 556; -- 
      constant BLDCJoint_CURRENT_1                         : integer := 557; -- 
      subtype BLDCJoint_CURRENT_RANGE is Natural range 557 downto 556; -- 2
      constant BLDCJoint_TEMPERATURE_0                     : integer := 557; -- 
      constant BLDCJoint_TEMPERATURE_1                     : integer := 558; -- 
      subtype BLDCJoint_TEMPERATURE_RANGE is Natural range 558 downto 557; -- 2
      constant BLDCJoint_DESIRED_POSITION_0                : integer := 558; -- 
      constant BLDCJoint_DESIRED_POSITION_1                : integer := 559; -- 
      subtype BLDCJoint_DESIRED_POSITION_RANGE is Natural range 559 downto 558; -- 2
      constant BLDCJoint_CTRL_PWM_0                        : integer := 559; -- 
      constant BLDCJoint_CTRL_PWM_1                        : integer := 560; -- 
      subtype BLDCJoint_CTRL_PWM_RANGE is Natural range 560 downto 559; -- 2
      constant BLDCJoint_DEBUG1_0                          : integer := 560; -- 
      constant BLDCJoint_DEBUG1_1                          : integer := 561; -- 
      subtype BLDCJoint_DEBUG1_RANGE is Natural range 561 downto 560; -- 2
      constant BLDCJoint_DEBUG2_0                          : integer := 561; -- 
      constant BLDCJoint_DEBUG2_1                          : integer := 562; -- 
      subtype BLDCJoint_DEBUG2_RANGE is Natural range 562 downto 561; -- 2
      constant BLDCJoint_DEBUG3_0                          : integer := 562; -- 
      constant BLDCJoint_DEBUG3_1                          : integer := 563; -- 
      subtype BLDCJoint_DEBUG3_RANGE is Natural range 563 downto 562; -- 2
      constant BLDCJoint_DEBUG4_0                          : integer := 563; -- 
      constant BLDCJoint_DEBUG4_1                          : integer := 564; -- 
      subtype BLDCJoint_DEBUG4_RANGE is Natural range 564 downto 563; -- 2
      constant BLDCJoint_DEBUG5_0                          : integer := 564; -- 
      constant BLDCJoint_DEBUG5_1                          : integer := 565; -- 
      subtype BLDCJoint_DEBUG5_RANGE is Natural range 565 downto 564; -- 2

      constant CascadedController_POS_P_0                  : integer := 32; -- 
      constant CascadedController_POS_P_1                  : integer := 33; -- 
      constant CascadedController_POS_P_2                  : integer := 34; -- 
      constant CascadedController_POS_P_3                  : integer := 35; -- 
      subtype CascadedController_POS_P_RANGE is Natural range 35 downto 32; -- 4
      constant CascadedController_POS_I_0                  : integer := 36; -- 
      constant CascadedController_POS_I_1                  : integer := 37; -- 
      constant CascadedController_POS_I_2                  : integer := 38; -- 
      constant CascadedController_POS_I_3                  : integer := 39; -- 
      subtype CascadedController_POS_I_RANGE is Natural range 39 downto 36; -- 4
      constant CascadedController_POS_D_0                  : integer := 40; -- 
      constant CascadedController_POS_D_1                  : integer := 41; -- 
      constant CascadedController_POS_D_2                  : integer := 42; -- 
      constant CascadedController_POS_D_3                  : integer := 43; -- 
      subtype CascadedController_POS_D_RANGE is Natural range 43 downto 40; -- 4
      constant CascadedController_VEL_P_0                  : integer := 44; -- 
      constant CascadedController_VEL_P_1                  : integer := 45; -- 
      constant CascadedController_VEL_P_2                  : integer := 46; -- 
      constant CascadedController_VEL_P_3                  : integer := 47; -- 
      subtype CascadedController_VEL_P_RANGE is Natural range 47 downto 44; -- 4
      constant CascadedController_VEL_I_0                  : integer := 48; -- 
      constant CascadedController_VEL_I_1                  : integer := 49; -- 
      constant CascadedController_VEL_I_2                  : integer := 50; -- 
      constant CascadedController_VEL_I_3                  : integer := 51; -- 
      subtype CascadedController_VEL_I_RANGE is Natural range 51 downto 48; -- 4
      constant CascadedController_VEL_D_0                  : integer := 52; -- 
      constant CascadedController_VEL_D_1                  : integer := 53; -- 
      constant CascadedController_VEL_D_2                  : integer := 54; -- 
      constant CascadedController_VEL_D_3                  : integer := 55; -- 
      subtype CascadedController_VEL_D_RANGE is Natural range 55 downto 52; -- 4
      constant CascadedController_CUR_P_0                  : integer := 56; -- 
      constant CascadedController_CUR_P_1                  : integer := 57; -- 
      constant CascadedController_CUR_P_2                  : integer := 58; -- 
      constant CascadedController_CUR_P_3                  : integer := 59; -- 
      subtype CascadedController_CUR_P_RANGE is Natural range 59 downto 56; -- 4
      constant CascadedController_CUR_I_0                  : integer := 60; -- 
      constant CascadedController_CUR_I_1                  : integer := 61; -- 
      constant CascadedController_CUR_I_2                  : integer := 62; -- 
      constant CascadedController_CUR_I_3                  : integer := 63; -- 
      subtype CascadedController_CUR_I_RANGE is Natural range 63 downto 60; -- 4
      constant CascadedController_CUR_D_0                  : integer := 64; -- 
      constant CascadedController_CUR_D_1                  : integer := 65; -- 
      constant CascadedController_CUR_D_2                  : integer := 66; -- 
      constant CascadedController_CUR_D_3                  : integer := 67; -- 
      subtype CascadedController_CUR_D_RANGE is Natural range 67 downto 64; -- 4
      constant CascadedController_POS_DEAD_ZONE_0          : integer := 68; -- 
      constant CascadedController_POS_DEAD_ZONE_1          : integer := 69; -- 
      subtype CascadedController_POS_DEAD_ZONE_RANGE is Natural range 69 downto 68; -- 2
      constant CascadedController_VEL_DEAD_ZONE_0          : integer := 70; -- 
      constant CascadedController_VEL_DEAD_ZONE_1          : integer := 71; -- 
      constant CascadedController_VEL_DEAD_ZONE_2          : integer := 72; -- 
      constant CascadedController_VEL_DEAD_ZONE_3          : integer := 73; -- 
      subtype CascadedController_VEL_DEAD_ZONE_RANGE is Natural range 73 downto 70; -- 4
      constant CascadedController_CUR_DEAD_ZONE_0          : integer := 74; -- 
      constant CascadedController_CUR_DEAD_ZONE_1          : integer := 75; -- 
      subtype CascadedController_CUR_DEAD_ZONE_RANGE is Natural range 75 downto 74; -- 2
      constant CascadedController_POS_MAX_ERROR_INTEGRAL_0 : integer := 76; -- 
      constant CascadedController_POS_MAX_ERROR_INTEGRAL_1 : integer := 77; -- 
      subtype CascadedController_POS_MAX_ERROR_INTEGRAL_RANGE is Natural range 77 downto 76; -- 2
      constant CascadedController_VEL_MAX_ERROR_INTEGRAL_0 : integer := 78; -- 
      constant CascadedController_VEL_MAX_ERROR_INTEGRAL_1 : integer := 79; -- 
      subtype CascadedController_VEL_MAX_ERROR_INTEGRAL_RANGE is Natural range 79 downto 78; -- 2
      constant CascadedController_CUR_MAX_ERROR_INTEGRAL_0 : integer := 80; -- 
      constant CascadedController_CUR_MAX_ERROR_INTEGRAL_1 : integer := 81; -- 
      subtype CascadedController_CUR_MAX_ERROR_INTEGRAL_RANGE is Natural range 81 downto 80; -- 2
      constant CascadedController_POS_MAX_CTRL_VAL_0       : integer := 82; -- 
      constant CascadedController_POS_MAX_CTRL_VAL_1       : integer := 83; -- 
      subtype CascadedController_POS_MAX_CTRL_VAL_RANGE is Natural range 83 downto 82; -- 2
      constant CascadedController_VEL_MAX_CTRL_VAL_0       : integer := 84; -- 
      constant CascadedController_VEL_MAX_CTRL_VAL_1       : integer := 85; -- 
      subtype CascadedController_VEL_MAX_CTRL_VAL_RANGE is Natural range 85 downto 84; -- 2
      constant CascadedController_CUR_MAX_CTRL_VAL_0       : integer := 86; -- 
      constant CascadedController_CUR_MAX_CTRL_VAL_1       : integer := 87; -- 
      subtype CascadedController_CUR_MAX_CTRL_VAL_RANGE is Natural range 87 downto 86; -- 2
      constant CascadedController_POS_MIN_0                : integer := 88; -- 
      constant CascadedController_POS_MIN_1                : integer := 89; -- 
      subtype CascadedController_POS_MIN_RANGE is Natural range 89 downto 88; -- 2
      constant CascadedController_POS_MAX_0                : integer := 90; -- 
      constant CascadedController_POS_MAX_1                : integer := 91; -- 
      subtype CascadedController_POS_MAX_RANGE is Natural range 91 downto 90; -- 2
      constant CascadedController_VEL_MAX_0                : integer := 92; -- 
      constant CascadedController_VEL_MAX_1                : integer := 93; -- 
      constant CascadedController_VEL_MAX_2                : integer := 94; -- 
      constant CascadedController_VEL_MAX_3                : integer := 95; -- 
      subtype CascadedController_VEL_MAX_RANGE is Natural range 95 downto 92; -- 4
      constant CascadedController_CUR_MAX_0                : integer := 96; -- 
      constant CascadedController_CUR_MAX_1                : integer := 97; -- 
      subtype CascadedController_CUR_MAX_RANGE is Natural range 97 downto 96; -- 2
      subtype CascadedController_CTRL_MODE_RANGE is Natural range 98 downto 98; -- 1
      constant CascadedController_POS_REF_0                : integer := 256; -- 
      constant CascadedController_POS_REF_1                : integer := 257; -- 
      subtype CascadedController_POS_REF_RANGE is Natural range 257 downto 256; -- 2
      constant CascadedController_VEL_REF_0                : integer := 258; -- 
      constant CascadedController_VEL_REF_1                : integer := 259; -- 
      constant CascadedController_VEL_REF_2                : integer := 260; -- 
      constant CascadedController_VEL_REF_3                : integer := 261; -- 
      subtype CascadedController_VEL_REF_RANGE is Natural range 261 downto 258; -- 4
      constant CascadedController_ACC_REF_0                : integer := 262; -- 
      constant CascadedController_ACC_REF_1                : integer := 263; -- 
      subtype CascadedController_ACC_REF_RANGE is Natural range 263 downto 262; -- 2
      constant CascadedController_CUR_REF_0                : integer := 264; -- 
      constant CascadedController_CUR_REF_1                : integer := 265; -- 
      subtype CascadedController_CUR_REF_RANGE is Natural range 265 downto 264; -- 2
      subtype CascadedController_ACTIVE_SATURATIONS_RANGE is Natural range 512 downto 512; -- 1

      subtype MotionController_General_MOTION_MODE_RANGE is Natural range 0 downto 0; -- 1
      constant MotionController_General_MOTORS_ENABLE_0    : integer := 1; -- 
      constant MotionController_General_MOTORS_ENABLE_1    : integer := 2; -- 
      constant MotionController_General_MOTORS_ENABLE_2    : integer := 3; -- 
      constant MotionController_General_MOTORS_ENABLE_3    : integer := 4; -- 
      subtype MotionController_General_MOTORS_ENABLE_RANGE is Natural range 4 downto 1; -- 4
      subtype MotionController_General_CLKSYNC_ENABLE_RANGE is Natural range 2 downto 2; -- 1
      constant MotionController_General_CLKSYNC_PERIOD_0   : integer := 3; -- 
      constant MotionController_General_CLKSYNC_PERIOD_1   : integer := 4; -- 
      constant MotionController_General_CLKSYNC_PERIOD_2   : integer := 5; -- 
      constant MotionController_General_CLKSYNC_PERIOD_3   : integer := 6; -- 
      subtype MotionController_General_CLKSYNC_PERIOD_RANGE is Natural range 6 downto 3; -- 4
      subtype MotionController_General_LOGGING_NORMAL_ENABLE_RANGE is Natural range 4 downto 4; -- 1
      subtype MotionController_General_LOGGING_EMERGENCY_TRIGGER_RANGE is Natural range 5 downto 5; -- 1
      constant MotionController_General_LOGGING_EMERGENCY_KEEPTIME_SECONDS_0 : integer := 6; -- 
      constant MotionController_General_LOGGING_EMERGENCY_KEEPTIME_SECONDS_1 : integer := 7; -- 
      constant MotionController_General_LOGGING_EMERGENCY_KEEPTIME_SECONDS_2 : integer := 8; -- 
      constant MotionController_General_LOGGING_EMERGENCY_KEEPTIME_SECONDS_3 : integer := 9; -- 
      subtype MotionController_General_LOGGING_EMERGENCY_KEEPTIME_SECONDS_RANGE is Natural range 9 downto 6; -- 4
      subtype MotionController_General_POSTURE_DEMO_ENABLE_RANGE is Natural range 7 downto 7; -- 1
      subtype MotionController_General_SEQUENCE_DEMO_RANGE is Natural range 8 downto 8; -- 1
      subtype MotionController_General_KRAFTAUSGLEICH_RANGE is Natural range 9 downto 9; -- 1
      constant MotionController_General_KRAFTAUSGLEICH_MAX_OFFSET_0 : integer := 10; -- 
      constant MotionController_General_KRAFTAUSGLEICH_MAX_OFFSET_1 : integer := 11; -- 
      constant MotionController_General_KRAFTAUSGLEICH_MAX_OFFSET_2 : integer := 12; -- 
      constant MotionController_General_KRAFTAUSGLEICH_MAX_OFFSET_3 : integer := 13; -- 
      subtype MotionController_General_KRAFTAUSGLEICH_MAX_OFFSET_RANGE is Natural range 13 downto 10; -- 4
      constant MotionController_General_KRAFTAUSGLEICH_GAIN_0 : integer := 11; -- 
      constant MotionController_General_KRAFTAUSGLEICH_GAIN_1 : integer := 12; -- 
      constant MotionController_General_KRAFTAUSGLEICH_GAIN_2 : integer := 13; -- 
      constant MotionController_General_KRAFTAUSGLEICH_GAIN_3 : integer := 14; -- 
      subtype MotionController_General_KRAFTAUSGLEICH_GAIN_RANGE is Natural range 14 downto 11; -- 4
      subtype MotionController_General_HEAD_CONTROL_DIRECT_RANGE is Natural range 12 downto 12; -- 1
      subtype MotionController_General_RANDOM_WALK_LEG_ID_RANGE is Natural range 13 downto 13; -- 1
      subtype MotionController_General_GLOBAL_SUPPORT_POLYGON_REFERENCE_FRAME_RANGE is Natural range 14 downto 14; -- 1

      constant MotionController_Balance_BALANCE_ENABLE_0   : integer := 1500; -- 
      constant MotionController_Balance_BALANCE_ENABLE_1   : integer := 1501; -- 
      constant MotionController_Balance_BALANCE_ENABLE_2   : integer := 1502; -- 
      constant MotionController_Balance_BALANCE_ENABLE_3   : integer := 1503; -- 
      subtype MotionController_Balance_BALANCE_ENABLE_RANGE is Natural range 1503 downto 1500; -- 4
      subtype MotionController_Balance_BALANCE_ENABLE_PLOT_RANGE is Natural range 1501 downto 1501; -- 1
      constant MotionController_Balance_BALANCE_SCALING_X_0 : integer := 1505; -- 
      constant MotionController_Balance_BALANCE_SCALING_X_1 : integer := 1506; -- 
      constant MotionController_Balance_BALANCE_SCALING_X_2 : integer := 1507; -- 
      constant MotionController_Balance_BALANCE_SCALING_X_3 : integer := 1508; -- 
      subtype MotionController_Balance_BALANCE_SCALING_X_RANGE is Natural range 1508 downto 1505; -- 4
      constant MotionController_Balance_BALANCE_SCALING_Y_0 : integer := 1506; -- 
      constant MotionController_Balance_BALANCE_SCALING_Y_1 : integer := 1507; -- 
      constant MotionController_Balance_BALANCE_SCALING_Y_2 : integer := 1508; -- 
      constant MotionController_Balance_BALANCE_SCALING_Y_3 : integer := 1509; -- 
      subtype MotionController_Balance_BALANCE_SCALING_Y_RANGE is Natural range 1509 downto 1506; -- 4
      constant MotionController_Balance_BALANCE_SCALING_Z_0 : integer := 1507; -- 
      constant MotionController_Balance_BALANCE_SCALING_Z_1 : integer := 1508; -- 
      constant MotionController_Balance_BALANCE_SCALING_Z_2 : integer := 1509; -- 
      constant MotionController_Balance_BALANCE_SCALING_Z_3 : integer := 1510; -- 
      subtype MotionController_Balance_BALANCE_SCALING_Z_RANGE is Natural range 1510 downto 1507; -- 4
      constant MotionController_Balance_BALANCE_SCALING_PITCH_0 : integer := 1508; -- 
      constant MotionController_Balance_BALANCE_SCALING_PITCH_1 : integer := 1509; -- 
      constant MotionController_Balance_BALANCE_SCALING_PITCH_2 : integer := 1510; -- 
      constant MotionController_Balance_BALANCE_SCALING_PITCH_3 : integer := 1511; -- 
      subtype MotionController_Balance_BALANCE_SCALING_PITCH_RANGE is Natural range 1511 downto 1508; -- 4
      constant MotionController_Balance_BALANCE_SCALING_ROLL_0 : integer := 1509; -- 
      constant MotionController_Balance_BALANCE_SCALING_ROLL_1 : integer := 1510; -- 
      constant MotionController_Balance_BALANCE_SCALING_ROLL_2 : integer := 1511; -- 
      constant MotionController_Balance_BALANCE_SCALING_ROLL_3 : integer := 1512; -- 
      subtype MotionController_Balance_BALANCE_SCALING_ROLL_RANGE is Natural range 1512 downto 1509; -- 4
      constant MotionController_Balance_BALANCE_OFFSET_X_0 : integer := 1510; -- 
      constant MotionController_Balance_BALANCE_OFFSET_X_1 : integer := 1511; -- 
      constant MotionController_Balance_BALANCE_OFFSET_X_2 : integer := 1512; -- 
      constant MotionController_Balance_BALANCE_OFFSET_X_3 : integer := 1513; -- 
      subtype MotionController_Balance_BALANCE_OFFSET_X_RANGE is Natural range 1513 downto 1510; -- 4
      constant MotionController_Balance_BALANCE_OFFSET_Y_0 : integer := 1511; -- 
      constant MotionController_Balance_BALANCE_OFFSET_Y_1 : integer := 1512; -- 
      constant MotionController_Balance_BALANCE_OFFSET_Y_2 : integer := 1513; -- 
      constant MotionController_Balance_BALANCE_OFFSET_Y_3 : integer := 1514; -- 
      subtype MotionController_Balance_BALANCE_OFFSET_Y_RANGE is Natural range 1514 downto 1511; -- 4
      constant MotionController_Balance_BALANCE_OFFSET_Z_0 : integer := 1512; -- 
      constant MotionController_Balance_BALANCE_OFFSET_Z_1 : integer := 1513; -- 
      constant MotionController_Balance_BALANCE_OFFSET_Z_2 : integer := 1514; -- 
      constant MotionController_Balance_BALANCE_OFFSET_Z_3 : integer := 1515; -- 
      subtype MotionController_Balance_BALANCE_OFFSET_Z_RANGE is Natural range 1515 downto 1512; -- 4
      constant MotionController_Balance_BALANCE_DAMPING_X_0 : integer := 1513; -- 
      constant MotionController_Balance_BALANCE_DAMPING_X_1 : integer := 1514; -- 
      constant MotionController_Balance_BALANCE_DAMPING_X_2 : integer := 1515; -- 
      constant MotionController_Balance_BALANCE_DAMPING_X_3 : integer := 1516; -- 
      subtype MotionController_Balance_BALANCE_DAMPING_X_RANGE is Natural range 1516 downto 1513; -- 4
      constant MotionController_Balance_BALANCE_DAMPING_Y_0 : integer := 1514; -- 
      constant MotionController_Balance_BALANCE_DAMPING_Y_1 : integer := 1515; -- 
      constant MotionController_Balance_BALANCE_DAMPING_Y_2 : integer := 1516; -- 
      constant MotionController_Balance_BALANCE_DAMPING_Y_3 : integer := 1517; -- 
      subtype MotionController_Balance_BALANCE_DAMPING_Y_RANGE is Natural range 1517 downto 1514; -- 4
      constant MotionController_Balance_BALANCE_DAMPING_Z_0 : integer := 1515; -- 
      constant MotionController_Balance_BALANCE_DAMPING_Z_1 : integer := 1516; -- 
      constant MotionController_Balance_BALANCE_DAMPING_Z_2 : integer := 1517; -- 
      constant MotionController_Balance_BALANCE_DAMPING_Z_3 : integer := 1518; -- 
      subtype MotionController_Balance_BALANCE_DAMPING_Z_RANGE is Natural range 1518 downto 1515; -- 4
      constant MotionController_Balance_BALANCE_DISTU_GAIN_X_0 : integer := 1516; -- 
      constant MotionController_Balance_BALANCE_DISTU_GAIN_X_1 : integer := 1517; -- 
      constant MotionController_Balance_BALANCE_DISTU_GAIN_X_2 : integer := 1518; -- 
      constant MotionController_Balance_BALANCE_DISTU_GAIN_X_3 : integer := 1519; -- 
      subtype MotionController_Balance_BALANCE_DISTU_GAIN_X_RANGE is Natural range 1519 downto 1516; -- 4
      constant MotionController_Balance_BALANCE_DISTU_GAIN_Y_0 : integer := 1517; -- 
      constant MotionController_Balance_BALANCE_DISTU_GAIN_Y_1 : integer := 1518; -- 
      constant MotionController_Balance_BALANCE_DISTU_GAIN_Y_2 : integer := 1519; -- 
      constant MotionController_Balance_BALANCE_DISTU_GAIN_Y_3 : integer := 1520; -- 
      subtype MotionController_Balance_BALANCE_DISTU_GAIN_Y_RANGE is Natural range 1520 downto 1517; -- 4
      constant MotionController_Balance_BALANCE_DISTU_GAIN_Z_0 : integer := 1518; -- 
      constant MotionController_Balance_BALANCE_DISTU_GAIN_Z_1 : integer := 1519; -- 
      constant MotionController_Balance_BALANCE_DISTU_GAIN_Z_2 : integer := 1520; -- 
      constant MotionController_Balance_BALANCE_DISTU_GAIN_Z_3 : integer := 1521; -- 
      subtype MotionController_Balance_BALANCE_DISTU_GAIN_Z_RANGE is Natural range 1521 downto 1518; -- 4

      subtype MotionController_WalkControl_GAIT_RANGE is Natural range 1000 downto 1000; -- 1
      subtype MotionController_WalkControl_HANDLE_DETECTED_STATE_RANGE is Natural range 1001 downto 1001; -- 1
      subtype MotionController_WalkControl_LAST_WALKING_STATE_AS_DETECTED_RANGE is Natural range 1002 downto 1002; -- 1
      constant MotionController_WalkControl_CYCLE_TIME_0   : integer := 1011; -- 
      constant MotionController_WalkControl_CYCLE_TIME_1   : integer := 1012; -- 
      subtype MotionController_WalkControl_CYCLE_TIME_RANGE is Natural range 1012 downto 1011; -- 2
      constant MotionController_WalkControl_MAX_DISTANCE_STANCE_0 : integer := 1012; -- 
      constant MotionController_WalkControl_MAX_DISTANCE_STANCE_1 : integer := 1013; -- 
      subtype MotionController_WalkControl_MAX_DISTANCE_STANCE_RANGE is Natural range 1013 downto 1012; -- 2
      constant MotionController_WalkControl_SWING_POS_OFFSET_X_0 : integer := 1013; -- 
      constant MotionController_WalkControl_SWING_POS_OFFSET_X_1 : integer := 1014; -- 
      subtype MotionController_WalkControl_SWING_POS_OFFSET_X_RANGE is Natural range 1014 downto 1013; -- 2
      constant MotionController_WalkControl_SWING_POS_OFFSET_Y_0 : integer := 1014; -- 
      constant MotionController_WalkControl_SWING_POS_OFFSET_Y_1 : integer := 1015; -- 
      subtype MotionController_WalkControl_SWING_POS_OFFSET_Y_RANGE is Natural range 1015 downto 1014; -- 2
      constant MotionController_WalkControl_SWING_POS_OFFSET_Z_0 : integer := 1015; -- 
      constant MotionController_WalkControl_SWING_POS_OFFSET_Z_1 : integer := 1016; -- 
      subtype MotionController_WalkControl_SWING_POS_OFFSET_Z_RANGE is Natural range 1016 downto 1015; -- 2
      constant MotionController_WalkControl_DCSOP_SHIFT_X_0 : integer := 1016; -- 
      constant MotionController_WalkControl_DCSOP_SHIFT_X_1 : integer := 1017; -- 
      constant MotionController_WalkControl_DCSOP_SHIFT_X_2 : integer := 1018; -- 
      constant MotionController_WalkControl_DCSOP_SHIFT_X_3 : integer := 1019; -- 
      subtype MotionController_WalkControl_DCSOP_SHIFT_X_RANGE is Natural range 1019 downto 1016; -- 4
      constant MotionController_WalkControl_DCSOP_SHIFT_Y_0 : integer := 1017; -- 
      constant MotionController_WalkControl_DCSOP_SHIFT_Y_1 : integer := 1018; -- 
      constant MotionController_WalkControl_DCSOP_SHIFT_Y_2 : integer := 1019; -- 
      constant MotionController_WalkControl_DCSOP_SHIFT_Y_3 : integer := 1020; -- 
      subtype MotionController_WalkControl_DCSOP_SHIFT_Y_RANGE is Natural range 1020 downto 1017; -- 4
      constant MotionController_WalkControl_DCSOP_SHIFT_Z_0 : integer := 1018; -- 
      constant MotionController_WalkControl_DCSOP_SHIFT_Z_1 : integer := 1019; -- 
      constant MotionController_WalkControl_DCSOP_SHIFT_Z_2 : integer := 1020; -- 
      constant MotionController_WalkControl_DCSOP_SHIFT_Z_3 : integer := 1021; -- 
      subtype MotionController_WalkControl_DCSOP_SHIFT_Z_RANGE is Natural range 1021 downto 1018; -- 4
      constant MotionController_WalkControl_BODY_ROTATION_YAW_0 : integer := 1019; -- 
      constant MotionController_WalkControl_BODY_ROTATION_YAW_1 : integer := 1020; -- 
      constant MotionController_WalkControl_BODY_ROTATION_YAW_2 : integer := 1021; -- 
      constant MotionController_WalkControl_BODY_ROTATION_YAW_3 : integer := 1022; -- 
      subtype MotionController_WalkControl_BODY_ROTATION_YAW_RANGE is Natural range 1022 downto 1019; -- 4
      constant MotionController_WalkControl_BODY_ROTATION_PITCH_0 : integer := 1020; -- 
      constant MotionController_WalkControl_BODY_ROTATION_PITCH_1 : integer := 1021; -- 
      constant MotionController_WalkControl_BODY_ROTATION_PITCH_2 : integer := 1022; -- 
      constant MotionController_WalkControl_BODY_ROTATION_PITCH_3 : integer := 1023; -- 
      subtype MotionController_WalkControl_BODY_ROTATION_PITCH_RANGE is Natural range 1023 downto 1020; -- 4
      constant MotionController_WalkControl_BODY_ROTATION_ROLL_0 : integer := 1021; -- 
      constant MotionController_WalkControl_BODY_ROTATION_ROLL_1 : integer := 1022; -- 
      constant MotionController_WalkControl_BODY_ROTATION_ROLL_2 : integer := 1023; -- 
      constant MotionController_WalkControl_BODY_ROTATION_ROLL_3 : integer := 1024; -- 
      subtype MotionController_WalkControl_BODY_ROTATION_ROLL_RANGE is Natural range 1024 downto 1021; -- 4
      constant MotionController_WalkControl_CENTER_POS_FRONT_X_0 : integer := 1022; -- 
      constant MotionController_WalkControl_CENTER_POS_FRONT_X_1 : integer := 1023; -- 
      subtype MotionController_WalkControl_CENTER_POS_FRONT_X_RANGE is Natural range 1023 downto 1022; -- 2
      constant MotionController_WalkControl_CENTER_POS_FRONT_ABS_Y_0 : integer := 1023; -- 
      constant MotionController_WalkControl_CENTER_POS_FRONT_ABS_Y_1 : integer := 1024; -- 
      subtype MotionController_WalkControl_CENTER_POS_FRONT_ABS_Y_RANGE is Natural range 1024 downto 1023; -- 2
      constant MotionController_WalkControl_CENTER_POS_REAR_X_0 : integer := 1024; -- 
      constant MotionController_WalkControl_CENTER_POS_REAR_X_1 : integer := 1025; -- 
      subtype MotionController_WalkControl_CENTER_POS_REAR_X_RANGE is Natural range 1025 downto 1024; -- 2
      constant MotionController_WalkControl_CENTER_POS_REAR_ABS_Y_0 : integer := 1025; -- 
      constant MotionController_WalkControl_CENTER_POS_REAR_ABS_Y_1 : integer := 1026; -- 
      subtype MotionController_WalkControl_CENTER_POS_REAR_ABS_Y_RANGE is Natural range 1026 downto 1025; -- 2
      constant MotionController_WalkControl_CENTER_POS_Z_0 : integer := 1026; -- 
      constant MotionController_WalkControl_CENTER_POS_Z_1 : integer := 1027; -- 
      subtype MotionController_WalkControl_CENTER_POS_Z_RANGE is Natural range 1027 downto 1026; -- 2
      constant MotionController_WalkControl_CENTER_POS_Z_DELTA_FL_0 : integer := 1027; -- 
      constant MotionController_WalkControl_CENTER_POS_Z_DELTA_FL_1 : integer := 1028; -- 
      subtype MotionController_WalkControl_CENTER_POS_Z_DELTA_FL_RANGE is Natural range 1028 downto 1027; -- 2
      constant MotionController_WalkControl_CENTER_POS_Z_DELTA_FR_0 : integer := 1028; -- 
      constant MotionController_WalkControl_CENTER_POS_Z_DELTA_FR_1 : integer := 1029; -- 
      subtype MotionController_WalkControl_CENTER_POS_Z_DELTA_FR_RANGE is Natural range 1029 downto 1028; -- 2
      constant MotionController_WalkControl_CENTER_POS_Z_DELTA_RL_0 : integer := 1029; -- 
      constant MotionController_WalkControl_CENTER_POS_Z_DELTA_RL_1 : integer := 1030; -- 
      subtype MotionController_WalkControl_CENTER_POS_Z_DELTA_RL_RANGE is Natural range 1030 downto 1029; -- 2
      constant MotionController_WalkControl_CENTER_POS_Z_DELTA_RR_0 : integer := 1030; -- 
      constant MotionController_WalkControl_CENTER_POS_Z_DELTA_RR_1 : integer := 1031; -- 
      subtype MotionController_WalkControl_CENTER_POS_Z_DELTA_RR_RANGE is Natural range 1031 downto 1030; -- 2
      constant MotionController_WalkControl_CENTER_POS_FRONT_Z_0 : integer := 1031; -- 
      constant MotionController_WalkControl_CENTER_POS_FRONT_Z_1 : integer := 1032; -- 
      subtype MotionController_WalkControl_CENTER_POS_FRONT_Z_RANGE is Natural range 1032 downto 1031; -- 2
      constant MotionController_WalkControl_CENTER_POS_REAR_Z_0 : integer := 1032; -- 
      constant MotionController_WalkControl_CENTER_POS_REAR_Z_1 : integer := 1033; -- 
      subtype MotionController_WalkControl_CENTER_POS_REAR_Z_RANGE is Natural range 1033 downto 1032; -- 2
      constant MotionController_WalkControl_BODY_OVER_GROUND_SHIFT_Z_0 : integer := 1033; -- 
      constant MotionController_WalkControl_BODY_OVER_GROUND_SHIFT_Z_1 : integer := 1034; -- 
      constant MotionController_WalkControl_BODY_OVER_GROUND_SHIFT_Z_2 : integer := 1035; -- 
      constant MotionController_WalkControl_BODY_OVER_GROUND_SHIFT_Z_3 : integer := 1036; -- 
      subtype MotionController_WalkControl_BODY_OVER_GROUND_SHIFT_Z_RANGE is Natural range 1036 downto 1033; -- 4
      constant MotionController_WalkControl_SPINE_OFFSET_ROT_YAW_0 : integer := 1035; -- 
      constant MotionController_WalkControl_SPINE_OFFSET_ROT_YAW_1 : integer := 1036; -- 
      constant MotionController_WalkControl_SPINE_OFFSET_ROT_YAW_2 : integer := 1037; -- 
      constant MotionController_WalkControl_SPINE_OFFSET_ROT_YAW_3 : integer := 1038; -- 
      subtype MotionController_WalkControl_SPINE_OFFSET_ROT_YAW_RANGE is Natural range 1038 downto 1035; -- 4
      constant MotionController_WalkControl_SPINE_OFFSET_ROT_PITCH_0 : integer := 1036; -- 
      constant MotionController_WalkControl_SPINE_OFFSET_ROT_PITCH_1 : integer := 1037; -- 
      constant MotionController_WalkControl_SPINE_OFFSET_ROT_PITCH_2 : integer := 1038; -- 
      constant MotionController_WalkControl_SPINE_OFFSET_ROT_PITCH_3 : integer := 1039; -- 
      subtype MotionController_WalkControl_SPINE_OFFSET_ROT_PITCH_RANGE is Natural range 1039 downto 1036; -- 4
      constant MotionController_WalkControl_SPINE_OFFSET_ROT_ROLL_0 : integer := 1037; -- 
      constant MotionController_WalkControl_SPINE_OFFSET_ROT_ROLL_1 : integer := 1038; -- 
      constant MotionController_WalkControl_SPINE_OFFSET_ROT_ROLL_2 : integer := 1039; -- 
      constant MotionController_WalkControl_SPINE_OFFSET_ROT_ROLL_3 : integer := 1040; -- 
      subtype MotionController_WalkControl_SPINE_OFFSET_ROT_ROLL_RANGE is Natural range 1040 downto 1037; -- 4
      constant MotionController_WalkControl_REAR_PITCH_TOUCHDOWN_0 : integer := 1041; -- 
      constant MotionController_WalkControl_REAR_PITCH_TOUCHDOWN_1 : integer := 1042; -- 
      constant MotionController_WalkControl_REAR_PITCH_TOUCHDOWN_2 : integer := 1043; -- 
      constant MotionController_WalkControl_REAR_PITCH_TOUCHDOWN_3 : integer := 1044; -- 
      subtype MotionController_WalkControl_REAR_PITCH_TOUCHDOWN_RANGE is Natural range 1044 downto 1041; -- 4
      constant MotionController_WalkControl_REAR_PITCH_TOEOFF_0 : integer := 1042; -- 
      constant MotionController_WalkControl_REAR_PITCH_TOEOFF_1 : integer := 1043; -- 
      constant MotionController_WalkControl_REAR_PITCH_TOEOFF_2 : integer := 1044; -- 
      constant MotionController_WalkControl_REAR_PITCH_TOEOFF_3 : integer := 1045; -- 
      subtype MotionController_WalkControl_REAR_PITCH_TOEOFF_RANGE is Natural range 1045 downto 1042; -- 4
      constant MotionController_WalkControl_REAR_PITCH_MIDSWING_0 : integer := 1043; -- 
      constant MotionController_WalkControl_REAR_PITCH_MIDSWING_1 : integer := 1044; -- 
      constant MotionController_WalkControl_REAR_PITCH_MIDSWING_2 : integer := 1045; -- 
      constant MotionController_WalkControl_REAR_PITCH_MIDSWING_3 : integer := 1046; -- 
      subtype MotionController_WalkControl_REAR_PITCH_MIDSWING_RANGE is Natural range 1046 downto 1043; -- 4
      constant MotionController_WalkControl_FRONT_YAW_0    : integer := 1044; -- 
      constant MotionController_WalkControl_FRONT_YAW_1    : integer := 1045; -- 
      constant MotionController_WalkControl_FRONT_YAW_2    : integer := 1046; -- 
      constant MotionController_WalkControl_FRONT_YAW_3    : integer := 1047; -- 
      subtype MotionController_WalkControl_FRONT_YAW_RANGE is Natural range 1047 downto 1044; -- 4
      subtype MotionController_WalkControl_JOINT_ANGLES_REQUEST_FILTER_RANGE is Natural range 1045 downto 1045; -- 1
      subtype MotionController_WalkControl_JOINT_ANGLES_REQUEST_FILTER_SLOWER_RANGE is Natural range 1046 downto 1046; -- 1
      subtype MotionController_WalkControl_JOINT_ANGLES_REQUEST_FILTER_FASTER_RANGE is Natural range 1047 downto 1047; -- 1
      subtype MotionController_WalkControl_USE_ANKLE_JOINT_OFFSETS_RANGE is Natural range 1048 downto 1048; -- 1
      constant MotionController_WalkControl_SPINE_OFFSET_TRANS_X_0 : integer := 1049; -- 
      constant MotionController_WalkControl_SPINE_OFFSET_TRANS_X_1 : integer := 1050; -- 
      constant MotionController_WalkControl_SPINE_OFFSET_TRANS_X_2 : integer := 1051; -- 
      constant MotionController_WalkControl_SPINE_OFFSET_TRANS_X_3 : integer := 1052; -- 
      subtype MotionController_WalkControl_SPINE_OFFSET_TRANS_X_RANGE is Natural range 1052 downto 1049; -- 4
      constant MotionController_WalkControl_SPINE_OFFSET_TRANS_Y_0 : integer := 1050; -- 
      constant MotionController_WalkControl_SPINE_OFFSET_TRANS_Y_1 : integer := 1051; -- 
      constant MotionController_WalkControl_SPINE_OFFSET_TRANS_Y_2 : integer := 1052; -- 
      constant MotionController_WalkControl_SPINE_OFFSET_TRANS_Y_3 : integer := 1053; -- 
      subtype MotionController_WalkControl_SPINE_OFFSET_TRANS_Y_RANGE is Natural range 1053 downto 1050; -- 4
      constant MotionController_WalkControl_SPINE_OFFSET_TRANS_Z_0 : integer := 1051; -- 
      constant MotionController_WalkControl_SPINE_OFFSET_TRANS_Z_1 : integer := 1052; -- 
      constant MotionController_WalkControl_SPINE_OFFSET_TRANS_Z_2 : integer := 1053; -- 
      constant MotionController_WalkControl_SPINE_OFFSET_TRANS_Z_3 : integer := 1054; -- 
      subtype MotionController_WalkControl_SPINE_OFFSET_TRANS_Z_RANGE is Natural range 1054 downto 1051; -- 4
      constant MotionController_WalkControl_GAIT_TIMED_SWINGUP_PROGRESS_FL_0 : integer := 1052; -- 
      constant MotionController_WalkControl_GAIT_TIMED_SWINGUP_PROGRESS_FL_1 : integer := 1053; -- 
      constant MotionController_WalkControl_GAIT_TIMED_SWINGUP_PROGRESS_FL_2 : integer := 1054; -- 
      constant MotionController_WalkControl_GAIT_TIMED_SWINGUP_PROGRESS_FL_3 : integer := 1055; -- 
      subtype MotionController_WalkControl_GAIT_TIMED_SWINGUP_PROGRESS_FL_RANGE is Natural range 1055 downto 1052; -- 4
      constant MotionController_WalkControl_GAIT_TIMED_SWINGUP_PROGRESS_FR_0 : integer := 1053; -- 
      constant MotionController_WalkControl_GAIT_TIMED_SWINGUP_PROGRESS_FR_1 : integer := 1054; -- 
      constant MotionController_WalkControl_GAIT_TIMED_SWINGUP_PROGRESS_FR_2 : integer := 1055; -- 
      constant MotionController_WalkControl_GAIT_TIMED_SWINGUP_PROGRESS_FR_3 : integer := 1056; -- 
      subtype MotionController_WalkControl_GAIT_TIMED_SWINGUP_PROGRESS_FR_RANGE is Natural range 1056 downto 1053; -- 4
      constant MotionController_WalkControl_GAIT_TIMED_SWINGUP_PROGRESS_RL_0 : integer := 1054; -- 
      constant MotionController_WalkControl_GAIT_TIMED_SWINGUP_PROGRESS_RL_1 : integer := 1055; -- 
      constant MotionController_WalkControl_GAIT_TIMED_SWINGUP_PROGRESS_RL_2 : integer := 1056; -- 
      constant MotionController_WalkControl_GAIT_TIMED_SWINGUP_PROGRESS_RL_3 : integer := 1057; -- 
      subtype MotionController_WalkControl_GAIT_TIMED_SWINGUP_PROGRESS_RL_RANGE is Natural range 1057 downto 1054; -- 4
      constant MotionController_WalkControl_GAIT_TIMED_SWINGUP_PROGRESS_RR_0 : integer := 1055; -- 
      constant MotionController_WalkControl_GAIT_TIMED_SWINGUP_PROGRESS_RR_1 : integer := 1056; -- 
      constant MotionController_WalkControl_GAIT_TIMED_SWINGUP_PROGRESS_RR_2 : integer := 1057; -- 
      constant MotionController_WalkControl_GAIT_TIMED_SWINGUP_PROGRESS_RR_3 : integer := 1058; -- 
      subtype MotionController_WalkControl_GAIT_TIMED_SWINGUP_PROGRESS_RR_RANGE is Natural range 1058 downto 1055; -- 4
      constant MotionController_WalkControl_GAIT_TIMED_SWING_FRACTION_0 : integer := 1056; -- 
      constant MotionController_WalkControl_GAIT_TIMED_SWING_FRACTION_1 : integer := 1057; -- 
      constant MotionController_WalkControl_GAIT_TIMED_SWING_FRACTION_2 : integer := 1058; -- 
      constant MotionController_WalkControl_GAIT_TIMED_SWING_FRACTION_3 : integer := 1059; -- 
      subtype MotionController_WalkControl_GAIT_TIMED_SWING_FRACTION_RANGE is Natural range 1059 downto 1056; -- 4
      constant MotionController_WalkControl_FLOOR_ESTIMATOR_FIXED_FLOOR_OFFSET_Z_0 : integer := 1064; -- 
      constant MotionController_WalkControl_FLOOR_ESTIMATOR_FIXED_FLOOR_OFFSET_Z_1 : integer := 1065; -- 
      constant MotionController_WalkControl_FLOOR_ESTIMATOR_FIXED_FLOOR_OFFSET_Z_2 : integer := 1066; -- 
      constant MotionController_WalkControl_FLOOR_ESTIMATOR_FIXED_FLOOR_OFFSET_Z_3 : integer := 1067; -- 
      subtype MotionController_WalkControl_FLOOR_ESTIMATOR_FIXED_FLOOR_OFFSET_Z_RANGE is Natural range 1067 downto 1064; -- 4
      subtype MotionController_WalkControl_FLOOR_ESTIMATOR_ENABLE_DEBUG_PLOTS_RANGE is Natural range 1065 downto 1065; -- 1
      constant MotionController_WalkControl_FLOOR_ESTIMATOR_HYPER_PLANE_ESTIMATION_0 : integer := 1066; -- 
      constant MotionController_WalkControl_FLOOR_ESTIMATOR_HYPER_PLANE_ESTIMATION_1 : integer := 1067; -- 
      constant MotionController_WalkControl_FLOOR_ESTIMATOR_HYPER_PLANE_ESTIMATION_2 : integer := 1068; -- 
      constant MotionController_WalkControl_FLOOR_ESTIMATOR_HYPER_PLANE_ESTIMATION_3 : integer := 1069; -- 
      subtype MotionController_WalkControl_FLOOR_ESTIMATOR_HYPER_PLANE_ESTIMATION_RANGE is Natural range 1069 downto 1066; -- 4
      subtype MotionController_WalkControl_FLOOR_ESTIMATOR_FILTER_LENGTH_RANGE is Natural range 1067 downto 1067; -- 1
      constant MotionController_WalkControl_FL_OFFSET_X_0  : integer := 1070; -- 
      constant MotionController_WalkControl_FL_OFFSET_X_1  : integer := 1071; -- 
      constant MotionController_WalkControl_FL_OFFSET_X_2  : integer := 1072; -- 
      constant MotionController_WalkControl_FL_OFFSET_X_3  : integer := 1073; -- 
      subtype MotionController_WalkControl_FL_OFFSET_X_RANGE is Natural range 1073 downto 1070; -- 4
      constant MotionController_WalkControl_FL_OFFSET_Y_0  : integer := 1071; -- 
      constant MotionController_WalkControl_FL_OFFSET_Y_1  : integer := 1072; -- 
      constant MotionController_WalkControl_FL_OFFSET_Y_2  : integer := 1073; -- 
      constant MotionController_WalkControl_FL_OFFSET_Y_3  : integer := 1074; -- 
      subtype MotionController_WalkControl_FL_OFFSET_Y_RANGE is Natural range 1074 downto 1071; -- 4
      constant MotionController_WalkControl_FL_OFFSET_Z_0  : integer := 1072; -- 
      constant MotionController_WalkControl_FL_OFFSET_Z_1  : integer := 1073; -- 
      constant MotionController_WalkControl_FL_OFFSET_Z_2  : integer := 1074; -- 
      constant MotionController_WalkControl_FL_OFFSET_Z_3  : integer := 1075; -- 
      subtype MotionController_WalkControl_FL_OFFSET_Z_RANGE is Natural range 1075 downto 1072; -- 4
      constant MotionController_WalkControl_FR_OFFSET_X_0  : integer := 1073; -- 
      constant MotionController_WalkControl_FR_OFFSET_X_1  : integer := 1074; -- 
      constant MotionController_WalkControl_FR_OFFSET_X_2  : integer := 1075; -- 
      constant MotionController_WalkControl_FR_OFFSET_X_3  : integer := 1076; -- 
      subtype MotionController_WalkControl_FR_OFFSET_X_RANGE is Natural range 1076 downto 1073; -- 4
      constant MotionController_WalkControl_FR_OFFSET_Y_0  : integer := 1074; -- 
      constant MotionController_WalkControl_FR_OFFSET_Y_1  : integer := 1075; -- 
      constant MotionController_WalkControl_FR_OFFSET_Y_2  : integer := 1076; -- 
      constant MotionController_WalkControl_FR_OFFSET_Y_3  : integer := 1077; -- 
      subtype MotionController_WalkControl_FR_OFFSET_Y_RANGE is Natural range 1077 downto 1074; -- 4
      constant MotionController_WalkControl_FR_OFFSET_Z_0  : integer := 1075; -- 
      constant MotionController_WalkControl_FR_OFFSET_Z_1  : integer := 1076; -- 
      constant MotionController_WalkControl_FR_OFFSET_Z_2  : integer := 1077; -- 
      constant MotionController_WalkControl_FR_OFFSET_Z_3  : integer := 1078; -- 
      subtype MotionController_WalkControl_FR_OFFSET_Z_RANGE is Natural range 1078 downto 1075; -- 4
      constant MotionController_WalkControl_RL_OFFSET_X_0  : integer := 1076; -- 
      constant MotionController_WalkControl_RL_OFFSET_X_1  : integer := 1077; -- 
      constant MotionController_WalkControl_RL_OFFSET_X_2  : integer := 1078; -- 
      constant MotionController_WalkControl_RL_OFFSET_X_3  : integer := 1079; -- 
      subtype MotionController_WalkControl_RL_OFFSET_X_RANGE is Natural range 1079 downto 1076; -- 4
      constant MotionController_WalkControl_RL_OFFSET_Y_0  : integer := 1077; -- 
      constant MotionController_WalkControl_RL_OFFSET_Y_1  : integer := 1078; -- 
      constant MotionController_WalkControl_RL_OFFSET_Y_2  : integer := 1079; -- 
      constant MotionController_WalkControl_RL_OFFSET_Y_3  : integer := 1080; -- 
      subtype MotionController_WalkControl_RL_OFFSET_Y_RANGE is Natural range 1080 downto 1077; -- 4
      constant MotionController_WalkControl_RL_OFFSET_Z_0  : integer := 1078; -- 
      constant MotionController_WalkControl_RL_OFFSET_Z_1  : integer := 1079; -- 
      constant MotionController_WalkControl_RL_OFFSET_Z_2  : integer := 1080; -- 
      constant MotionController_WalkControl_RL_OFFSET_Z_3  : integer := 1081; -- 
      subtype MotionController_WalkControl_RL_OFFSET_Z_RANGE is Natural range 1081 downto 1078; -- 4
      constant MotionController_WalkControl_RR_OFFSET_X_0  : integer := 1079; -- 
      constant MotionController_WalkControl_RR_OFFSET_X_1  : integer := 1080; -- 
      constant MotionController_WalkControl_RR_OFFSET_X_2  : integer := 1081; -- 
      constant MotionController_WalkControl_RR_OFFSET_X_3  : integer := 1082; -- 
      subtype MotionController_WalkControl_RR_OFFSET_X_RANGE is Natural range 1082 downto 1079; -- 4
      constant MotionController_WalkControl_RR_OFFSET_Y_0  : integer := 1080; -- 
      constant MotionController_WalkControl_RR_OFFSET_Y_1  : integer := 1081; -- 
      constant MotionController_WalkControl_RR_OFFSET_Y_2  : integer := 1082; -- 
      constant MotionController_WalkControl_RR_OFFSET_Y_3  : integer := 1083; -- 
      subtype MotionController_WalkControl_RR_OFFSET_Y_RANGE is Natural range 1083 downto 1080; -- 4
      constant MotionController_WalkControl_RR_OFFSET_Z_0  : integer := 1081; -- 
      constant MotionController_WalkControl_RR_OFFSET_Z_1  : integer := 1082; -- 
      constant MotionController_WalkControl_RR_OFFSET_Z_2  : integer := 1083; -- 
      constant MotionController_WalkControl_RR_OFFSET_Z_3  : integer := 1084; -- 
      subtype MotionController_WalkControl_RR_OFFSET_Z_RANGE is Natural range 1084 downto 1081; -- 4
      constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_X_0 : integer := 1100; -- 
      constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_X_1 : integer := 1101; -- 
      constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_X_2 : integer := 1102; -- 
      constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_X_3 : integer := 1103; -- 
      subtype MotionController_WalkControl_SPINE_SUPPORT_SCALE_X_RANGE is Natural range 1103 downto 1100; -- 4
      constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_Y_0 : integer := 1101; -- 
      constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_Y_1 : integer := 1102; -- 
      constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_Y_2 : integer := 1103; -- 
      constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_Y_3 : integer := 1104; -- 
      subtype MotionController_WalkControl_SPINE_SUPPORT_SCALE_Y_RANGE is Natural range 1104 downto 1101; -- 4
      constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_Z_0 : integer := 1102; -- 
      constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_Z_1 : integer := 1103; -- 
      constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_Z_2 : integer := 1104; -- 
      constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_Z_3 : integer := 1105; -- 
      subtype MotionController_WalkControl_SPINE_SUPPORT_SCALE_Z_RANGE is Natural range 1105 downto 1102; -- 4
      constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_YAW_0 : integer := 1103; -- 
      constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_YAW_1 : integer := 1104; -- 
      constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_YAW_2 : integer := 1105; -- 
      constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_YAW_3 : integer := 1106; -- 
      subtype MotionController_WalkControl_SPINE_SUPPORT_SCALE_YAW_RANGE is Natural range 1106 downto 1103; -- 4
      constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_PITCH_0 : integer := 1104; -- 
      constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_PITCH_1 : integer := 1105; -- 
      constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_PITCH_2 : integer := 1106; -- 
      constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_PITCH_3 : integer := 1107; -- 
      subtype MotionController_WalkControl_SPINE_SUPPORT_SCALE_PITCH_RANGE is Natural range 1107 downto 1104; -- 4
      constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_ROLL_0 : integer := 1105; -- 
      constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_ROLL_1 : integer := 1106; -- 
      constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_ROLL_2 : integer := 1107; -- 
      constant MotionController_WalkControl_SPINE_SUPPORT_SCALE_ROLL_3 : integer := 1108; -- 
      subtype MotionController_WalkControl_SPINE_SUPPORT_SCALE_ROLL_RANGE is Natural range 1108 downto 1105; -- 4
      constant MotionController_WalkControl_SPINE_SUPPORT_HIPSHOULDER_WEIGHT_0 : integer := 1112; -- 
      constant MotionController_WalkControl_SPINE_SUPPORT_HIPSHOULDER_WEIGHT_1 : integer := 1113; -- 
      constant MotionController_WalkControl_SPINE_SUPPORT_HIPSHOULDER_WEIGHT_2 : integer := 1114; -- 
      constant MotionController_WalkControl_SPINE_SUPPORT_HIPSHOULDER_WEIGHT_3 : integer := 1115; -- 
      subtype MotionController_WalkControl_SPINE_SUPPORT_HIPSHOULDER_WEIGHT_RANGE is Natural range 1115 downto 1112; -- 4

      subtype MotionController_WalkTwoLeggedControl_HANDLE_DETECTED_STATE_RANGE is Natural range 2001 downto 2001; -- 1
      constant MotionController_WalkTwoLeggedControl_CYCLE_TIME_0 : integer := 2011; -- 
      constant MotionController_WalkTwoLeggedControl_CYCLE_TIME_1 : integer := 2012; -- 
      subtype MotionController_WalkTwoLeggedControl_CYCLE_TIME_RANGE is Natural range 2012 downto 2011; -- 2
      constant MotionController_WalkTwoLeggedControl_MAX_DISTANCE_STANCE_0 : integer := 2012; -- 
      constant MotionController_WalkTwoLeggedControl_MAX_DISTANCE_STANCE_1 : integer := 2013; -- 
      subtype MotionController_WalkTwoLeggedControl_MAX_DISTANCE_STANCE_RANGE is Natural range 2013 downto 2012; -- 2
      constant MotionController_WalkTwoLeggedControl_SWING_POS_OFFSET_FRONT_X_0 : integer := 2013; -- 
      constant MotionController_WalkTwoLeggedControl_SWING_POS_OFFSET_FRONT_X_1 : integer := 2014; -- 
      subtype MotionController_WalkTwoLeggedControl_SWING_POS_OFFSET_FRONT_X_RANGE is Natural range 2014 downto 2013; -- 2
      constant MotionController_WalkTwoLeggedControl_SWING_POS_OFFSET_FRONT_Y_0 : integer := 2014; -- 
      constant MotionController_WalkTwoLeggedControl_SWING_POS_OFFSET_FRONT_Y_1 : integer := 2015; -- 
      subtype MotionController_WalkTwoLeggedControl_SWING_POS_OFFSET_FRONT_Y_RANGE is Natural range 2015 downto 2014; -- 2
      constant MotionController_WalkTwoLeggedControl_SWING_POS_OFFSET_FRONT_Z_0 : integer := 2015; -- 
      constant MotionController_WalkTwoLeggedControl_SWING_POS_OFFSET_FRONT_Z_1 : integer := 2016; -- 
      subtype MotionController_WalkTwoLeggedControl_SWING_POS_OFFSET_FRONT_Z_RANGE is Natural range 2016 downto 2015; -- 2
      constant MotionController_WalkTwoLeggedControl_SWING_POS_OFFSET_REAR_X_0 : integer := 2016; -- 
      constant MotionController_WalkTwoLeggedControl_SWING_POS_OFFSET_REAR_X_1 : integer := 2017; -- 
      subtype MotionController_WalkTwoLeggedControl_SWING_POS_OFFSET_REAR_X_RANGE is Natural range 2017 downto 2016; -- 2
      constant MotionController_WalkTwoLeggedControl_SWING_POS_OFFSET_REAR_Y_0 : integer := 2017; -- 
      constant MotionController_WalkTwoLeggedControl_SWING_POS_OFFSET_REAR_Y_1 : integer := 2018; -- 
      subtype MotionController_WalkTwoLeggedControl_SWING_POS_OFFSET_REAR_Y_RANGE is Natural range 2018 downto 2017; -- 2
      constant MotionController_WalkTwoLeggedControl_SWING_POS_OFFSET_REAR_Z_0 : integer := 2018; -- 
      constant MotionController_WalkTwoLeggedControl_SWING_POS_OFFSET_REAR_Z_1 : integer := 2019; -- 
      subtype MotionController_WalkTwoLeggedControl_SWING_POS_OFFSET_REAR_Z_RANGE is Natural range 2019 downto 2018; -- 2
      constant MotionController_WalkTwoLeggedControl_CENTER_POS_FRONT_X_0 : integer := 2022; -- 
      constant MotionController_WalkTwoLeggedControl_CENTER_POS_FRONT_X_1 : integer := 2023; -- 
      subtype MotionController_WalkTwoLeggedControl_CENTER_POS_FRONT_X_RANGE is Natural range 2023 downto 2022; -- 2
      constant MotionController_WalkTwoLeggedControl_CENTER_POS_FRONT_ABS_Y_0 : integer := 2023; -- 
      constant MotionController_WalkTwoLeggedControl_CENTER_POS_FRONT_ABS_Y_1 : integer := 2024; -- 
      subtype MotionController_WalkTwoLeggedControl_CENTER_POS_FRONT_ABS_Y_RANGE is Natural range 2024 downto 2023; -- 2
      constant MotionController_WalkTwoLeggedControl_CENTER_POS_FRONT_Z_0 : integer := 2024; -- 
      constant MotionController_WalkTwoLeggedControl_CENTER_POS_FRONT_Z_1 : integer := 2025; -- 
      subtype MotionController_WalkTwoLeggedControl_CENTER_POS_FRONT_Z_RANGE is Natural range 2025 downto 2024; -- 2
      constant MotionController_WalkTwoLeggedControl_CENTER_POS_REAR_X_0 : integer := 2025; -- 
      constant MotionController_WalkTwoLeggedControl_CENTER_POS_REAR_X_1 : integer := 2026; -- 
      subtype MotionController_WalkTwoLeggedControl_CENTER_POS_REAR_X_RANGE is Natural range 2026 downto 2025; -- 2
      constant MotionController_WalkTwoLeggedControl_CENTER_POS_REAR_ABS_Y_0 : integer := 2026; -- 
      constant MotionController_WalkTwoLeggedControl_CENTER_POS_REAR_ABS_Y_1 : integer := 2027; -- 
      subtype MotionController_WalkTwoLeggedControl_CENTER_POS_REAR_ABS_Y_RANGE is Natural range 2027 downto 2026; -- 2
      constant MotionController_WalkTwoLeggedControl_CENTER_POS_REAR_Z_0 : integer := 2027; -- 
      constant MotionController_WalkTwoLeggedControl_CENTER_POS_REAR_Z_1 : integer := 2028; -- 
      subtype MotionController_WalkTwoLeggedControl_CENTER_POS_REAR_Z_RANGE is Natural range 2028 downto 2027; -- 2
      constant MotionController_WalkTwoLeggedControl_CENTER_POS_Z_DELTA_FL_0 : integer := 2028; -- 
      constant MotionController_WalkTwoLeggedControl_CENTER_POS_Z_DELTA_FL_1 : integer := 2029; -- 
      subtype MotionController_WalkTwoLeggedControl_CENTER_POS_Z_DELTA_FL_RANGE is Natural range 2029 downto 2028; -- 2
      constant MotionController_WalkTwoLeggedControl_CENTER_POS_Z_DELTA_FR_0 : integer := 2029; -- 
      constant MotionController_WalkTwoLeggedControl_CENTER_POS_Z_DELTA_FR_1 : integer := 2030; -- 
      subtype MotionController_WalkTwoLeggedControl_CENTER_POS_Z_DELTA_FR_RANGE is Natural range 2030 downto 2029; -- 2
      constant MotionController_WalkTwoLeggedControl_CENTER_POS_Z_DELTA_RL_0 : integer := 2030; -- 
      constant MotionController_WalkTwoLeggedControl_CENTER_POS_Z_DELTA_RL_1 : integer := 2031; -- 
      subtype MotionController_WalkTwoLeggedControl_CENTER_POS_Z_DELTA_RL_RANGE is Natural range 2031 downto 2030; -- 2
      constant MotionController_WalkTwoLeggedControl_CENTER_POS_Z_DELTA_RR_0 : integer := 2031; -- 
      constant MotionController_WalkTwoLeggedControl_CENTER_POS_Z_DELTA_RR_1 : integer := 2032; -- 
      subtype MotionController_WalkTwoLeggedControl_CENTER_POS_Z_DELTA_RR_RANGE is Natural range 2032 downto 2031; -- 2
      subtype MotionController_WalkTwoLeggedControl_FIXED_FRONT_LEGS_RANGE is Natural range 2032 downto 2032; -- 1
      constant MotionController_WalkTwoLeggedControl_TWO_LEGGED_DESIRED_ZMP_OFFSET_IN_X_0 : integer := 2050; -- 
      constant MotionController_WalkTwoLeggedControl_TWO_LEGGED_DESIRED_ZMP_OFFSET_IN_X_1 : integer := 2051; -- 
      constant MotionController_WalkTwoLeggedControl_TWO_LEGGED_DESIRED_ZMP_OFFSET_IN_X_2 : integer := 2052; -- 
      constant MotionController_WalkTwoLeggedControl_TWO_LEGGED_DESIRED_ZMP_OFFSET_IN_X_3 : integer := 2053; -- 
      subtype MotionController_WalkTwoLeggedControl_TWO_LEGGED_DESIRED_ZMP_OFFSET_IN_X_RANGE is Natural range 2053 downto 2050; -- 4
      constant MotionController_WalkTwoLeggedControl_TWO_LEGGED_DESIRED_ZMP_OFFSET_IN_Y_0 : integer := 2051; -- 
      constant MotionController_WalkTwoLeggedControl_TWO_LEGGED_DESIRED_ZMP_OFFSET_IN_Y_1 : integer := 2052; -- 
      constant MotionController_WalkTwoLeggedControl_TWO_LEGGED_DESIRED_ZMP_OFFSET_IN_Y_2 : integer := 2053; -- 
      constant MotionController_WalkTwoLeggedControl_TWO_LEGGED_DESIRED_ZMP_OFFSET_IN_Y_3 : integer := 2054; -- 
      subtype MotionController_WalkTwoLeggedControl_TWO_LEGGED_DESIRED_ZMP_OFFSET_IN_Y_RANGE is Natural range 2054 downto 2051; -- 4
      constant MotionController_WalkTwoLeggedControl_TWO_LEGGED_DESIRED_ZMP_OFFSET_IN_Z_0 : integer := 2052; -- 
      constant MotionController_WalkTwoLeggedControl_TWO_LEGGED_DESIRED_ZMP_OFFSET_IN_Z_1 : integer := 2053; -- 
      constant MotionController_WalkTwoLeggedControl_TWO_LEGGED_DESIRED_ZMP_OFFSET_IN_Z_2 : integer := 2054; -- 
      constant MotionController_WalkTwoLeggedControl_TWO_LEGGED_DESIRED_ZMP_OFFSET_IN_Z_3 : integer := 2055; -- 
      subtype MotionController_WalkTwoLeggedControl_TWO_LEGGED_DESIRED_ZMP_OFFSET_IN_Z_RANGE is Natural range 2055 downto 2052; -- 4

      subtype MotionController_SendToPc_SEND_ROBOT_STATUS_RANGE is Natural range 20 downto 20; -- 1
      subtype MotionController_SendToPc_SEND_REQUESTED_JOINT_POSE_RANGE is Natural range 21 downto 21; -- 1
      subtype MotionController_SendToPc_SEND_MEASURED_JOINT_POSE_RANGE is Natural range 22 downto 22; -- 1
      subtype MotionController_SendToPc_SEND_DESIRED_MOTOR_POSITIONS_RANGE is Natural range 23 downto 23; -- 1
      subtype MotionController_SendToPc_SEND_MEASURED_MOTOR_POSITIONS_RANGE is Natural range 24 downto 24; -- 1
      subtype MotionController_SendToPc_SEND_REQUESTED_SPEED_RANGE is Natural range 25 downto 25; -- 1
      subtype MotionController_SendToPc_SEND_MEASURED_SPEED_RANGE is Natural range 26 downto 26; -- 1
      subtype MotionController_SendToPc_SEND_MEASURED_ICHAUS_POSITION_RANGE is Natural range 27 downto 27; -- 1
      subtype MotionController_SendToPc_SEND_CURRENT_RANGE is Natural range 28 downto 28; -- 1
      subtype MotionController_SendToPc_SEND_PWM_RANGE is Natural range 29 downto 29; -- 1
      subtype MotionController_SendToPc_SEND_TEMPERATURE_RANGE is Natural range 30 downto 30; -- 1
      subtype MotionController_SendToPc_SEND_BLDCJOINT_TELEMETRY_ID_RANGE is Natural range 31 downto 31; -- 1
      subtype MotionController_SendToPc_SEND_ANKLEJOINT_TELEMETRY_ID_RANGE is Natural range 32 downto 32; -- 1
      subtype MotionController_SendToPc_SEND_SPINE_TELEMETRY_RANGE is Natural range 33 downto 33; -- 1
      subtype MotionController_SendToPc_SEND_HEAD_TELEMETRY_RANGE is Natural range 34 downto 34; -- 1
      subtype MotionController_SendToPc_SEND_FT_SENSOR_VALUES_RANGE is Natural range 35 downto 35; -- 1
      subtype MotionController_SendToPc_SEND_WALKING_STATE_RANGE is Natural range 36 downto 36; -- 1
      subtype MotionController_SendToPc_SEND_IMUS_RANGE is Natural range 37 downto 37; -- 1
      subtype MotionController_SendToPc_SEND_FILTERED_WALKING_SPEED_RANGE is Natural range 39 downto 39; -- 1
      subtype MotionController_SendToPc_SEND_GLOBAL_SUPPORT_POLYGON_RANGE is Natural range 40 downto 40; -- 1

      subtype PicoBlazeArray_INPUT_RANGE is Natural range 1 downto 1; -- 1
      subtype PicoBlazeArray_OUTPUT_RANGE is Natural range 2 downto 2; -- 1

      subtype mdaq2_BACKUP_RANGE is Natural range 1 downto 1; -- 1
      subtype mdaq2_DC_EN_RANGE is Natural range 2 downto 2; -- 1
      constant mdaq2_VOUT_5V_0                             : integer := 3; -- 
      constant mdaq2_VOUT_5V_1                             : integer := 4; -- 
      subtype mdaq2_VOUT_5V_RANGE is Natural range 4 downto 3; -- 2
      constant mdaq2_VOUT_DAC_0                            : integer := 4; -- 
      constant mdaq2_VOUT_DAC_1                            : integer := 5; -- 
      subtype mdaq2_VOUT_DAC_RANGE is Natural range 5 downto 4; -- 2
      constant mdaq2_DEF_FREQ_0                            : integer := 5; -- 
      constant mdaq2_DEF_FREQ_1                            : integer := 6; -- 
      subtype mdaq2_DEF_FREQ_RANGE is Natural range 6 downto 5; -- 2
      constant mdaq2_TERM_RESISTANCE_0                     : integer := 6; -- 
      constant mdaq2_TERM_RESISTANCE_1                     : integer := 7; -- 
      constant mdaq2_TERM_RESISTANCE_2                     : integer := 8; -- 
      constant mdaq2_TERM_RESISTANCE_3                     : integer := 9; -- 
      subtype mdaq2_TERM_RESISTANCE_RANGE is Natural range 9 downto 6; -- 4
      constant mdaq2_RTC_DRIFT_0                           : integer := 7; -- 
      constant mdaq2_RTC_DRIFT_1                           : integer := 8; -- 
      constant mdaq2_RTC_DRIFT_2                           : integer := 9; -- 
      constant mdaq2_RTC_DRIFT_3                           : integer := 10; -- 
      subtype mdaq2_RTC_DRIFT_RANGE is Natural range 10 downto 7; -- 4
      subtype mdaq2_FT_REMOTE_RANGE is Natural range 8 downto 8; -- 1
      constant mdaq2_FT_FREQ_0                             : integer := 9; -- 
      constant mdaq2_FT_FREQ_1                             : integer := 10; -- 
      subtype mdaq2_FT_FREQ_RANGE is Natural range 10 downto 9; -- 2
      subtype mdaq2_FT_SENSOR_RANGE is Natural range 10 downto 10; -- 1
      subtype mdaq2_FT_GAIN_RANGE is Natural range 11 downto 11; -- 1
      subtype mdaq2_FT_OFFSET_RANGE is Natural range 12 downto 12; -- 1
      subtype mdaq2_FT_FILTER_TYPE_RANGE is Natural range 13 downto 13; -- 1
      subtype mdaq2_FT_FILTER_LEN_RANGE is Natural range 14 downto 14; -- 1
      subtype mdaq2_FT_FILTER_ORDER_RANGE is Natural range 15 downto 15; -- 1
      constant mdaq2_FT_FILTER_CUTOFF_0                    : integer := 16; -- 
      constant mdaq2_FT_FILTER_CUTOFF_1                    : integer := 17; -- 
      constant mdaq2_FT_FILTER_CUTOFF_2                    : integer := 18; -- 
      constant mdaq2_FT_FILTER_CUTOFF_3                    : integer := 19; -- 
      subtype mdaq2_FT_FILTER_CUTOFF_RANGE is Natural range 19 downto 16; -- 4
      constant mdaq2_FT_FILTER_ATT_0                       : integer := 17; -- 
      constant mdaq2_FT_FILTER_ATT_1                       : integer := 18; -- 
      constant mdaq2_FT_FILTER_ATT_2                       : integer := 19; -- 
      constant mdaq2_FT_FILTER_ATT_3                       : integer := 20; -- 
      subtype mdaq2_FT_FILTER_ATT_RANGE is Natural range 20 downto 17; -- 4
      subtype mdaq2_FT_AJC_REMOTE_RANGE is Natural range 18 downto 18; -- 1
      subtype mdaq2_RESERVED_RANGE is Natural range 19 downto 19; -- 1
      constant mdaq2_FT_AJC_PITCHCONST_0                   : integer := 20; -- 
      constant mdaq2_FT_AJC_PITCHCONST_1                   : integer := 21; -- 
      constant mdaq2_FT_AJC_PITCHCONST_2                   : integer := 22; -- 
      constant mdaq2_FT_AJC_PITCHCONST_3                   : integer := 23; -- 
      subtype mdaq2_FT_AJC_PITCHCONST_RANGE is Natural range 23 downto 20; -- 4
      constant mdaq2_FT_AJC_PITCHLIMIT_0                   : integer := 21; -- 
      constant mdaq2_FT_AJC_PITCHLIMIT_1                   : integer := 22; -- 
      constant mdaq2_FT_AJC_PITCHLIMIT_2                   : integer := 23; -- 
      constant mdaq2_FT_AJC_PITCHLIMIT_3                   : integer := 24; -- 
      subtype mdaq2_FT_AJC_PITCHLIMIT_RANGE is Natural range 24 downto 21; -- 4
      constant mdaq2_FT_AJC_ROLLCONST_0                    : integer := 22; -- 
      constant mdaq2_FT_AJC_ROLLCONST_1                    : integer := 23; -- 
      constant mdaq2_FT_AJC_ROLLCONST_2                    : integer := 24; -- 
      constant mdaq2_FT_AJC_ROLLCONST_3                    : integer := 25; -- 
      subtype mdaq2_FT_AJC_ROLLCONST_RANGE is Natural range 25 downto 22; -- 4
      constant mdaq2_FT_AJC_ROLLLIMIT_0                    : integer := 23; -- 
      constant mdaq2_FT_AJC_ROLLLIMIT_1                    : integer := 24; -- 
      constant mdaq2_FT_AJC_ROLLLIMIT_2                    : integer := 25; -- 
      constant mdaq2_FT_AJC_ROLLLIMIT_3                    : integer := 26; -- 
      subtype mdaq2_FT_AJC_ROLLLIMIT_RANGE is Natural range 26 downto 23; -- 4
      constant mdaq2_FT_AJC_INERTIA_0                      : integer := 24; -- 
      constant mdaq2_FT_AJC_INERTIA_1                      : integer := 25; -- 
      constant mdaq2_FT_AJC_INERTIA_2                      : integer := 26; -- 
      constant mdaq2_FT_AJC_INERTIA_3                      : integer := 27; -- 
      subtype mdaq2_FT_AJC_INERTIA_RANGE is Natural range 27 downto 24; -- 4
      subtype mdaq2_SA_REMOTE_RANGE is Natural range 25 downto 25; -- 1
      constant mdaq2_SA_FREQ_0                             : integer := 26; -- 
      constant mdaq2_SA_FREQ_1                             : integer := 27; -- 
      subtype mdaq2_SA_FREQ_RANGE is Natural range 27 downto 26; -- 2
      subtype mdaq2_SA_STATE_RANGE is Natural range 27 downto 27; -- 1
      subtype mdaq2_SA_MODE_RANGE is Natural range 28 downto 28; -- 1
      subtype mdaq2_SA_OUTPUT_RANGE is Natural range 29 downto 29; -- 1
      constant mdaq2_SA_SCALE_0                            : integer := 30; -- 
      constant mdaq2_SA_SCALE_1                            : integer := 31; -- 
      constant mdaq2_SA_SCALE_2                            : integer := 32; -- 
      constant mdaq2_SA_SCALE_3                            : integer := 33; -- 
      subtype mdaq2_SA_SCALE_RANGE is Natural range 33 downto 30; -- 4
      subtype mdaq2_SA_OFFSET_RANGE is Natural range 31 downto 31; -- 1
      subtype mdaq2_SCOPE_REMOTE_RANGE is Natural range 32 downto 32; -- 1
      constant mdaq2_SCOPE_FREQ_0                          : integer := 33; -- 
      constant mdaq2_SCOPE_FREQ_1                          : integer := 34; -- 
      subtype mdaq2_SCOPE_FREQ_RANGE is Natural range 34 downto 33; -- 2
      subtype mdaq2_SCOPE_MODE_RANGE is Natural range 34 downto 34; -- 1
      subtype mdaq2_SCOPE_IN_POS_RANGE is Natural range 35 downto 35; -- 1
      subtype mdaq2_SCOPE_IN_NEG_RANGE is Natural range 36 downto 36; -- 1
      subtype mdaq2_SCOPE_OUT_RANGE is Natural range 37 downto 37; -- 1
      subtype mdaq2_SCOPE_GAIN_RANGE is Natural range 38 downto 38; -- 1
      subtype mdaq2_TC77_REMOTE_RANGE is Natural range 39 downto 39; -- 1
      constant mdaq2_TC77_FREQ_0                           : integer := 40; -- 
      constant mdaq2_TC77_FREQ_1                           : integer := 41; -- 
      subtype mdaq2_TC77_FREQ_RANGE is Natural range 41 downto 40; -- 2
      subtype mdaq2_LIS3_REMOTE_RANGE is Natural range 41 downto 41; -- 1
      constant mdaq2_LIS3_FREQ_0                           : integer := 42; -- 
      constant mdaq2_LIS3_FREQ_1                           : integer := 43; -- 
      subtype mdaq2_LIS3_FREQ_RANGE is Natural range 43 downto 42; -- 2
      subtype mdaq2_LIS3_SCALE_RANGE is Natural range 43 downto 43; -- 1
      subtype mdaq2_SI1120_REMOTE_RANGE is Natural range 44 downto 44; -- 1
      constant mdaq2_SI1120_FREQ_0                         : integer := 45; -- 
      constant mdaq2_SI1120_FREQ_1                         : integer := 46; -- 
      subtype mdaq2_SI1120_FREQ_RANGE is Natural range 46 downto 45; -- 2
      subtype mdaq2_SI1120_CALIBRATE_RANGE is Natural range 46 downto 46; -- 1
      subtype mdaq2_ANGLE_REMOTE_RANGE is Natural range 47 downto 47; -- 1
      constant mdaq2_ANGLE_FREQ_0                          : integer := 48; -- 
      constant mdaq2_ANGLE_FREQ_1                          : integer := 49; -- 
      subtype mdaq2_ANGLE_FREQ_RANGE is Natural range 49 downto 48; -- 2
      subtype mdaq2_ANGLE_OUTPUT_RANGE is Natural range 49 downto 49; -- 1
      subtype mdaq2_ANGLE_OFFSET_RANGE is Natural range 50 downto 50; -- 1
      subtype mdaq2_POLY_REMOTE_RANGE is Natural range 51 downto 51; -- 1
      constant mdaq2_POLY_THRESH_0                         : integer := 52; -- 
      constant mdaq2_POLY_THRESH_1                         : integer := 53; -- 
      constant mdaq2_POLY_THRESH_2                         : integer := 54; -- 
      constant mdaq2_POLY_THRESH_3                         : integer := 55; -- 
      subtype mdaq2_POLY_THRESH_RANGE is Natural range 55 downto 52; -- 4
      subtype mdaq2_PD_REMOTE_RANGE is Natural range 53 downto 53; -- 1
      constant mdaq2_PD_LOW_0                              : integer := 54; -- 
      constant mdaq2_PD_LOW_1                              : integer := 55; -- 
      constant mdaq2_PD_LOW_2                              : integer := 56; -- 
      constant mdaq2_PD_LOW_3                              : integer := 57; -- 
      subtype mdaq2_PD_LOW_RANGE is Natural range 57 downto 54; -- 4
      constant mdaq2_PD_HIGH_0                             : integer := 55; -- 
      constant mdaq2_PD_HIGH_1                             : integer := 56; -- 
      constant mdaq2_PD_HIGH_2                             : integer := 57; -- 
      constant mdaq2_PD_HIGH_3                             : integer := 58; -- 
      subtype mdaq2_PD_HIGH_RANGE is Natural range 58 downto 55; -- 4
      constant mdaq2_FT_OFFSET_0_0                         : integer := 56; -- 
      constant mdaq2_FT_OFFSET_0_1                         : integer := 57; -- 
      constant mdaq2_FT_OFFSET_0_2                         : integer := 58; -- 
      constant mdaq2_FT_OFFSET_0_3                         : integer := 59; -- 
      subtype mdaq2_FT_OFFSET_0_RANGE is Natural range 59 downto 56; -- 4
      constant mdaq2_FT_OFFSET_1_0                         : integer := 57; -- 
      constant mdaq2_FT_OFFSET_1_1                         : integer := 58; -- 
      constant mdaq2_FT_OFFSET_1_2                         : integer := 59; -- 
      constant mdaq2_FT_OFFSET_1_3                         : integer := 60; -- 
      subtype mdaq2_FT_OFFSET_1_RANGE is Natural range 60 downto 57; -- 4
      constant mdaq2_FT_OFFSET_2_0                         : integer := 58; -- 
      constant mdaq2_FT_OFFSET_2_1                         : integer := 59; -- 
      constant mdaq2_FT_OFFSET_2_2                         : integer := 60; -- 
      constant mdaq2_FT_OFFSET_2_3                         : integer := 61; -- 
      subtype mdaq2_FT_OFFSET_2_RANGE is Natural range 61 downto 58; -- 4
      constant mdaq2_FT_OFFSET_3_0                         : integer := 59; -- 
      constant mdaq2_FT_OFFSET_3_1                         : integer := 60; -- 
      constant mdaq2_FT_OFFSET_3_2                         : integer := 61; -- 
      constant mdaq2_FT_OFFSET_3_3                         : integer := 62; -- 
      subtype mdaq2_FT_OFFSET_3_RANGE is Natural range 62 downto 59; -- 4
      constant mdaq2_FT_OFFSET_4_0                         : integer := 60; -- 
      constant mdaq2_FT_OFFSET_4_1                         : integer := 61; -- 
      constant mdaq2_FT_OFFSET_4_2                         : integer := 62; -- 
      constant mdaq2_FT_OFFSET_4_3                         : integer := 63; -- 
      subtype mdaq2_FT_OFFSET_4_RANGE is Natural range 63 downto 60; -- 4
      constant mdaq2_FT_OFFSET_5_0                         : integer := 61; -- 
      constant mdaq2_FT_OFFSET_5_1                         : integer := 62; -- 
      constant mdaq2_FT_OFFSET_5_2                         : integer := 63; -- 
      constant mdaq2_FT_OFFSET_5_3                         : integer := 64; -- 
      subtype mdaq2_FT_OFFSET_5_RANGE is Natural range 64 downto 61; -- 4
      constant mdaq2_ANGLE_OFFSET_0_0                      : integer := 62; -- 
      constant mdaq2_ANGLE_OFFSET_0_1                      : integer := 63; -- 
      constant mdaq2_ANGLE_OFFSET_0_2                      : integer := 64; -- 
      constant mdaq2_ANGLE_OFFSET_0_3                      : integer := 65; -- 
      subtype mdaq2_ANGLE_OFFSET_0_RANGE is Natural range 65 downto 62; -- 4
      constant mdaq2_ANGLE_OFFSET_1_0                      : integer := 63; -- 
      constant mdaq2_ANGLE_OFFSET_1_1                      : integer := 64; -- 
      constant mdaq2_ANGLE_OFFSET_1_2                      : integer := 65; -- 
      constant mdaq2_ANGLE_OFFSET_1_3                      : integer := 66; -- 
      subtype mdaq2_ANGLE_OFFSET_1_RANGE is Natural range 66 downto 63; -- 4
      constant mdaq2_ANGLE_OFFSET_2_0                      : integer := 64; -- 
      constant mdaq2_ANGLE_OFFSET_2_1                      : integer := 65; -- 
      constant mdaq2_ANGLE_OFFSET_2_2                      : integer := 66; -- 
      constant mdaq2_ANGLE_OFFSET_2_3                      : integer := 67; -- 
      subtype mdaq2_ANGLE_OFFSET_2_RANGE is Natural range 67 downto 64; -- 4
      constant mdaq2_ANGLE_OFFSET_3_0                      : integer := 65; -- 
      constant mdaq2_ANGLE_OFFSET_3_1                      : integer := 66; -- 
      constant mdaq2_ANGLE_OFFSET_3_2                      : integer := 67; -- 
      constant mdaq2_ANGLE_OFFSET_3_3                      : integer := 68; -- 
      subtype mdaq2_ANGLE_OFFSET_3_RANGE is Natural range 68 downto 65; -- 4
      constant mdaq2_FT_ANGLE_X_0                          : integer := 66; -- 
      constant mdaq2_FT_ANGLE_X_1                          : integer := 67; -- 
      constant mdaq2_FT_ANGLE_X_2                          : integer := 68; -- 
      constant mdaq2_FT_ANGLE_X_3                          : integer := 69; -- 
      subtype mdaq2_FT_ANGLE_X_RANGE is Natural range 69 downto 66; -- 4
      constant mdaq2_FT_ANGLE_Y_0                          : integer := 67; -- 
      constant mdaq2_FT_ANGLE_Y_1                          : integer := 68; -- 
      constant mdaq2_FT_ANGLE_Y_2                          : integer := 69; -- 
      constant mdaq2_FT_ANGLE_Y_3                          : integer := 70; -- 
      subtype mdaq2_FT_ANGLE_Y_RANGE is Natural range 70 downto 67; -- 4
      constant mdaq2_FT_ANGLE_Z_0                          : integer := 68; -- 
      constant mdaq2_FT_ANGLE_Z_1                          : integer := 69; -- 
      constant mdaq2_FT_ANGLE_Z_2                          : integer := 70; -- 
      constant mdaq2_FT_ANGLE_Z_3                          : integer := 71; -- 
      subtype mdaq2_FT_ANGLE_Z_RANGE is Natural range 71 downto 68; -- 4
      constant mdaq2_LIS3_ANGLE_X_0                        : integer := 69; -- 
      constant mdaq2_LIS3_ANGLE_X_1                        : integer := 70; -- 
      constant mdaq2_LIS3_ANGLE_X_2                        : integer := 71; -- 
      constant mdaq2_LIS3_ANGLE_X_3                        : integer := 72; -- 
      subtype mdaq2_LIS3_ANGLE_X_RANGE is Natural range 72 downto 69; -- 4
      constant mdaq2_LIS3_ANGLE_Y_0                        : integer := 70; -- 
      constant mdaq2_LIS3_ANGLE_Y_1                        : integer := 71; -- 
      constant mdaq2_LIS3_ANGLE_Y_2                        : integer := 72; -- 
      constant mdaq2_LIS3_ANGLE_Y_3                        : integer := 73; -- 
      subtype mdaq2_LIS3_ANGLE_Y_RANGE is Natural range 73 downto 70; -- 4
      constant mdaq2_LIS3_ANGLE_Z_0                        : integer := 71; -- 
      constant mdaq2_LIS3_ANGLE_Z_1                        : integer := 72; -- 
      constant mdaq2_LIS3_ANGLE_Z_2                        : integer := 73; -- 
      constant mdaq2_LIS3_ANGLE_Z_3                        : integer := 74; -- 
      subtype mdaq2_LIS3_ANGLE_Z_RANGE is Natural range 74 downto 71; -- 4

      constant DMSBoard_VOUT_5V_0                          : integer := 1; -- 
      constant DMSBoard_VOUT_5V_1                          : integer := 2; -- 
      subtype DMSBoard_VOUT_5V_RANGE is Natural range 2 downto 1; -- 2
      constant DMSBoard_FT_FREQ_0                          : integer := 6; -- 
      constant DMSBoard_FT_FREQ_1                          : integer := 7; -- 
      subtype DMSBoard_FT_FREQ_RANGE is Natural range 7 downto 6; -- 2
      subtype DMSBoard_FT_SENSOR_RANGE is Natural range 7 downto 7; -- 1
      subtype DMSBoard_FT_GAIN_RANGE is Natural range 8 downto 8; -- 1
      subtype DMSBoard_FT_OFFSET_RANGE is Natural range 9 downto 9; -- 1
      subtype DMSBoard_FT_FILTER_TYPE_RANGE is Natural range 10 downto 10; -- 1
      subtype DMSBoard_FT_FILTER_LEN_RANGE is Natural range 11 downto 11; -- 1
      subtype DMSBoard_FT_FILTER_ORDER_RANGE is Natural range 12 downto 12; -- 1
      constant DMSBoard_FT_FILTER_CUTOFF_0                 : integer := 13; -- 
      constant DMSBoard_FT_FILTER_CUTOFF_1                 : integer := 14; -- 
      constant DMSBoard_FT_FILTER_CUTOFF_2                 : integer := 15; -- 
      constant DMSBoard_FT_FILTER_CUTOFF_3                 : integer := 16; -- 
      subtype DMSBoard_FT_FILTER_CUTOFF_RANGE is Natural range 16 downto 13; -- 4
      constant DMSBoard_FT_FILTER_ATT_0                    : integer := 14; -- 
      constant DMSBoard_FT_FILTER_ATT_1                    : integer := 15; -- 
      constant DMSBoard_FT_FILTER_ATT_2                    : integer := 16; -- 
      constant DMSBoard_FT_FILTER_ATT_3                    : integer := 17; -- 
      subtype DMSBoard_FT_FILTER_ATT_RANGE is Natural range 17 downto 14; -- 4


    -- ------------------------- --
    -- DeviceClass RegisterTypes --
    -- ------------------------- --

    constant NDLCom_REGISTER_TYPES : reg_types_t(1 downto 0) := (
         0 => uint8,
         others => ERROR
    );

    constant NDLCom_REGISTER_MEM_TYPES : reg_mem_types_t(1 downto 0) := (
         0 => prom,
         others => ERROR
    );

    constant NDLCom_REGISTER_MEM_MAP : reg_mem_map_t(1 downto 0) := (
         0 => 0,
         others => 0
    );

    constant NDLCom_MAX_REGISTER_ID : integer := 0;
    constant NDLCom_MIN_REGISTER_ID : integer := 0;
    constant NDLCom_PROM_REGISTER_MEMORY_SIZE : integer := 8;
    constant NDLCom_RAM_REGISTER_MEMORY_SIZE  : integer := 7;
    constant NDLCom_RO_REGISTER_MEMORY_SIZE   : integer := 7;

    constant FPGAJoint_REGISTER_TYPES : reg_types_t(5 downto 1) := (
         1 => uint8,
         2 => uint8,
         3 => uint8,
         4 => uint8,
         others => ERROR
    );

    constant FPGAJoint_REGISTER_MEM_TYPES : reg_mem_types_t(5 downto 1) := (
         1 => ro,
         2 => ro,
         3 => ro,
         4 => ro,
         others => ERROR
    );

    constant FPGAJoint_REGISTER_MEM_MAP : reg_mem_map_t(5 downto 1) := (
         1 => 0,
         2 => 1,
         3 => 2,
         4 => 3,
         others => 0
    );

    constant FPGAJoint_MAX_REGISTER_ID : integer := 4;
    constant FPGAJoint_MIN_REGISTER_ID : integer := 1;
    constant FPGAJoint_PROM_REGISTER_MEMORY_SIZE : integer := 7;
    constant FPGAJoint_RAM_REGISTER_MEMORY_SIZE  : integer := 7;
    constant FPGAJoint_RO_REGISTER_MEMORY_SIZE   : integer := 11;

    constant BLDCJoint_REGISTER_TYPES : reg_types_t(565 downto 5) := (
         5 => uint8,
         6 => uint32,
         10 => uint8,
         14 => int16,
         16 => uint8,
         17 => uint8,
         18 => uint8,
         19 => uint8,
         20 => uint8,
         21 => uint8,
         22 => uint8,
         23 => uint32,
         24 => uint32,
         25 => uint32,
         26 => uint32,
         27 => int16,
         28 => int16,
         29 => int32,
         30 => int16,
         31 => int16,
         266 => uint16,
         272 => int16,
         516 => uint32,
         518 => uint32,
         540 => uint16,
         542 => uint16,
         550 => uint16,
         551 => int16,
         552 => int16,
         553 => int32,
         554 => int16,
         555 => uint16,
         556 => uint16,
         557 => int16,
         558 => int16,
         559 => int16,
         560 => int16,
         561 => int16,
         562 => int16,
         563 => int16,
         564 => int16,
         others => ERROR
    );

    constant BLDCJoint_REGISTER_MEM_TYPES : reg_mem_types_t(565 downto 5) := (
         5 => ro,
         6 => prom,
         10 => prom,
         14 => prom,
         16 => prom,
         17 => prom,
         18 => prom,
         19 => prom,
         20 => prom,
         21 => prom,
         22 => prom,
         23 => prom,
         24 => prom,
         25 => ram,
         26 => ram,
         27 => prom,
         28 => prom,
         29 => prom,
         30 => prom,
         31 => prom,
         266 => ram,
         272 => ram,
         516 => ro,
         518 => ro,
         540 => ro,
         542 => ro,
         550 => ro,
         551 => ro,
         552 => ro,
         553 => ro,
         554 => ro,
         555 => ro,
         556 => ro,
         557 => ro,
         558 => ro,
         559 => ro,
         560 => ro,
         561 => ro,
         562 => ro,
         563 => ro,
         564 => ro,
         others => ERROR
    );

    constant BLDCJoint_REGISTER_MEM_MAP : reg_mem_map_t(565 downto 5) := (
         5 => 0,
         6 => 0,
         10 => 4,
         14 => 5,
         16 => 7,
         17 => 8,
         18 => 9,
         19 => 10,
         20 => 11,
         21 => 12,
         22 => 13,
         23 => 14,
         24 => 18,
         25 => 0,
         26 => 4,
         27 => 22,
         28 => 24,
         29 => 26,
         30 => 30,
         31 => 32,
         266 => 8,
         272 => 10,
         516 => 1,
         518 => 5,
         540 => 9,
         542 => 11,
         550 => 13,
         551 => 15,
         552 => 17,
         553 => 19,
         554 => 23,
         555 => 25,
         556 => 27,
         557 => 29,
         558 => 31,
         559 => 33,
         560 => 35,
         561 => 37,
         562 => 39,
         563 => 41,
         564 => 43,
         others => 0
    );

    constant BLDCJoint_MAX_REGISTER_ID : integer := 564;
    constant BLDCJoint_MIN_REGISTER_ID : integer := 5;
    constant BLDCJoint_PROM_REGISTER_MEMORY_SIZE : integer := 41;
    constant BLDCJoint_RAM_REGISTER_MEMORY_SIZE  : integer := 19;
    constant BLDCJoint_RO_REGISTER_MEMORY_SIZE   : integer := 52;

    constant CascadedController_REGISTER_TYPES : reg_types_t(513 downto 32) := (
         32 => uint32,
         36 => uint32,
         40 => uint32,
         44 => uint32,
         48 => uint32,
         52 => uint32,
         56 => uint32,
         60 => uint32,
         64 => uint32,
         68 => uint16,
         70 => uint32,
         74 => uint16,
         76 => uint16,
         78 => uint16,
         80 => uint16,
         82 => uint16,
         84 => uint16,
         86 => uint16,
         88 => int16,
         90 => int16,
         92 => uint32,
         96 => uint16,
         98 => uint8,
         256 => int16,
         258 => int32,
         262 => int16,
         264 => int16,
         512 => uint8,
         others => ERROR
    );

    constant CascadedController_REGISTER_MEM_TYPES : reg_mem_types_t(513 downto 32) := (
         32 => prom,
         36 => prom,
         40 => prom,
         44 => prom,
         48 => prom,
         52 => prom,
         56 => prom,
         60 => prom,
         64 => prom,
         68 => prom,
         70 => prom,
         74 => prom,
         76 => prom,
         78 => prom,
         80 => prom,
         82 => prom,
         84 => prom,
         86 => prom,
         88 => prom,
         90 => prom,
         92 => prom,
         96 => prom,
         98 => prom,
         256 => ram,
         258 => ram,
         262 => ram,
         264 => ram,
         512 => ro,
         others => ERROR
    );

    constant CascadedController_REGISTER_MEM_MAP : reg_mem_map_t(513 downto 32) := (
         32 => 0,
         36 => 4,
         40 => 8,
         44 => 12,
         48 => 16,
         52 => 20,
         56 => 24,
         60 => 28,
         64 => 32,
         68 => 36,
         70 => 38,
         74 => 42,
         76 => 44,
         78 => 46,
         80 => 48,
         82 => 50,
         84 => 52,
         86 => 54,
         88 => 56,
         90 => 58,
         92 => 60,
         96 => 64,
         98 => 66,
         256 => 0,
         258 => 2,
         262 => 6,
         264 => 8,
         512 => 0,
         others => 0
    );

    constant CascadedController_MAX_REGISTER_ID : integer := 512;
    constant CascadedController_MIN_REGISTER_ID : integer := 32;
    constant CascadedController_PROM_REGISTER_MEMORY_SIZE : integer := 74;
    constant CascadedController_RAM_REGISTER_MEMORY_SIZE  : integer := 17;
    constant CascadedController_RO_REGISTER_MEMORY_SIZE   : integer := 8;

    constant MotionController_General_REGISTER_TYPES : reg_types_t(15 downto 0) := (
         0 => uint8,
         1 => uint32,
         2 => uint8,
         3 => uint32,
         4 => uint8,
         5 => uint8,
         6 => singleFloat,
         7 => uint8,
         8 => uint8,
         9 => uint8,
         10 => singleFloat,
         11 => singleFloat,
         12 => uint8,
         13 => uint8,
         14 => uint8,
         others => ERROR
    );

    constant MotionController_General_REGISTER_MEM_TYPES : reg_mem_types_t(15 downto 0) := (
         0 => ram,
         1 => ram,
         2 => ram,
         3 => ram,
         4 => ram,
         5 => ram,
         6 => ram,
         7 => ram,
         8 => ram,
         9 => ram,
         10 => ram,
         11 => ram,
         12 => ram,
         13 => ram,
         14 => ram,
         others => ERROR
    );

    constant MotionController_General_REGISTER_MEM_MAP : reg_mem_map_t(15 downto 0) := (
         0 => 0,
         1 => 1,
         2 => 5,
         3 => 6,
         4 => 10,
         5 => 11,
         6 => 12,
         7 => 16,
         8 => 17,
         9 => 18,
         10 => 19,
         11 => 23,
         12 => 27,
         13 => 28,
         14 => 29,
         others => 0
    );

    constant MotionController_General_MAX_REGISTER_ID : integer := 14;
    constant MotionController_General_MIN_REGISTER_ID : integer := 0;
    constant MotionController_General_PROM_REGISTER_MEMORY_SIZE : integer := 7;
    constant MotionController_General_RAM_REGISTER_MEMORY_SIZE  : integer := 37;
    constant MotionController_General_RO_REGISTER_MEMORY_SIZE   : integer := 7;

    constant MotionController_Balance_REGISTER_TYPES : reg_types_t(1519 downto 1500) := (
         1500 => singleFloat,
         1501 => uint8,
         1505 => singleFloat,
         1506 => singleFloat,
         1507 => singleFloat,
         1508 => singleFloat,
         1509 => singleFloat,
         1510 => singleFloat,
         1511 => singleFloat,
         1512 => singleFloat,
         1513 => singleFloat,
         1514 => singleFloat,
         1515 => singleFloat,
         1516 => singleFloat,
         1517 => singleFloat,
         1518 => singleFloat,
         others => ERROR
    );

    constant MotionController_Balance_REGISTER_MEM_TYPES : reg_mem_types_t(1519 downto 1500) := (
         1500 => ram,
         1501 => ram,
         1505 => ram,
         1506 => ram,
         1507 => ram,
         1508 => ram,
         1509 => ram,
         1510 => ram,
         1511 => ram,
         1512 => ram,
         1513 => ram,
         1514 => ram,
         1515 => ram,
         1516 => ram,
         1517 => ram,
         1518 => ram,
         others => ERROR
    );

    constant MotionController_Balance_REGISTER_MEM_MAP : reg_mem_map_t(1519 downto 1500) := (
         1500 => 0,
         1501 => 4,
         1505 => 5,
         1506 => 9,
         1507 => 13,
         1508 => 17,
         1509 => 21,
         1510 => 25,
         1511 => 29,
         1512 => 33,
         1513 => 37,
         1514 => 41,
         1515 => 45,
         1516 => 49,
         1517 => 53,
         1518 => 57,
         others => 0
    );

    constant MotionController_Balance_MAX_REGISTER_ID : integer := 1518;
    constant MotionController_Balance_MIN_REGISTER_ID : integer := 1500;
    constant MotionController_Balance_PROM_REGISTER_MEMORY_SIZE : integer := 7;
    constant MotionController_Balance_RAM_REGISTER_MEMORY_SIZE  : integer := 68;
    constant MotionController_Balance_RO_REGISTER_MEMORY_SIZE   : integer := 7;

    constant MotionController_WalkControl_REGISTER_TYPES : reg_types_t(1113 downto 1000) := (
         1000 => uint8,
         1001 => uint8,
         1002 => uint8,
         1011 => uint16,
         1012 => uint16,
         1013 => int16,
         1014 => int16,
         1015 => int16,
         1016 => singleFloat,
         1017 => singleFloat,
         1018 => singleFloat,
         1019 => singleFloat,
         1020 => singleFloat,
         1021 => singleFloat,
         1022 => int16,
         1023 => int16,
         1024 => int16,
         1025 => int16,
         1026 => int16,
         1027 => int16,
         1028 => int16,
         1029 => int16,
         1030 => int16,
         1031 => int16,
         1032 => int16,
         1033 => singleFloat,
         1035 => singleFloat,
         1036 => singleFloat,
         1037 => singleFloat,
         1041 => singleFloat,
         1042 => singleFloat,
         1043 => singleFloat,
         1044 => singleFloat,
         1045 => uint8,
         1046 => uint8,
         1047 => uint8,
         1048 => uint8,
         1049 => singleFloat,
         1050 => singleFloat,
         1051 => singleFloat,
         1052 => singleFloat,
         1053 => singleFloat,
         1054 => singleFloat,
         1055 => singleFloat,
         1056 => singleFloat,
         1064 => singleFloat,
         1065 => uint8,
         1066 => singleFloat,
         1067 => uint8,
         1070 => singleFloat,
         1071 => singleFloat,
         1072 => singleFloat,
         1073 => singleFloat,
         1074 => singleFloat,
         1075 => singleFloat,
         1076 => singleFloat,
         1077 => singleFloat,
         1078 => singleFloat,
         1079 => singleFloat,
         1080 => singleFloat,
         1081 => singleFloat,
         1100 => singleFloat,
         1101 => singleFloat,
         1102 => singleFloat,
         1103 => singleFloat,
         1104 => singleFloat,
         1105 => singleFloat,
         1112 => singleFloat,
         others => ERROR
    );

    constant MotionController_WalkControl_REGISTER_MEM_TYPES : reg_mem_types_t(1113 downto 1000) := (
         1000 => ram,
         1001 => ram,
         1002 => ram,
         1011 => ram,
         1012 => ram,
         1013 => ram,
         1014 => ram,
         1015 => ram,
         1016 => ram,
         1017 => ram,
         1018 => ram,
         1019 => ram,
         1020 => ram,
         1021 => ram,
         1022 => ram,
         1023 => ram,
         1024 => ram,
         1025 => ram,
         1026 => ram,
         1027 => ram,
         1028 => ram,
         1029 => ram,
         1030 => ram,
         1031 => ram,
         1032 => ram,
         1033 => ram,
         1035 => ram,
         1036 => ram,
         1037 => ram,
         1041 => ram,
         1042 => ram,
         1043 => ram,
         1044 => ram,
         1045 => ram,
         1046 => ram,
         1047 => ram,
         1048 => ram,
         1049 => ram,
         1050 => ram,
         1051 => ram,
         1052 => ram,
         1053 => ram,
         1054 => ram,
         1055 => ram,
         1056 => ram,
         1064 => ram,
         1065 => ram,
         1066 => ram,
         1067 => ram,
         1070 => ram,
         1071 => ram,
         1072 => ram,
         1073 => ram,
         1074 => ram,
         1075 => ram,
         1076 => ram,
         1077 => ram,
         1078 => ram,
         1079 => ram,
         1080 => ram,
         1081 => ram,
         1100 => ram,
         1101 => ram,
         1102 => ram,
         1103 => ram,
         1104 => ram,
         1105 => ram,
         1112 => ram,
         others => ERROR
    );

    constant MotionController_WalkControl_REGISTER_MEM_MAP : reg_mem_map_t(1113 downto 1000) := (
         1000 => 0,
         1001 => 1,
         1002 => 2,
         1011 => 3,
         1012 => 5,
         1013 => 7,
         1014 => 9,
         1015 => 11,
         1016 => 13,
         1017 => 17,
         1018 => 21,
         1019 => 25,
         1020 => 29,
         1021 => 33,
         1022 => 37,
         1023 => 39,
         1024 => 41,
         1025 => 43,
         1026 => 45,
         1027 => 47,
         1028 => 49,
         1029 => 51,
         1030 => 53,
         1031 => 55,
         1032 => 57,
         1033 => 59,
         1035 => 63,
         1036 => 67,
         1037 => 71,
         1041 => 75,
         1042 => 79,
         1043 => 83,
         1044 => 87,
         1045 => 91,
         1046 => 92,
         1047 => 93,
         1048 => 94,
         1049 => 95,
         1050 => 99,
         1051 => 103,
         1052 => 107,
         1053 => 111,
         1054 => 115,
         1055 => 119,
         1056 => 123,
         1064 => 127,
         1065 => 131,
         1066 => 132,
         1067 => 136,
         1070 => 137,
         1071 => 141,
         1072 => 145,
         1073 => 149,
         1074 => 153,
         1075 => 157,
         1076 => 161,
         1077 => 165,
         1078 => 169,
         1079 => 173,
         1080 => 177,
         1081 => 181,
         1100 => 185,
         1101 => 189,
         1102 => 193,
         1103 => 197,
         1104 => 201,
         1105 => 205,
         1112 => 209,
         others => 0
    );

    constant MotionController_WalkControl_MAX_REGISTER_ID : integer := 1112;
    constant MotionController_WalkControl_MIN_REGISTER_ID : integer := 1000;
    constant MotionController_WalkControl_PROM_REGISTER_MEMORY_SIZE : integer := 7;
    constant MotionController_WalkControl_RAM_REGISTER_MEMORY_SIZE  : integer := 220;
    constant MotionController_WalkControl_RO_REGISTER_MEMORY_SIZE   : integer := 7;

    constant MotionController_WalkTwoLeggedControl_REGISTER_TYPES : reg_types_t(2053 downto 2001) := (
         2001 => uint8,
         2011 => uint16,
         2012 => uint16,
         2013 => int16,
         2014 => int16,
         2015 => int16,
         2016 => int16,
         2017 => int16,
         2018 => int16,
         2022 => int16,
         2023 => int16,
         2024 => int16,
         2025 => int16,
         2026 => int16,
         2027 => int16,
         2028 => int16,
         2029 => int16,
         2030 => int16,
         2031 => int16,
         2032 => uint8,
         2050 => singleFloat,
         2051 => singleFloat,
         2052 => singleFloat,
         others => ERROR
    );

    constant MotionController_WalkTwoLeggedControl_REGISTER_MEM_TYPES : reg_mem_types_t(2053 downto 2001) := (
         2001 => ram,
         2011 => ram,
         2012 => ram,
         2013 => ram,
         2014 => ram,
         2015 => ram,
         2016 => ram,
         2017 => ram,
         2018 => ram,
         2022 => ram,
         2023 => ram,
         2024 => ram,
         2025 => ram,
         2026 => ram,
         2027 => ram,
         2028 => ram,
         2029 => ram,
         2030 => ram,
         2031 => ram,
         2032 => ram,
         2050 => ram,
         2051 => ram,
         2052 => ram,
         others => ERROR
    );

    constant MotionController_WalkTwoLeggedControl_REGISTER_MEM_MAP : reg_mem_map_t(2053 downto 2001) := (
         2001 => 0,
         2011 => 1,
         2012 => 3,
         2013 => 5,
         2014 => 7,
         2015 => 9,
         2016 => 11,
         2017 => 13,
         2018 => 15,
         2022 => 17,
         2023 => 19,
         2024 => 21,
         2025 => 23,
         2026 => 25,
         2027 => 27,
         2028 => 29,
         2029 => 31,
         2030 => 33,
         2031 => 35,
         2032 => 37,
         2050 => 38,
         2051 => 42,
         2052 => 46,
         others => 0
    );

    constant MotionController_WalkTwoLeggedControl_MAX_REGISTER_ID : integer := 2052;
    constant MotionController_WalkTwoLeggedControl_MIN_REGISTER_ID : integer := 2001;
    constant MotionController_WalkTwoLeggedControl_PROM_REGISTER_MEMORY_SIZE : integer := 7;
    constant MotionController_WalkTwoLeggedControl_RAM_REGISTER_MEMORY_SIZE  : integer := 57;
    constant MotionController_WalkTwoLeggedControl_RO_REGISTER_MEMORY_SIZE   : integer := 7;

    constant MotionController_SendToPc_REGISTER_TYPES : reg_types_t(41 downto 20) := (
         20 => uint8,
         21 => uint8,
         22 => uint8,
         23 => uint8,
         24 => uint8,
         25 => uint8,
         26 => uint8,
         27 => uint8,
         28 => uint8,
         29 => uint8,
         30 => uint8,
         31 => uint8,
         32 => uint8,
         33 => uint8,
         34 => uint8,
         35 => uint8,
         36 => uint8,
         37 => uint8,
         39 => uint8,
         40 => uint8,
         others => ERROR
    );

    constant MotionController_SendToPc_REGISTER_MEM_TYPES : reg_mem_types_t(41 downto 20) := (
         20 => ram,
         21 => ram,
         22 => ram,
         23 => ram,
         24 => ram,
         25 => ram,
         26 => ram,
         27 => ram,
         28 => ram,
         29 => ram,
         30 => ram,
         31 => ram,
         32 => ram,
         33 => ram,
         34 => ram,
         35 => ram,
         36 => ram,
         37 => ram,
         39 => ram,
         40 => ram,
         others => ERROR
    );

    constant MotionController_SendToPc_REGISTER_MEM_MAP : reg_mem_map_t(41 downto 20) := (
         20 => 0,
         21 => 1,
         22 => 2,
         23 => 3,
         24 => 4,
         25 => 5,
         26 => 6,
         27 => 7,
         28 => 8,
         29 => 9,
         30 => 10,
         31 => 11,
         32 => 12,
         33 => 13,
         34 => 14,
         35 => 15,
         36 => 16,
         37 => 17,
         39 => 18,
         40 => 19,
         others => 0
    );

    constant MotionController_SendToPc_MAX_REGISTER_ID : integer := 40;
    constant MotionController_SendToPc_MIN_REGISTER_ID : integer := 20;
    constant MotionController_SendToPc_PROM_REGISTER_MEMORY_SIZE : integer := 7;
    constant MotionController_SendToPc_RAM_REGISTER_MEMORY_SIZE  : integer := 27;
    constant MotionController_SendToPc_RO_REGISTER_MEMORY_SIZE   : integer := 7;

    constant PicoBlazeArray_REGISTER_TYPES : reg_types_t(3 downto 1) := (
         1 => uint8,
         2 => uint8,
         others => ERROR
    );

    constant PicoBlazeArray_REGISTER_MEM_TYPES : reg_mem_types_t(3 downto 1) := (
         1 => ram,
         2 => ram,
         others => ERROR
    );

    constant PicoBlazeArray_REGISTER_MEM_MAP : reg_mem_map_t(3 downto 1) := (
         1 => 0,
         2 => 1,
         others => 0
    );

    constant PicoBlazeArray_MAX_REGISTER_ID : integer := 2;
    constant PicoBlazeArray_MIN_REGISTER_ID : integer := 1;
    constant PicoBlazeArray_PROM_REGISTER_MEMORY_SIZE : integer := 7;
    constant PicoBlazeArray_RAM_REGISTER_MEMORY_SIZE  : integer := 9;
    constant PicoBlazeArray_RO_REGISTER_MEMORY_SIZE   : integer := 7;

    constant mdaq2_REGISTER_TYPES : reg_types_t(72 downto 1) := (
         1 => uint8,
         2 => uint8,
         3 => uint16,
         4 => uint16,
         5 => uint16,
         6 => uint32,
         7 => int32,
         8 => uint8,
         9 => uint16,
         10 => uint8,
         11 => uint8,
         12 => uint8,
         13 => uint8,
         14 => uint8,
         15 => uint8,
         16 => singleFloat,
         17 => singleFloat,
         18 => uint8,
         19 => uint8,
         20 => singleFloat,
         21 => singleFloat,
         22 => singleFloat,
         23 => singleFloat,
         24 => singleFloat,
         25 => uint8,
         26 => uint16,
         27 => uint8,
         28 => uint8,
         29 => uint8,
         30 => uint32,
         31 => uint8,
         32 => uint8,
         33 => uint16,
         34 => uint8,
         35 => uint8,
         36 => uint8,
         37 => uint8,
         38 => uint8,
         39 => uint8,
         40 => uint16,
         41 => uint8,
         42 => uint16,
         43 => uint8,
         44 => uint8,
         45 => uint16,
         46 => uint8,
         47 => uint8,
         48 => uint16,
         49 => uint8,
         50 => uint8,
         51 => uint8,
         52 => int32,
         53 => uint8,
         54 => singleFloat,
         55 => singleFloat,
         56 => singleFloat,
         57 => singleFloat,
         58 => singleFloat,
         59 => singleFloat,
         60 => singleFloat,
         61 => singleFloat,
         62 => int32,
         63 => int32,
         64 => int32,
         65 => int32,
         66 => singleFloat,
         67 => singleFloat,
         68 => singleFloat,
         69 => singleFloat,
         70 => singleFloat,
         71 => singleFloat,
         others => ERROR
    );

    constant mdaq2_REGISTER_MEM_TYPES : reg_mem_types_t(72 downto 1) := (
         1 => ram,
         2 => ram,
         3 => ram,
         4 => ram,
         5 => ram,
         6 => ram,
         7 => ram,
         8 => ram,
         9 => ram,
         10 => ram,
         11 => ram,
         12 => ram,
         13 => ram,
         14 => ram,
         15 => ram,
         16 => ram,
         17 => ram,
         18 => ram,
         19 => ram,
         20 => ram,
         21 => ram,
         22 => ram,
         23 => ram,
         24 => ram,
         25 => ram,
         26 => ram,
         27 => ram,
         28 => ram,
         29 => ram,
         30 => ram,
         31 => ram,
         32 => ram,
         33 => ram,
         34 => ram,
         35 => ram,
         36 => ram,
         37 => ram,
         38 => ram,
         39 => ram,
         40 => ram,
         41 => ram,
         42 => ram,
         43 => ram,
         44 => ram,
         45 => ram,
         46 => ram,
         47 => ram,
         48 => ram,
         49 => ram,
         50 => ram,
         51 => ram,
         52 => ram,
         53 => ram,
         54 => ram,
         55 => ram,
         56 => ram,
         57 => ram,
         58 => ram,
         59 => ram,
         60 => ram,
         61 => ram,
         62 => ram,
         63 => ram,
         64 => ram,
         65 => ram,
         66 => ram,
         67 => ram,
         68 => ram,
         69 => ram,
         70 => ram,
         71 => ram,
         others => ERROR
    );

    constant mdaq2_REGISTER_MEM_MAP : reg_mem_map_t(72 downto 1) := (
         1 => 0,
         2 => 1,
         3 => 2,
         4 => 4,
         5 => 6,
         6 => 8,
         7 => 12,
         8 => 16,
         9 => 17,
         10 => 19,
         11 => 20,
         12 => 21,
         13 => 22,
         14 => 23,
         15 => 24,
         16 => 25,
         17 => 29,
         18 => 33,
         19 => 34,
         20 => 35,
         21 => 39,
         22 => 43,
         23 => 47,
         24 => 51,
         25 => 55,
         26 => 56,
         27 => 58,
         28 => 59,
         29 => 60,
         30 => 61,
         31 => 65,
         32 => 66,
         33 => 67,
         34 => 69,
         35 => 70,
         36 => 71,
         37 => 72,
         38 => 73,
         39 => 74,
         40 => 75,
         41 => 77,
         42 => 78,
         43 => 80,
         44 => 81,
         45 => 82,
         46 => 84,
         47 => 85,
         48 => 86,
         49 => 88,
         50 => 89,
         51 => 90,
         52 => 91,
         53 => 95,
         54 => 96,
         55 => 100,
         56 => 104,
         57 => 108,
         58 => 112,
         59 => 116,
         60 => 120,
         61 => 124,
         62 => 128,
         63 => 132,
         64 => 136,
         65 => 140,
         66 => 144,
         67 => 148,
         68 => 152,
         69 => 156,
         70 => 160,
         71 => 164,
         others => 0
    );

    constant mdaq2_MAX_REGISTER_ID : integer := 71;
    constant mdaq2_MIN_REGISTER_ID : integer := 1;
    constant mdaq2_PROM_REGISTER_MEMORY_SIZE : integer := 7;
    constant mdaq2_RAM_REGISTER_MEMORY_SIZE  : integer := 175;
    constant mdaq2_RO_REGISTER_MEMORY_SIZE   : integer := 7;

    constant DMSBoard_REGISTER_TYPES : reg_types_t(15 downto 1) := (
         1 => uint16,
         6 => uint16,
         7 => uint8,
         8 => uint8,
         9 => uint8,
         10 => uint8,
         11 => uint8,
         12 => uint8,
         13 => singleFloat,
         14 => singleFloat,
         others => ERROR
    );

    constant DMSBoard_REGISTER_MEM_TYPES : reg_mem_types_t(15 downto 1) := (
         1 => ram,
         6 => ram,
         7 => ram,
         8 => ram,
         9 => ram,
         10 => ram,
         11 => ram,
         12 => ram,
         13 => ram,
         14 => ram,
         others => ERROR
    );

    constant DMSBoard_REGISTER_MEM_MAP : reg_mem_map_t(15 downto 1) := (
         1 => 0,
         6 => 2,
         7 => 4,
         8 => 5,
         9 => 6,
         10 => 7,
         11 => 8,
         12 => 9,
         13 => 10,
         14 => 14,
         others => 0
    );

    constant DMSBoard_MAX_REGISTER_ID : integer := 14;
    constant DMSBoard_MIN_REGISTER_ID : integer := 1;
    constant DMSBoard_PROM_REGISTER_MEMORY_SIZE : integer := 7;
    constant DMSBoard_RAM_REGISTER_MEMORY_SIZE  : integer := 25;
    constant DMSBoard_RO_REGISTER_MEMORY_SIZE   : integer := 7;


    -- ----------------------------------------------------- --
    -- Old printDeviceClassRegisterTypes output (deprecated) --
    -- ----------------------------------------------------- --

    -- For backward compatibility the registercount constants
    -- which are defined in the xml-files
    -- (This feature is deprecated and will not work with the
    -- register access functions and process from lib/register!)
    constant NDLCom_ROM_REGISTER : integer := 0;
    constant NDLCom_RAM_REGISTER : integer := 0;
    constant NDLCom_RO_REGISTER : integer := 0;

    -- For backward compatibility the registercount constants
    -- which are defined in the xml-files
    -- (This feature is deprecated and will not work with the
    -- register access functions and process from lib/register!)
    constant FPGAJoint_ROM_REGISTER : integer := 0;
    constant FPGAJoint_RAM_REGISTER : integer := 0;
    constant FPGAJoint_RO_REGISTER : integer := 0;

    -- For backward compatibility the registercount constants
    -- which are defined in the xml-files
    -- (This feature is deprecated and will not work with the
    -- register access functions and process from lib/register!)
    constant BLDCJoint_ROM_REGISTER : integer := 128;
    constant BLDCJoint_RAM_REGISTER : integer := 64;
    constant BLDCJoint_RO_REGISTER : integer := 40;

    -- For backward compatibility the registercount constants
    -- which are defined in the xml-files
    -- (This feature is deprecated and will not work with the
    -- register access functions and process from lib/register!)
    constant CascadedController_ROM_REGISTER : integer := 0;
    constant CascadedController_RAM_REGISTER : integer := 0;
    constant CascadedController_RO_REGISTER : integer := 0;

    -- For backward compatibility the registercount constants
    -- which are defined in the xml-files
    -- (This feature is deprecated and will not work with the
    -- register access functions and process from lib/register!)
    constant MotionController_General_ROM_REGISTER : integer := 0;
    constant MotionController_General_RAM_REGISTER : integer := 0;
    constant MotionController_General_RO_REGISTER : integer := 0;

    -- For backward compatibility the registercount constants
    -- which are defined in the xml-files
    -- (This feature is deprecated and will not work with the
    -- register access functions and process from lib/register!)
    constant MotionController_Balance_ROM_REGISTER : integer := 0;
    constant MotionController_Balance_RAM_REGISTER : integer := 0;
    constant MotionController_Balance_RO_REGISTER : integer := 0;

    -- For backward compatibility the registercount constants
    -- which are defined in the xml-files
    -- (This feature is deprecated and will not work with the
    -- register access functions and process from lib/register!)
    constant MotionController_WalkControl_ROM_REGISTER : integer := 0;
    constant MotionController_WalkControl_RAM_REGISTER : integer := 0;
    constant MotionController_WalkControl_RO_REGISTER : integer := 0;

    -- For backward compatibility the registercount constants
    -- which are defined in the xml-files
    -- (This feature is deprecated and will not work with the
    -- register access functions and process from lib/register!)
    constant MotionController_WalkTwoLeggedControl_ROM_REGISTER : integer := 0;
    constant MotionController_WalkTwoLeggedControl_RAM_REGISTER : integer := 0;
    constant MotionController_WalkTwoLeggedControl_RO_REGISTER : integer := 0;

    -- For backward compatibility the registercount constants
    -- which are defined in the xml-files
    -- (This feature is deprecated and will not work with the
    -- register access functions and process from lib/register!)
    constant MotionController_SendToPc_ROM_REGISTER : integer := 0;
    constant MotionController_SendToPc_RAM_REGISTER : integer := 0;
    constant MotionController_SendToPc_RO_REGISTER : integer := 0;

    -- For backward compatibility the registercount constants
    -- which are defined in the xml-files
    -- (This feature is deprecated and will not work with the
    -- register access functions and process from lib/register!)
    constant PicoBlazeArray_ROM_REGISTER : integer := 0;
    constant PicoBlazeArray_RAM_REGISTER : integer := 2;
    constant PicoBlazeArray_RO_REGISTER : integer := 1;

    -- For backward compatibility the registercount constants
    -- which are defined in the xml-files
    -- (This feature is deprecated and will not work with the
    -- register access functions and process from lib/register!)
    constant mdaq2_ROM_REGISTER : integer := 0;
    constant mdaq2_RAM_REGISTER : integer := 0;
    constant mdaq2_RO_REGISTER : integer := 0;

    -- For backward compatibility the registercount constants
    -- which are defined in the xml-files
    -- (This feature is deprecated and will not work with the
    -- register access functions and process from lib/register!)
    constant DMSBoard_ROM_REGISTER : integer := 0;
    constant DMSBoard_RAM_REGISTER : integer := 0;
    constant DMSBoard_RO_REGISTER : integer := 0;


    -- ---------------------- --
    -- MetaClass Register Ids --
    -- ---------------------- --

    -- NDLCom
    constant BLDCJointMC_NDLCom_NODE_ID                 : integer := 0;  --! Current node id

    -- FPGAJoint
    constant BLDCJointMC_FPGAJoint_SYNTHESIS_YEAR       : integer := 1;  --! Synthesis date (year)
    constant BLDCJointMC_FPGAJoint_SYNTHESIS_MONTH      : integer := 2;  --! Synthesis date (month)
    constant BLDCJointMC_FPGAJoint_SYNTHESIS_DAY        : integer := 3;  --! Synthesis date (day)
    constant BLDCJointMC_FPGAJoint_SYNTHESIS_AUTHOR     : integer := 4;  --! Synthesis author

    -- BLDCJoint
    constant BLDCJointMC_BLDCJoint_STACK_VERSION        : integer := 5;  --! BLDC Stack version (V1-V3 = 1-3, BLDC2 = 4)
    constant BLDCJointMC_BLDCJoint_TICKS_PER_TURN       : integer := 6;  --! Encoder ticks per turn (360 degree at joint)
    constant BLDCJointMC_BLDCJoint_INVERT_CONFIG        : integer := 10;  --! Configuration register to invert PWM, Pos/Speed, Current, ...
        constant BLDCJointMC_BLDCJoint_INVERT_CONFIG_PWM_BIT     : integer := 0; --! Invert PWM
        constant BLDCJointMC_BLDCJoint_INVERT_CONFIG_POS_BIT     : integer := 1; --! Invert Pos/Speed
        constant BLDCJointMC_BLDCJoint_INVERT_CONFIG_CUR_BIT     : integer := 2; --! Invert Current
        constant BLDCJointMC_BLDCJoint_INVERT_CONFIG_ABS_POS_BIT : integer := 3; --! Invert Absolute Position
    constant BLDCJointMC_BLDCJoint_ABS_POS_OFFSET       : integer := 14;  --! Absolute position sensor offset, signed ticks
    constant BLDCJointMC_BLDCJoint_ICHAUS_GCC           : integer := 16;  --! iC-Haus gcc (amplitude ratio) configuration value
    constant BLDCJointMC_BLDCJoint_ICHAUS_VOSS          : integer := 17;  --! iC-Haus voss (sine offset) configuration value
    constant BLDCJointMC_BLDCJoint_ICHAUS_VOSC          : integer := 18;  --! iC-Haus vosc (cosine offset) configuration value
    constant BLDCJointMC_BLDCJoint_CUR_FILTER_DAMPING   : integer := 19;  --! Filter damping setting x -> damping 2**-x (bits 4-0) for current
    constant BLDCJointMC_BLDCJoint_VEL_FILTER_DAMPING   : integer := 20;  --! Filter damping setting x -> damping 2**-x (bits 4-0) for velocity
    constant BLDCJointMC_BLDCJoint_ACC_FILTER_DAMPING   : integer := 21;  --! Filter damping setting x -> damping 2**-x (bits 4-0) for acceleration
    constant BLDCJointMC_BLDCJoint_PWM_FILTER_DAMPING   : integer := 22;  --! Filter damping setting x -> damping 2**-x (bits 4-0) for acceleration
    constant BLDCJointMC_BLDCJoint_INIT_ERROR_IGNORE    : integer := 23;  --! Initial error ignore settings (Errors -> Warnings)
    constant BLDCJointMC_BLDCJoint_INIT_ERROR_DISABLE   : integer := 24;  --! Initial error disable settings
    constant BLDCJointMC_BLDCJoint_ERROR_IGNORE         : integer := 25;  --! Register to set error ignore bits (Errors -> Warnings)
    constant BLDCJointMC_BLDCJoint_ERROR_DISABLE        : integer := 26;  --! Register to set error disable bits
    constant BLDCJointMC_BLDCJoint_POS_MIN_HARD_LIMIT   : integer := 27;  --! Position lower bound hard-limit
    constant BLDCJointMC_BLDCJoint_POS_MAX_HARD_LIMIT   : integer := 28;  --! Position upper bound hard-limit
    constant BLDCJointMC_BLDCJoint_VEL_HARD_LIMIT       : integer := 29;  --! Speed hard-limit
    constant BLDCJointMC_BLDCJoint_CUR_HARD_LIMIT       : integer := 30;  --! Current hard-limit
    constant BLDCJointMC_BLDCJoint_MAX_TEMP_LIMIT       : integer := 31;  --! Temperature limit
    constant BLDCJointMC_BLDCJoint_CONFIG               : integer := 266;  --! Configuration register (enable, drive mode, ...)
        constant BLDCJointMC_BLDCJoint_CONFIG_ENABLE_CMD_BIT     : integer := 0; --! Enable command
        constant BLDCJointMC_BLDCJoint_CONFIG_INTERPOLATOR_BIT   : integer := 1; --! Enable interpolator
        constant BLDCJointMC_BLDCJoint_CONFIG_DIRECT_PWM_BIT     : integer := 2; --! Enable direct pwm
        constant BLDCJointMC_BLDCJoint_CONFIG_ZERO_POS_BIT       : integer := 3; --! Set position offset, so that this position is zero.
        constant BLDCJointMC_BLDCJoint_CONFIG_RESET_POS_BIT      : integer := 4; --! Set incremental encoder position to absolute position
        constant BLDCJointMC_BLDCJoint_CONFIG_RESET_ERRORS_BIT   : integer := 5; --! Trigger reset of error flags
        constant BLDCJointMC_BLDCJoint_CONFIG_OPEN_BRAKE_BIT     : integer := 6; --! Open the brake
        constant BLDCJointMC_BLDCJoint_CONFIG_WRITE_SETTINGS_BIT : integer := 7; --! Write settings trigger
        constant BLDCJointMC_BLDCJoint_CONFIG_DEBUG_MODE_BIT     : integer := 11; --! Enable debug mode
    constant BLDCJointMC_BLDCJoint_DIRECT_PWM           : integer := 272;  --! Direct PWM
    constant BLDCJointMC_BLDCJoint_WARNING              : integer := 516;  --! Actual joint warning state
        constant BLDCJointMC_BLDCJoint_WARNING_INIT_BIT          : integer := 0; --! Initialization fail
        constant BLDCJointMC_BLDCJoint_WARNING_POSITIONDIFFERENCE_BIT : integer := 1; --! Position difference between incremental and absolute encoder too large
        constant BLDCJointMC_BLDCJoint_WARNING_POS_HARD_LIMIT_BIT : integer := 2; --! Position value out of hard limits
        constant BLDCJointMC_BLDCJoint_WARNING_VEL_HARD_LIMIT_BIT : integer := 3; --! Velocity value out of hard limits
        constant BLDCJointMC_BLDCJoint_WARNING_CUR_HARD_LIMIT_BIT : integer := 4; --! Current value out of hard limits
        constant BLDCJointMC_BLDCJoint_WARNING_COMMTIMEOUTANY_BIT : integer := 5; --! Timeout since any communication
        constant BLDCJointMC_BLDCJoint_WARNING_COMMTIMEOUTARMCMD_BIT : integer := 6; --! Timeout since last arm command message
        constant BLDCJointMC_BLDCJoint_WARNING_TEMPERATURE_BIT   : integer := 7; --! Temperature to high
        constant BLDCJointMC_BLDCJoint_WARNING_SENSOR_ICHAUS_BIT : integer := 8; --! Absolute pos. sensor failed
        constant BLDCJointMC_BLDCJoint_WARNING_SENSOR_OPTO_BIT   : integer := 9; --! Optical pos. sensor failed
        constant BLDCJointMC_BLDCJoint_WARNING_SENSOR_HALL_BIT   : integer := 10; --! Hall sensor failed
        constant BLDCJointMC_BLDCJoint_WARNING_SENSOR_CURRENT_BIT : integer := 11; --! Current sensor failed
        constant BLDCJointMC_BLDCJoint_WARNING_FRICTION_IDENT_BIT : integer := 12; --! Friction identification failed
        constant BLDCJointMC_BLDCJoint_WARNING_VOLTAGE_BIT       : integer := 13; --! Voltage to high
        constant BLDCJointMC_BLDCJoint_WARNING_CTRL_LIMIT_BIT    : integer := 14; --! One of the controller values saturated
        constant BLDCJointMC_BLDCJoint_WARNING_TELEMETRY_TIMEOUT_BIT : integer := 15; --! Telemetry timeout at MCS
        constant BLDCJointMC_BLDCJoint_WARNING_MOTOR_HALL_DATA_BIT : integer := 16; --! Motor: hall values are invalid
        constant BLDCJointMC_BLDCJoint_WARNING_MOTOR_INCR_DATA_BIT : integer := 17; --! Motor: incremental encoder values are invalid
    constant BLDCJointMC_BLDCJoint_ERROR                : integer := 518;  --! Actual joint error state
        constant BLDCJointMC_BLDCJoint_ERROR_INIT_BIT            : integer := 0; --! Initialization fail
        constant BLDCJointMC_BLDCJoint_ERROR_POSITIONDIFFERENCE_BIT : integer := 1; --! Position difference between incremental and absolute encoder too large
        constant BLDCJointMC_BLDCJoint_ERROR_POS_HARD_LIMIT_BIT  : integer := 2; --! Position value out of hard limits
        constant BLDCJointMC_BLDCJoint_ERROR_VEL_HARD_LIMIT_BIT  : integer := 3; --! Velocity value out of hard limits
        constant BLDCJointMC_BLDCJoint_ERROR_CUR_HARD_LIMIT_BIT  : integer := 4; --! Current value out of hard limits
        constant BLDCJointMC_BLDCJoint_ERROR_COMMTIMEOUTANY_BIT  : integer := 5; --! Timeout since any communication
        constant BLDCJointMC_BLDCJoint_ERROR_COMMTIMEOUTARMCMD_BIT : integer := 6; --! Timeout since last arm command message
        constant BLDCJointMC_BLDCJoint_ERROR_TEMPERATURE_BIT     : integer := 7; --! Temperature to high
        constant BLDCJointMC_BLDCJoint_ERROR_SENSOR_ICHAUS_BIT   : integer := 8; --! Absolute pos. sensor failed
        constant BLDCJointMC_BLDCJoint_ERROR_SENSOR_OPTO_BIT     : integer := 9; --! Optical pos. sensor failed
        constant BLDCJointMC_BLDCJoint_ERROR_SENSOR_HALL_BIT     : integer := 10; --! Hall sensor failed
        constant BLDCJointMC_BLDCJoint_ERROR_SENSOR_CURRENT_BIT  : integer := 11; --! Current sensor failed
        constant BLDCJointMC_BLDCJoint_ERROR_FRICTION_IDENT_BIT  : integer := 12; --! Friction identification failed
        constant BLDCJointMC_BLDCJoint_ERROR_VOLTAGE_BIT         : integer := 13; --! Voltage to high
        constant BLDCJointMC_BLDCJoint_ERROR_CTRL_LIMIT_BIT      : integer := 14; --! One of the controller values saturated
        constant BLDCJointMC_BLDCJoint_ERROR_TELEMETRY_TIMEOUT_BIT : integer := 15; --! Telemetry timeout at MCS
        constant BLDCJointMC_BLDCJoint_ERROR_MOTOR_HALL_DATA_BIT : integer := 16; --! Motor: hall values are invalid
        constant BLDCJointMC_BLDCJoint_ERROR_MOTOR_INCR_DATA_BIT : integer := 17; --! Motor: incremental encoder values are invalid
    constant BLDCJointMC_BLDCJoint_TEMPERATURE0         : integer := 540;  --! Actual temperature 0
    constant BLDCJointMC_BLDCJoint_TEMPERATURE1         : integer := 542;  --! Actual temperature 1
    constant BLDCJointMC_BLDCJoint_STATE                : integer := 550;  --! Actual joint state
        constant BLDCJointMC_BLDCJoint_STATE_ENABLE_BIT          : integer := 0; --! Motor enable flag
        constant BLDCJointMC_BLDCJoint_STATE_WARNINGFLAG_BIT     : integer := 1; --! Joint in warning condition
        constant BLDCJointMC_BLDCJoint_STATE_ERRORFLAG_BIT       : integer := 2; --! Joint in error condition
        constant BLDCJointMC_BLDCJoint_STATE_TELEMETRY_AVAILABLE_BIT : integer := 7; --! Telemetry available flag
        constant BLDCJointMC_BLDCJoint_STATE_ENABLE_CMD_BIT      : integer := 8; --! Enable command
        constant BLDCJointMC_BLDCJoint_STATE_INTERPOLATOR_BIT    : integer := 9; --! Interpolator flag
        constant BLDCJointMC_BLDCJoint_STATE_HALL0_BIT           : integer := 12; --! Hall Signal 0
        constant BLDCJointMC_BLDCJoint_STATE_HALL1_BIT           : integer := 13; --! Hall Signal 1
        constant BLDCJointMC_BLDCJoint_STATE_HALL2_BIT           : integer := 14; --! Hall Signal 2
        constant BLDCJointMC_BLDCJoint_STATE_PROM_BUSY_BIT       : integer := 15; --! EEPROM Busy
    constant BLDCJointMC_BLDCJoint_ABSOLUTE_POSITION    : integer := 551;  --! Absolute Position (iCHaus)
    constant BLDCJointMC_BLDCJoint_POSITION             : integer := 552;  --! Position (Encoder)
    constant BLDCJointMC_BLDCJoint_SPEED                : integer := 553;  --! Speed (Encoder)
    constant BLDCJointMC_BLDCJoint_PWM                  : integer := 554;  --! (Actual) PWM
    constant BLDCJointMC_BLDCJoint_VOLTAGE              : integer := 555;  --! Voltage
    constant BLDCJointMC_BLDCJoint_CURRENT              : integer := 556;  --! Current
    constant BLDCJointMC_BLDCJoint_TEMPERATURE          : integer := 557;  --! Temperature
    constant BLDCJointMC_BLDCJoint_DESIRED_POSITION     : integer := 558;  --! Desired Position
    constant BLDCJointMC_BLDCJoint_CTRL_PWM             : integer := 559;  --! Control PWM
    constant BLDCJointMC_BLDCJoint_DEBUG1               : integer := 560;  --! Debug Value 1
    constant BLDCJointMC_BLDCJoint_DEBUG2               : integer := 561;  --! Debug Value 2
    constant BLDCJointMC_BLDCJoint_DEBUG3               : integer := 562;  --! Debug Value 3
    constant BLDCJointMC_BLDCJoint_DEBUG4               : integer := 563;  --! Debug Value 4
    constant BLDCJointMC_BLDCJoint_DEBUG5               : integer := 564;  --! Debug Value 5

    -- CascadedController
    constant BLDCJointMC_CascadedController_POS_P       : integer := 32;  --! Proportional gain for the position control loop
    constant BLDCJointMC_CascadedController_POS_I       : integer := 36;  --! Integral gain for the position control loop
    constant BLDCJointMC_CascadedController_POS_D       : integer := 40;  --! Derivative gain for the position control loop
    constant BLDCJointMC_CascadedController_VEL_P       : integer := 44;  --! Proportional gain for the velocity control loop
    constant BLDCJointMC_CascadedController_VEL_I       : integer := 48;  --! Integral gain for the velocity control loop
    constant BLDCJointMC_CascadedController_VEL_D       : integer := 52;  --! Derivative gain for the velocity control loop
    constant BLDCJointMC_CascadedController_CUR_P       : integer := 56;  --! Proportional gain for the current control loop
    constant BLDCJointMC_CascadedController_CUR_I       : integer := 60;  --! Integral gain for the current control loop
    constant BLDCJointMC_CascadedController_CUR_D       : integer := 64;  --! Derivative gain for the current control loop
    constant BLDCJointMC_CascadedController_POS_DEAD_ZONE : integer := 68;  --! Dead zone for the position controller
    constant BLDCJointMC_CascadedController_VEL_DEAD_ZONE : integer := 70;  --! Dead zone for the velocity controller
    constant BLDCJointMC_CascadedController_CUR_DEAD_ZONE : integer := 74;  --! Dead zone for the current controller
    constant BLDCJointMC_CascadedController_POS_MAX_ERROR_INTEGRAL : integer := 76;  --! Maximum integral value for position control loop
    constant BLDCJointMC_CascadedController_VEL_MAX_ERROR_INTEGRAL : integer := 78;  --! Maximum integral value for velocity control loop
    constant BLDCJointMC_CascadedController_CUR_MAX_ERROR_INTEGRAL : integer := 80;  --! Maximum integral value for current control loop
    constant BLDCJointMC_CascadedController_POS_MAX_CTRL_VAL : integer := 82;  --! Maximum output of the position control loop
    constant BLDCJointMC_CascadedController_VEL_MAX_CTRL_VAL : integer := 84;  --! Maximum output of the velocity control loop
    constant BLDCJointMC_CascadedController_CUR_MAX_CTRL_VAL : integer := 86;  --! Maximum output of the current controll loop
    constant BLDCJointMC_CascadedController_POS_MIN     : integer := 88;  --! Minimum permissible position
    constant BLDCJointMC_CascadedController_POS_MAX     : integer := 90;  --! Maximum permissible position
    constant BLDCJointMC_CascadedController_VEL_MAX     : integer := 92;  --! Maximum permissible velocity
    constant BLDCJointMC_CascadedController_CUR_MAX     : integer := 96;  --! Maximum permissible current
    constant BLDCJointMC_CascadedController_CTRL_MODE   : integer := 98;  --! Sets Controlmode: 0=SETPWM, 1=CTRLCUR, 2=CTRLVEL_CC, 3=CTRLPOS_CC, 4=CTRLVEL, 5=CTRLPOS, 9=CTRLACC_CTC, 11=CTRLVEL_CTC, 19=CTRLPOS_CTC
        constant BLDCJointMC_CascadedController_CTRL_MODE_SETPWM_VALUE : integer := 0; --! Direct PWM
        constant BLDCJointMC_CascadedController_CTRL_MODE_CTRLCUR_VALUE : integer := 1; --! Current control
        constant BLDCJointMC_CascadedController_CTRL_MODE_CTRLVEL_CC_VALUE : integer := 2; --! Velocity-Current cascade
        constant BLDCJointMC_CascadedController_CTRL_MODE_CTRLPOS_CC_VALUE : integer := 3; --! Position-Velocity-Current cascade
        constant BLDCJointMC_CascadedController_CTRL_MODE_CTRLVEL_VALUE : integer := 4; --! Velocity control
        constant BLDCJointMC_CascadedController_CTRL_MODE_CTRLPOS_VALUE : integer := 5; --! Position control
        constant BLDCJointMC_CascadedController_CTRL_MODE_CTRLPOSVEL_CC_VALUE : integer := 6; --! Position-Velocity cascade
        constant BLDCJointMC_CascadedController_CTRL_MODE_UNDEFINED_VALUE : integer := 255; --! Undefined value
    constant BLDCJointMC_CascadedController_POS_REF     : integer := 256;  --! Position Reference
    constant BLDCJointMC_CascadedController_VEL_REF     : integer := 258;  --! Velocity Reference
    constant BLDCJointMC_CascadedController_ACC_REF     : integer := 262;  --! Acceleration Reference
    constant BLDCJointMC_CascadedController_CUR_REF     : integer := 264;  --! Current Reference
    constant BLDCJointMC_CascadedController_ACTIVE_SATURATIONS : integer := 512;  --! Shows which saturaturations of control values are reached


    -- ----------------------- --
    -- MetaClass RegisterTypes --
    -- ----------------------- --

    constant BLDCJointMC_REGISTER_TYPES : reg_types_t(565 downto 0) := (
         0 => uint8,
         1 => uint8,
         2 => uint8,
         3 => uint8,
         4 => uint8,
         5 => uint8,
         6 => uint32,
         10 => uint8,
         14 => int16,
         16 => uint8,
         17 => uint8,
         18 => uint8,
         19 => uint8,
         20 => uint8,
         21 => uint8,
         22 => uint8,
         23 => uint32,
         24 => uint32,
         25 => uint32,
         26 => uint32,
         27 => int16,
         28 => int16,
         29 => int32,
         30 => int16,
         31 => int16,
         32 => uint32,
         36 => uint32,
         40 => uint32,
         44 => uint32,
         48 => uint32,
         52 => uint32,
         56 => uint32,
         60 => uint32,
         64 => uint32,
         68 => uint16,
         70 => uint32,
         74 => uint16,
         76 => uint16,
         78 => uint16,
         80 => uint16,
         82 => uint16,
         84 => uint16,
         86 => uint16,
         88 => int16,
         90 => int16,
         92 => uint32,
         96 => uint16,
         98 => uint8,
         256 => int16,
         258 => int32,
         262 => int16,
         264 => int16,
         266 => uint16,
         272 => int16,
         512 => uint8,
         516 => uint32,
         518 => uint32,
         540 => uint16,
         542 => uint16,
         550 => uint16,
         551 => int16,
         552 => int16,
         553 => int32,
         554 => int16,
         555 => uint16,
         556 => uint16,
         557 => int16,
         558 => int16,
         559 => int16,
         560 => int16,
         561 => int16,
         562 => int16,
         563 => int16,
         564 => int16,
         others => ERROR
    );

    constant BLDCJointMC_REGISTER_MEM_TYPES : reg_mem_types_t(565 downto 0) := (
         0 => prom,
         1 => ro,
         2 => ro,
         3 => ro,
         4 => ro,
         5 => ro,
         6 => prom,
         10 => prom,
         14 => prom,
         16 => prom,
         17 => prom,
         18 => prom,
         19 => prom,
         20 => prom,
         21 => prom,
         22 => prom,
         23 => prom,
         24 => prom,
         25 => ram,
         26 => ram,
         27 => prom,
         28 => prom,
         29 => prom,
         30 => prom,
         31 => prom,
         32 => prom,
         36 => prom,
         40 => prom,
         44 => prom,
         48 => prom,
         52 => prom,
         56 => prom,
         60 => prom,
         64 => prom,
         68 => prom,
         70 => prom,
         74 => prom,
         76 => prom,
         78 => prom,
         80 => prom,
         82 => prom,
         84 => prom,
         86 => prom,
         88 => prom,
         90 => prom,
         92 => prom,
         96 => prom,
         98 => prom,
         256 => ram,
         258 => ram,
         262 => ram,
         264 => ram,
         266 => ram,
         272 => ram,
         512 => ro,
         516 => ro,
         518 => ro,
         540 => ro,
         542 => ro,
         550 => ro,
         551 => ro,
         552 => ro,
         553 => ro,
         554 => ro,
         555 => ro,
         556 => ro,
         557 => ro,
         558 => ro,
         559 => ro,
         560 => ro,
         561 => ro,
         562 => ro,
         563 => ro,
         564 => ro,
         others => ERROR
    );

    constant BLDCJointMC_REGISTER_MEM_MAP : reg_mem_map_t(565 downto 0) := (
         0 => 0,
         1 => 0,
         2 => 1,
         3 => 2,
         4 => 3,
         5 => 4,
         6 => 1,
         10 => 5,
         14 => 6,
         16 => 8,
         17 => 9,
         18 => 10,
         19 => 11,
         20 => 12,
         21 => 13,
         22 => 14,
         23 => 15,
         24 => 19,
         25 => 0,
         26 => 4,
         27 => 23,
         28 => 25,
         29 => 27,
         30 => 31,
         31 => 33,
         32 => 35,
         36 => 39,
         40 => 43,
         44 => 47,
         48 => 51,
         52 => 55,
         56 => 59,
         60 => 63,
         64 => 67,
         68 => 71,
         70 => 73,
         74 => 77,
         76 => 79,
         78 => 81,
         80 => 83,
         82 => 85,
         84 => 87,
         86 => 89,
         88 => 91,
         90 => 93,
         92 => 95,
         96 => 99,
         98 => 101,
         256 => 8,
         258 => 10,
         262 => 14,
         264 => 16,
         266 => 18,
         272 => 20,
         512 => 5,
         516 => 6,
         518 => 10,
         540 => 14,
         542 => 16,
         550 => 18,
         551 => 20,
         552 => 22,
         553 => 24,
         554 => 28,
         555 => 30,
         556 => 32,
         557 => 34,
         558 => 36,
         559 => 38,
         560 => 40,
         561 => 42,
         562 => 44,
         563 => 46,
         564 => 48,
         others => 0
    );

    constant BLDCJointMC_MAX_REGISTER_ID : integer := 564;
    constant BLDCJointMC_MIN_REGISTER_ID : integer := 0;
    constant BLDCJointMC_PROM_REGISTER_MEMORY_SIZE : integer := 109;
    constant BLDCJointMC_RAM_REGISTER_MEMORY_SIZE  : integer := 29;
    constant BLDCJointMC_RO_REGISTER_MEMORY_SIZE   : integer := 57;

end;
