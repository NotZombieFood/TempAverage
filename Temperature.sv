module Temperature (
input rst,
input clk,
input [8:0] temperatura,
output logic [8:0] avrg,
output [5:0] o_seg,
output min
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
logic [16:0] suma;
logic [28:0] timer;
logic [5:0] segundos;
logic[7:0] test;
logic [16:0] average;

assign test = temperatura [7:0];
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
		timer <= 0;
		segundos <= 0;
		minute <= 0;
		second <= 0;
	end
	else if (rst_segundos) begin
		timer <= 0;
		segundos <= segundos;
		minute <= 0;
		second <= 0;
	end
	else if (en_timer) begin
		if (timer >= 50000000) begin
			timer <= 0;
			segundos <= segundos +1;
			minute <= 0;
			second <= 1;
		end
		else if (segundos >= 60) begin
			timer <= 0;
			segundos <= 0;
			minute <= 1;
			second <= 1;
		end
		else begin
			timer <= timer + 1;
			segundos <= segundos;
			minute <= 0;
			second <= 0;
		end
	end
end

//Reg_sum
always_ff @ (posedge clk) begin
	if (rst_sum)
		suma <= 0;
	else if (minute)begin
		average <= suma;
		suma <= 0;
		end
	else if (en_sum)
		if ( temperatura [8] == 0 )
			suma <= suma + temperatura[7:0];
		else
			suma <= suma - temperatura[7:0];
end

//Reg_avrg
always_ff @ (posedge clk) begin
	if (rst_avrg)
		avrg <= 0;
	else if (en_avrg)
		avrg <= average >>> 6;
end

assign o_seg=segundos;
assign min = minute;
endmodule 