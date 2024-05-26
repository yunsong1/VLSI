library verilog;
use verilog.vl_types.all;
entity data_gen is
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        valid           : out    vl_logic;
        data            : out    vl_logic_vector(8 downto 0)
    );
end data_gen;
