module Temperature (
input rst,
input clk,
input [7:0] temperatura,
output [7:0] promedio,
output seg_p,
output min_p
);

logic rst_timer;
logic rst_segundos;
logic rst_sum;
logic rst_avrg;
logic en_timer;
logic en_avrg;
logic minute;
logic second;
logic en_sum;
logic [25:0] suma;
logic [25:0] timer;
logic [5:0] segundos; 
logic [7:0] avrg;

FSM_SUM fsm_sum (
.rst(~rst),
.clk(clk),
.sec(second),
.en_sum(en_sum),
.rst_sum(rst_sum)
);

FSM_Avrg fsm_avrg (
.rst(~rst),
.clk(clk),
.second(second),
.minute(minute),
.en_timer(en_timer),
.rst_timer(rst_timer),
.en_avrg(en_avrg),
.rst_avrg(rst_avrg),
.rst_segundos(rst_segundos)
);

//Timer  50,000,000
always_ff @ (posedge clk) begin
	if (rst_timer) begin
		timer = 0;
		segundos = 0;
		minute = 0;
		second = 0;
	end
	else if (rst_segundos) begin
		timer = 0;
		segundos = segundos;
		minute = 0;
		second = 0;
	end
	else if (en_timer) begin
		if (timer >= 500) begin
			timer = 0;
			segundos = segundos +1;
			minute = 0;
			second = 1;
		end
		else if (segundos >= 60) begin
			timer = 0;
			segundos = 0;
			minute = 1;
			second = 1;
		end
		else begin
			timer = timer + 1;
			segundos = segundos;
			minute = 0;
			second = 0;
		end
	end
end

//Reg_sum
always_ff @ (posedge clk) begin
	if (rst_sum)
		suma = 0;
	else if (en_sum)
		suma = suma + temperatura;
end

//Reg_avrg
always_ff @ (posedge clk) begin
	if (rst_avrg)
		avrg = 0;
	else if (en_avrg)
		avrg = suma >>> 4;
end

assign seg_p = second;
assign min_p = minute; 

endmodule 