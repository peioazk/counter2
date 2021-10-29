--+--------------------------------------------------------------------------------------------------------------------+
--|  File: tb_counter.vhd
--|  Project: counter
--|  Description: Test bench for counter module.
--|
--+--------------------------------------------------------------------------------------------------------------------+
--+-----------------------------------------------------------------------------+
--|									LIBRARIES									|
--+-----------------------------------------------------------------------------+
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--
use std.textio.all;
use ieee.std_logic_textio.all;

--+-----------------------------------------------------------------------------+
--|									ENTITY   									|
--+-----------------------------------------------------------------------------+
entity tb_counter2 is
end tb_counter2;

architecture behavior of tb_counter2 is
--+-----------------------------------------------------------------------------+
--|									COMPONENTS									|
--+-----------------------------------------------------------------------------+
--+-----------------------------------------------------------------------------+
--|									SIGNALS   									|
--+-----------------------------------------------------------------------------+
    -- cnt_upld/cnt_dwld
    signal clk    : std_logic := '0';
    signal rst    : std_logic := '0';
    signal enable : std_logic := '0';
    signal q      : std_logic_vector(7 downto 0) := (others => '0');

    procedure printmsg(msg : string) is
		variable l : line;
	begin
        write(l, msg);
        writeline(output, l);
	end printmsg;

begin
    --+-------------------------------------------------------------------------+
    --|  DUT: Component instances												|
    --+-------------------------------------------------------------------------+
    u0: entity work.counter2
        generic map(size => 8)
    port map (
        clk_i  => clk,
        arst_i => rst,
        en_i   => enable,
        q_o    => q
    );

    --+-----------------------------------------+
	--|  RST/LD/ENABLE         					|
	--+-----------------------------------------+
    rst_P: process
        variable l1 : line;
    begin
        write(l1, string'("Start Simulation"));
        writeline(output, l1);
        wait for 100 ns;
        printmsg("Set Reset");
        rst <= '1';
        enable <= '0';
        wait for 100 ns;
        printmsg("Clear Reset");
        rst <= '0';
        wait for 100 ns;
        printmsg("Enable count");
        enable <= '1';
        printmsg("End rst process");
        wait;
    end process rst_P;

    --+-----------------------------------------+
	--|  CLK                   					|
	--+-----------------------------------------+
    clk_P: process
    begin
        printmsg("Start Clock");
        clk_l: for i in 0 to 100 loop
            clk <= '0';
            wait for 20 ns;
            clk <= '1';
            wait for 20 ns;
        end loop clk_l;
        printmsg("End Clock process");
        wait;
    end process clk_P;

end behavior;
