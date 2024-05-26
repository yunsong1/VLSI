library verilog;
use verilog.vl_types.all;
entity DWT is
    generic(
        w_in            : integer := 9;
        w_in_1          : integer := 25;
        y_out           : integer := 25;
        y_out_2         : integer := 40;
        c_in            : integer := 9
    );
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of w_in : constant is 1;
    attribute mti_svvh_generic_type of w_in_1 : constant is 1;
    attribute mti_svvh_generic_type of y_out : constant is 1;
    attribute mti_svvh_generic_type of y_out_2 : constant is 1;
    attribute mti_svvh_generic_type of c_in : constant is 1;
end DWT;
