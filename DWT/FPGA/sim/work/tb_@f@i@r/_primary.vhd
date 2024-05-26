library verilog;
use verilog.vl_types.all;
entity tb_FIR is
    generic(
        PERIOD          : integer := 10;
        w_in            : integer := 5;
        y_out           : integer := 12;
        c_in            : integer := 3
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of PERIOD : constant is 1;
    attribute mti_svvh_generic_type of w_in : constant is 1;
    attribute mti_svvh_generic_type of y_out : constant is 1;
    attribute mti_svvh_generic_type of c_in : constant is 1;
end tb_FIR;
