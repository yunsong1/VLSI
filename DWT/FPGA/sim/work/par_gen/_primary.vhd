library verilog;
use verilog.vl_types.all;
entity par_gen is
    generic(
        w_in            : integer := 15
    );
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        data_in         : in     vl_logic_vector;
        valid_wire      : out    vl_logic;
        data_out_0_wire : out    vl_logic_vector;
        data_out_1_wire : out    vl_logic_vector;
        data_out_2_wire : out    vl_logic_vector;
        data_out_3_wire : out    vl_logic_vector;
        data_out_4_wire : out    vl_logic_vector;
        data_out_5_wire : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of w_in : constant is 1;
end par_gen;
