library verilog;
use verilog.vl_types.all;
entity downsample is
    generic(
        y_out           : integer := 25
    );
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        Hi_D_c_y_6k     : in     vl_logic_vector;
        Hi_D_c_y_6k_1   : in     vl_logic_vector;
        Hi_D_c_y_6k_2   : in     vl_logic_vector;
        Hi_D_c_y_6k_3   : in     vl_logic_vector;
        Hi_D_c_y_6k_4   : in     vl_logic_vector;
        Hi_D_c_y_6k_5   : in     vl_logic_vector;
        Hi_D_valid      : in     vl_logic;
        Lo_D_c_y_6k     : in     vl_logic_vector;
        Lo_D_c_y_6k_1   : in     vl_logic_vector;
        Lo_D_c_y_6k_2   : in     vl_logic_vector;
        Lo_D_c_y_6k_3   : in     vl_logic_vector;
        Lo_D_c_y_6k_4   : in     vl_logic_vector;
        Lo_D_c_y_6k_5   : in     vl_logic_vector;
        Lo_D_valid      : in     vl_logic;
        Hi_D_y_down     : out    vl_logic_vector;
        Hi_D_down_valid : out    vl_logic;
        Lo_D_y_down     : out    vl_logic_vector;
        Lo_D_down_valid : out    vl_logic;
        down_clk        : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of y_out : constant is 1;
end downsample;
