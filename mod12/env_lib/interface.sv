
interface mod12if(input bit clock);
	logic reset,load,mode;
	logic [3:0]data_in;
	logic [3:0]data_out;

clocking wd_cb@(posedge clock);
default input #1 output #1;
	output reset;
	output load;
	output mode;
	output data_in;
endclocking:wd_cb

clocking wm_cb@(posedge clock);
default input #1 output #1;
	input reset;
	input load;
	input mode;
	input data_in;
endclocking:wm_cb

clocking rm_cb@(posedge clock);
default input #1 output #1;
	input data_out;
endclocking:rm_cb

modport WD (clocking wd_cb);

modport WM (clocking wm_cb);

modport RM (clocking rm_cb);

endinterface:mod12if

