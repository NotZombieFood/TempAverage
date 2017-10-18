module Top(
input clk,
input rst,
input [8:0] temperature,
output [6:0] HEX_0,
output [6:0] HEX_1,
output [6:0] HEX_2,
output HEX_3, 
output [6:0] HEX_6,
output [6:0] HEX_7,
output RW,
output EN,
output RS,
output ON,
output [7:0] DATA
);

logic [5:0] segundos;
logic [6:0] num0;
logic [6:0] num1;
logic [6:0] num2;
logic [6:0] num6;
logic [6:0] num7;
logic [11:0] display_2;
logic [8:0] avrg;
logic [8:0] promedio_comp;
logic [8:0] promedio;
logic [5:0] addr;
logic [9:0] Data;
logic rw;
logic en;
logic rs;
logic on;
logic [7:0] data;
logic rst_LCD;
logic [8:0] signo;
logic [8:0] digito3;
logic [8:0] digito2;
logic [8:0] digito1;
logic [3:0] centenas;
logic [3:0] decenas;
logic [3:0] unidades;


assign RW = rw;
assign EN = en;
assign RS = rs;
assign ON = on;
assign DATA = data;

assign HEX_0 = num0;
assign HEX_1 = num1;
assign HEX_2 = num2;
assign HEX_6 = num6;
assign HEX_7 = num7;
assign display_2 = temperature [7:0];

Temperature temp1(
.rst(rst),
.clk(clk),
.temperatura(temperatura),
.avrg(avrg),
.o_seg(segundos),
.min(rst_LCD)
);

sevenSegment seg1(
.switch(segundos),
.num0(num6),
.num1(num7)
);

Display_12bits seg2(
.SW(display_2),
.HEX_0(num0),
.HEX_1(num1),
.HEX_2(num2)
);

assign HEX_3 = ~temperature [8];

Twos_Complement tw(
.A(avrg),
.B(promedio_comp)
);

separador sep(
.promedio(promedio),
.centenas(centenas),
.decenas (decenas),
.unidades (unidades)
);

always_comb begin
	if (avrg [8])
		promedio = promedio_comp;
	else
		promedio = avrg;
end

always_comb begin
	/*if (avrg< -40 | avrg>85 )begin
		signo = 9'h120;
		digito3 = 9'h145;
		digito2 = 9'h152;
		digito1 = 9'h152;
	end
	*/
	//else begin
		if (avrg [8])
			signo = 9'h12D;
		else begin
			signo = 9'h120;
		end
		digito3 = centenas + 304;
		digito2 = decenas + 304;
		digito1 = unidades + 304;
	//end
end

instrucciones ins(
.clk(clk),
.rst(~rst),
.signo(signo),
.digito3(digito3),
.digito2(digito2),
.digito1(digito1),
.addr(addr),
.rd_Data(Data)
);

LCD LCD(
.clk(clk),
.rst(~rst_LCD),
.data_mem(Data),
.DATA(data),
.address(addr),
.RW(rw),
.EN(en),
.RS(rs),
.ON(on),
);

endmodule 