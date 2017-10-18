`timescale 1ns / 1ns

module test_temperature;

	// Inputs
	logic rst;
	logic clk;
	logic [7:0] temperatura;

	// Outputs
	logic [7:0] promedio;

	// Instantiate the Unit Under Test (UUT)
	Temperature uut (
		.rst(rst),
		.clk(clk),
		.temperatura(temperatura),
		.promedio(promedio)
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
		
		for(int i =0; i<1000;i++) begin
		temperatura = $urandom();
		#1000000000;
		end
		
		

	end
	
	initial forever #10 clk = ~clk;
      
endmodule

