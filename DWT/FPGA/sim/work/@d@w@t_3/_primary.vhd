library verilog;
use verilog.vl_types.all;
entity DWT_3 is
    generic(
        w_in            : integer := 9;
        y_out           : integer := 25;
        c_in            : integer := 9
    );
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        Lo_D_up_valid   : in     vl_logic;
        Lo_R_up_y_k     : in     vl_logic_vector;
        Lo_R1_c_y_k     : out    vl_logic_vector;
        Lo_R1_valid     : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of w_in : constant is 1;
    attribute mti_svvh_generic_type of y_out : constant is 1;
    attribute mti_svvh_generic_type of c_in : constant is 1;
end DWT_3;
