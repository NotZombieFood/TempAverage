module FSM_SUM(
input rst,
input clk,
input sec,
output logic en_sum,
output logic rst_sum
);

enum {IDLE, WAIT, SUM} state, nextstate;

//Transición de estado
always_ff @ (posedge clk) begin
	if (rst)
		state <= IDLE;
	else 
		state <= nextstate;
end

//Siguiente estado
always_comb begin
	if (rst)
		nextstate = IDLE;
	else
		case(state)
			IDLE: 
				nextstate = WAIT;
			WAIT: if(sec)
				nextstate = SUM;
			else 
				nextstate = WAIT;
			SUM:
				nextstate = WAIT;
			default: nextstate = IDLE;
		endcase
end

//Salidas
always_comb begin
	if (rst) begin
		en_sum = 0;
		rst_sum = 1;
	end
	else
		case (state)
			IDLE: begin
				en_sum = 0;
				rst_sum = 1;
			end
			WAIT: begin
				en_sum= 0;
				rst_sum = 0;
			end
			SUM: begin
				en_sum = 1;
				rst_sum = 0;
			end
			default: begin
				en_sum = 0;
				rst_sum = 1;
			end
		endcase
end

endmodule 