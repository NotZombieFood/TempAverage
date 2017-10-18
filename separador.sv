module separador(
input [8:0] promedio,
output logic [3:0] centenas,
output logic [3:0] decenas,
output logic [3:0] unidades
);

logic [3:0] int_decenas;

always_comb begin
	if (promedio >= 900) begin
		centenas = 9;
		int_decenas = promedio-900;
	end
	else if (promedio >= 800) begin
		centenas = 8;
		int_decenas = promedio-800;
	end
	else if (promedio >= 700) begin
		centenas = 7;
		int_decenas = promedio-700;
	end
	else if (promedio >= 600) begin
		centenas = 6;
		int_decenas = promedio-600;
	end
	else if (promedio >= 500) begin
		centenas = 5;
		int_decenas = promedio-500;
	end
	else if (promedio >= 400) begin
		centenas = 4;
		int_decenas = promedio-400;
	end
	else if (promedio >= 300) begin
		centenas = 3;
		int_decenas = promedio-300;
	end
	else if (promedio >= 200) begin
		centenas = 2;
		int_decenas = promedio-200;
	end
	else if (promedio >= 100) begin
		centenas = 1;
		int_decenas = promedio-100;
	end
	else begin
		centenas = 0;
		int_decenas = promedio;
	end
end 

always_comb begin
	if (int_decenas >= 90) begin
		decenas = 9;
		unidades = int_decenas - 90;
	end
	else if (int_decenas >= 80) begin
		decenas = 8;
		unidades = int_decenas - 80;
	end
	else if (int_decenas >= 70) begin
		decenas = 7;
		unidades = int_decenas - 70;
	end
	else if (int_decenas >= 60) begin
		decenas = 6;
		unidades = int_decenas - 60;
	end
	else if (int_decenas >= 50) begin
		decenas = 5;
		unidades = int_decenas - 50;
	end
	else if (int_decenas >= 40) begin
		decenas = 4;
		unidades = int_decenas - 40;
	end
	else if (int_decenas >= 30) begin
		decenas = 3;
		unidades = int_decenas - 30;
	end
	else if (int_decenas >= 20) begin
		decenas = 2;
		unidades = int_decenas - 20;
	end
	else if (int_decenas >= 10) begin
		decenas = 1;
		unidades = int_decenas - 10;
	end
	else begin
		decenas = 0;
		unidades = int_decenas;
	end
end 

endmodule 