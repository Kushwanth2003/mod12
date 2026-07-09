module top();
	 import mod12_pkt::*;  
	parameter cycle=10;
	reg clock;
	mod12if DUV_IF(clock);
	test test_h;
	mod_12_data_counter MOD12(.clock(clock),.reset(DUV_IF.reset),.load(DUV_IF.load),.mode(DUV_IF.mode),.data_in(DUV_IF.data_in),.data_out(DUV_IF.data_out));
	initial
		 begin
			test_h=new(DUV_IF,DUV_IF,DUV_IF);
			test_h.build_and_run();
		end
	initial
		 begin
			clock=1'b0;
			forever #(cycle/2) clock=~clock;
		end
endmodule:top