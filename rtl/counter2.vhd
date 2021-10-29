--+--------------------------------------------------------------------------------------------------------------------+
--|  File: counter2.vhd
--|  Project: counter2
--|  Description: Example of counter using components library.
--|
--+--------------------------------------------------------------------------------------------------------------------+
--+-----------------------------------------------------------------------------+
--|									LIBRARIES									|
--+-----------------------------------------------------------------------------+
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

library paulib;
use paulib.paulib_pkg.all;

--+-----------------------------------------------------------------------------+
--|								ENTITY & ARCHITECTURE							|
--+-----------------------------------------------------------------------------+
entity counter2 is
	generic(size : integer := 8);
port (
	clk_i  : in std_logic;
	arst_i : in std_logic;
    en_i   : in std_logic;
   	q_o    : out std_logic_vector(size-1 downto 0)
);
end counter2;

architecture rtl of counter2 is
    --+-----------------------------------------------------------------------------+
    --|									SIGNALS   									|
    --+-----------------------------------------------------------------------------+
    signal q    : std_logic_vector(size-1 downto 0);
begin
    uu1: cnt port map (clk_i => clk_i, arst_i => arst_i, en_i => en_i, q_o => q);

    q_o <= q;
end rtl;
