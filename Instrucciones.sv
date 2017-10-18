module instrucciones #(
parameter NUM_REGS = 33,
parameter SIZE = 9
)
(
input clk,
input rst,
input [8:0] signo,
input [8:0] digito3,
input [8:0] digito2,
input [8:0] digito1,
input [5:0] addr,
output [8:0] rd_Data
);

logic [SIZE-1:0] rf [NUM_REGS-1:0];

   integer i;
	 always_ff @ (posedge clk) begin
      if (rst)
			for (i = 0; i < NUM_REGS-1; i = i + 1)
				rf[i] <= 9'h120;
		else  
				rf [5] = signo;
				rf [6] = digito3;
				rf [7] = digito2;
				rf [8] = digito1;
		  
	end
	
    assign rd_Data = rf[addr-5];

endmodule 