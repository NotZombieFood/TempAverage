`timescale 1ns / 1ns

module test_top;

	// Inputs
	logic rst;
	logic clk;
	logic [8:0] temperatura;
	

	// Outputs
	logic [6:0] HEX_0;
	logic [6:0] HEX_1;
	logic [6:0] HEX_2;
	logic HEX_3;
	logic [6:0] HEX_6;
	logic [6:0] HEX_7;
	logic RW;
	logic EN;
	logic ON;
	logic [7:0] DATA;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.rst(rst),
		.clk(clk),
		.temperatura(temperatura),
		.HEX_0(HEX_0),
		.HEX_1(HEX_1),
		.HEX_2(HEX_2),
		.HEX_3(HEX_3),
		.HEX_6(HEX_6),
		.HEX_7(HEX_7),
		.RW(RW),
		.EN(EN),
		.RS(RS),
		.ON(ON)
	);

	initial begin
		// Initialize Inputs
		rst = 1;
		clk = 0;
		temperatura = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#20;
		rst = 0;
		#20
		rst = 1;
		
		temperatura = 25;
		
		

	end
	
	initial forever #10 clk = ~clk;
      
endmodule

