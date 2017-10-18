module Twos_Complement(
    input [8:0] A,
    output [8:0] B
    );
	 
	 assign B = ~A + 1;
endmodule
