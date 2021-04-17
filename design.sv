module adder( clk,
			  in1,
			  in2,
			  out,
              rst
			);
	parameter N=4;
	
	input clk;
    input rst;
	
	input [N-1:0] in1;
	input [N-1:0] in2;
	
	output [N:0] out;
  reg [N:0] temp;	
  
  assign out=(rst==1)?temp:(in1+in2);
  
  always @(posedge clk or posedge rst)
      if(rst==1)
        begin
          temp=0;
        end
		
endmodule