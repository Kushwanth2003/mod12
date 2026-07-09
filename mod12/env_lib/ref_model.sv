class ref_model;
	transaction wr_data,data2sb;
	
	logic [3:0] ref_data_out;
	
	mailbox #(transaction) wm2rm;
	mailbox #(transaction) rm2sb;

	function new(mailbox #(transaction) wm2rm,
	             mailbox #(transaction) rm2sb);
		this.wm2rm = wm2rm;
		this.rm2sb = rm2sb;
	endfunction:new

	// -------- FIXED REFERENCE LOGIC --------
	virtual task data_out_mod(transaction wr_data);
	begin
		if (wr_data.reset == 1)
			ref_data_out = 4'd0;
		else if (wr_data.load)
			ref_data_out = wr_data.data_in;
		else begin
			if (wr_data.mode == 1) begin
				if (ref_data_out == 4'd11)
					ref_data_out = 4'd0;
				else
					ref_data_out = ref_data_out + 1;
			end
			else begin
				if (ref_data_out == 4'd0)
					ref_data_out = 4'd11;
				else
					ref_data_out = ref_data_out - 1;
			end
		end
	end
	endtask:data_out_mod

	// -------- FIXED START TASK --------
	virtual task start();
		for (int i = 0; i < 10; i++) begin
			wm2rm.get(wr_data);
			data_out_mod(wr_data);
			wr_data.data_out = ref_data_out;
			data2sb=new wr_data;
			rm2sb.put(data2sb);
			//w_data.display("REFERENCE DATA");
		end
	endtask:start
endclass:ref_model

