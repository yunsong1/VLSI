library verilog;
use verilog.vl_types.all;
entity tb_par_gen is
    generic(
        PERIOD          : integer := 10;
        w_in            : integer := 15
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of PERIOD : constant is 1;
    attribute mti_svvh_generic_type of w_in : constant is 1;
end tb_par_gen;
