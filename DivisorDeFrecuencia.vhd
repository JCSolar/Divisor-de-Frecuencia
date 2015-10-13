----------------------------------------------------------------------------------
--Creado por: Juan Carlos Solar Coeto. 
--            Puebla, México
--            juan.carlos.sc3@gmail.com
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.NUMERIC_STD.ALL;


entity DivisorFrecuencia is
    Port ( CLK 		    : in   STD_LOGIC;
           RST 			 : in   STD_LOGIC;
           Salida			 : out  STD_LOGIC);
end DivisorFrecuencia;

architecture Behavioral of DivisorFrecuencia is

signal temp: STD_LOGIC;
signal contador: integer;

signal cuenta: integer;
signal cociente: integer;
signal mhz: integer;
signal frecuencia: integer;

								---Cociente = CLKdeEntrada/FrecuenciaDeseada, 
								---Cuenta = (Cociente / 2) -1


begin		
		
		process(cociente, mhz, frecuencia)
			begin
					mhz <= 100; 						--Frecuencia del reloj en Mhz.
					frecuencia <= 1; 					--Frecuencia de salida deseada en Hz.
					cociente <= (mhz*1000000)/(frecuencia);
					cuenta <= (cociente/2)-1;
			end process;
		

		DivisorFrecuencia: process (RST, CLK, cuenta) 
			begin
				
				if (RST = '1') then
					contador <= 0;
					temp <= '0';
				elsif rising_edge(CLK) then
								
						if (contador = cuenta) then
							temp <= NOT(temp);
							contador <= 0;
							else
							contador <= contador+1;
						end if;
				end if;
			end process;
     
	  
    Salida <= temp;

end Behavioral;


