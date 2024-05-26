library verilog;
use verilog.vl_types.all;
entity tb_FIR_src is
    generic(
        PERIOD          : integer := 10;
        w_in            : integer := 7;
        y_out           : integer := 20;
        c_in            : integer := 5;
        w_muti_y        : integer := 16;
        w_add_y         : integer := 20
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of PERIOD : constant is 1;
    attribute mti_svvh_generic_type of w_in : constant is 1;
    attribute mti_svvh_generic_type of y_out : constant is 1;
    attribute mti_svvh_generic_type of c_in : constant is 1;
    attribute mti_svvh_generic_type of w_muti_y : constant is 1;
    attribute mti_svvh_generic_type of w_add_y : constant is 1;
end tb_FIR_src;
