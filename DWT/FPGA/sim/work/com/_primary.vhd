library verilog;
use verilog.vl_types.all;
entity com is
    generic(
        w_in            : integer := 7;
        y_out           : integer := 20;
        c_in            : integer := 5
    );
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        x_c0            : in     vl_logic_vector;
        x_c1            : in     vl_logic_vector;
        x_c2            : in     vl_logic_vector;
        x_c3            : in     vl_logic_vector;
        c_0             : in     vl_logic_vector;
        c_1             : in     vl_logic_vector;
        c_2             : in     vl_logic_vector;
        c_3             : in     vl_logic_vector;
        y_com           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of w_in : constant is 1;
    attribute mti_svvh_generic_type of y_out : constant is 1;
    attribute mti_svvh_generic_type of c_in : constant is 1;
end com;
