----------------------------------------------------------------------------------
--Creado por: Juan Carlos Solar Coeto. 
--            Puebla, México
--            juan.carlos.sc3@gmail.com
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;


entity DivisorFrecuencia is
	
	 Generic (
		   clk_fpga 	: integer := 100000000; --Frecuencia del reloj de entrada en Hz.
		   frec_salida  : integer := 1 --Frecuencia que se busca obtener en Hz
		  );
    
	 Port 	( 
		  CLK 	    : in   STD_LOGIC;
             	  RST 	    : in   STD_LOGIC;
             	  Salida    : out  STD_LOGIC
		);
			 
end DivisorFrecuencia;

architecture Behavioral of DivisorFrecuencia is

signal aux: STD_LOGIC;
signal contador: integer;

signal cuenta: integer;
signal razon: integer;

---Razón de Proporción = CLKdeEntrada/FrecuenciaDeseada 
---Cuenta = (Razón/2) - 1

begin	

	process(razon, RST, CLK)
		begin			
			razon <= (clk_fpga)/(frec_salida);
			cuenta <= (razon/2)-1;
	end process;
		

	DivisorFrecuencia: process (RST, CLK, cuenta) 
		begin
			if (RST = '1') then
				contador <= 0;
				aux <= '0';
			elsif rising_edge(CLK) then
				if (contador = cuenta) then
					aux <= NOT(aux);
					contador <= 0;
				else
					contador <= contador+1;
				end if;
			end if;
	end process;
     
    Salida <= aux;

end Behavioral;
