library verilog;
use verilog.vl_types.all;
entity upsample is
    generic(
        w_in_1          : integer := 25;
        y_out_2         : integer := 40
    );
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        Lo_D2_down_valid: in     vl_logic;
        Lo_D2_y_down    : in     vl_logic_vector;
        Lo_D2_y_up      : out    vl_logic_vector;
        Lo_D2_up_valid  : out    vl_logic;
        up_clk          : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of w_in_1 : constant is 1;
    attribute mti_svvh_generic_type of y_out_2 : constant is 1;
end upsample;
