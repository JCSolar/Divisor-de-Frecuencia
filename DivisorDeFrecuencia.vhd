----------------------------------------------------------------------------------
--Creado por: Juan Carlos Solar Coeto. 
--            Puebla, México
--            juan.carlos.sc3@gmail.com
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity DivisorFrecuencia is
	
	 Generic (
		  FREQ_IN		: INTEGER := 100000000; --Frecuencia del reloj de ENTRADA en Hz. Valor modificable.
		  FREQ_OUT		: INTEGER := 1 --Frecuencia que se desea obtener de SALIDA en Hz. Valor modificable.
		 );
    
	 Port 	(
		  clk_in		: in   STD_LOGIC; --Señal de reloj de entrada
             	  rst			: in   STD_LOGIC; --Botón Reset
             	  clk_out		: out  STD_LOGIC  --Señal de reloj de salida
		 );
			 
end DivisorFrecuencia;


architecture Behavioral of DivisorFrecuencia is

signal aux: STD_LOGIC;
signal contador: INTEGER;
signal razon: INTEGER;
signal cuenta: INTEGER;

---Razón de Proporción = CLKdeEntrada/FrecuenciaDeseada 
---Cuenta = (Razón/2) - 1

begin	

	process (razon, rst, clk_in) --Proceso que calcula el número de ciclos que se deben contar para obtener
				     -- frecuencia deseada.
		begin			
			razon <= (FREQ_IN)/(FREQ_OUT);
			cuenta <= (razon/2)-1;
	end process;
		

	process (rst, clk_in, cuenta) --Proceso divisor de frecuencia asíncrono.
		begin
			if (rst = '1') then
				contador <= 0;
				aux <= '0';
			elsif rising_edge(clk_in) then
				if (contador = cuenta) then
					aux <= NOT(aux);
					contador <= 0;
				else
					contador <= contador+1;
				end if;
			end if;
	end process;
     
   clk_out <= aux;

end Behavioral;
