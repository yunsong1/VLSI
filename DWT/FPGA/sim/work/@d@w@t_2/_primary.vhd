library verilog;
use verilog.vl_types.all;
entity DWT_2 is
    generic(
        w_in            : integer := 9;
        y_out           : integer := 25;
        c_in            : integer := 9
    );
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        Lo_D_down_valid : in     vl_logic;
        Lo_D_down_y_k   : in     vl_logic_vector;
        Hi_D2_c_y_6k    : out    vl_logic_vector;
        Hi_D2_c_y_6k_1  : out    vl_logic_vector;
        Hi_D2_c_y_6k_2  : out    vl_logic_vector;
        Hi_D2_c_y_6k_3  : out    vl_logic_vector;
        Hi_D2_c_y_6k_4  : out    vl_logic_vector;
        Hi_D2_c_y_6k_5  : out    vl_logic_vector;
        Hi_D2_valid     : out    vl_logic;
        Lo_D2_c_y_6k    : out    vl_logic_vector;
        Lo_D2_c_y_6k_1  : out    vl_logic_vector;
        Lo_D2_c_y_6k_2  : out    vl_logic_vector;
        Lo_D2_c_y_6k_3  : out    vl_logic_vector;
        Lo_D2_c_y_6k_4  : out    vl_logic_vector;
        Lo_D2_c_y_6k_5  : out    vl_logic_vector;
        Lo_D2_valid     : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of w_in : constant is 1;
    attribute mti_svvh_generic_type of y_out : constant is 1;
    attribute mti_svvh_generic_type of c_in : constant is 1;
end DWT_2;
