class score_board;
	//event DONE;
	transaction rm_data;
	transaction rmon_data;
	mailbox #(transaction) rm2sb;
	mailbox #(transaction) rd2sb;
	
	function new(mailbox #(transaction) rm2sb,mailbox #(transaction) rd2sb);
			this.rd2sb=rd2sb;
			this.rm2sb=rm2sb;
	endfunction:new

	virtual task compare(transaction rmon_data,transaction rm_data);
		
		if(rmon_data.data_out==rm_data.data_out)
			$display("Data Matched");
		else
			$display("Data Mis Matched");
	
	endtask	:compare

	virtual task start();
		fork
			repeat(10)	
			begin
				$display("--------------------------SCOREBOARD------------------");
				rd2sb.get(rmon_data);
				rmon_data.display("READ MONITOR");
				rm2sb.get(rm_data);
				rm_data.display("REFERENCE MODEL");
				compare(rmon_data,rm_data);
			end
		join_none
	endtask	:start
endclass:score_board	

