library verilog;
use verilog.vl_types.all;
entity tb_DWT_1 is
    generic(
        PERIOD          : integer := 10;
        w_in            : integer := 9;
        y_out           : integer := 25;
        c_in            : integer := 9
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of PERIOD : constant is 1;
    attribute mti_svvh_generic_type of w_in : constant is 1;
    attribute mti_svvh_generic_type of y_out : constant is 1;
    attribute mti_svvh_generic_type of c_in : constant is 1;
end tb_DWT_1;
