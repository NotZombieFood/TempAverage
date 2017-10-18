module FSM_Avrg (
input rst,
input clk,
input second,
input minute,
output logic en_timer,
output logic rst_timer,
output logic en_avrg,
output logic rst_avrg,
output logic rst_segundos
);

enum {IDLE, RST, WAIT_SEC, SEC, AVRG} state, nextstate;

// Transición de estado
always_ff @ (posedge clk) begin
	if (rst)
		state = IDLE;
	else
		state = nextstate;
end 

//Next_state
always_comb begin
	if (rst)
		nextstate = IDLE;
	else
		case (state)
			IDLE:
				nextstate = RST;
			RST:
				nextstate = WAIT_SEC;
			WAIT_SEC: if (second)
					nextstate = SEC;
				else 
					nextstate = WAIT_SEC;
			SEC: if (minute)
					nextstate = AVRG;
				else 
					nextstate = WAIT_SEC;
			AVRG:
				nextstate = RST;
			default: nextstate = IDLE;
		endcase
end 

//Salidas
always_comb begin
	if (rst) begin
		en_timer = 0;
		rst_timer = 1;
		en_avrg = 0;
		rst_avrg = 1;
		rst_segundos = 1;
	end
	else
		case (state)
			IDLE: begin
				en_timer = 0;
				rst_timer = 1;
				en_avrg = 0;
				rst_avrg = 1;
				rst_segundos = 1;
			end
			RST: begin
				en_timer = 0;
				rst_timer = 1;
				en_avrg = 0;
				rst_avrg = 0;
				rst_segundos = 1;
			end
			WAIT_SEC: begin
				en_timer = 1;
				rst_timer = 0;
				en_avrg = 0;
				rst_avrg = 0;
				rst_segundos = 0;
			end
			SEC: begin
				en_timer = 1;
				rst_timer = 0;
				en_avrg = 0;
				rst_avrg = 0;
				rst_segundos = 1;
			end
			AVRG: begin
				en_timer = 1;
				rst_timer = 0;
				en_avrg = 1;
				rst_avrg = 0;
				rst_segundos = 0;
			end
			default: begin
				en_timer = 0;
				rst_timer = 1;
				en_avrg = 0;
				rst_avrg = 1;
				rst_segundos = 1;
			end
		endcase
end

endmodule 