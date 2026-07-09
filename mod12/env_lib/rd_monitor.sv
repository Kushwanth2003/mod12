class rd_monitor;
	virtual mod12if.RM rd_mon_if;
	transaction data2rm;
	transaction data2sb;
	
	
	mailbox #(transaction) rd2sb;
	
	function new(virtual mod12if.RM rd_mon_if,mailbox #(transaction) rd2sb);
		this.rd_mon_if=rd_mon_if;
		this.rd2sb=rd2sb;
		this.data2rm=new();
	endfunction:new
	
	virtual task monitor();
		@(rd_mon_if.rm_cb);
		begin
		data2rm.data_out=rd_mon_if.rm_cb.data_out;
		//data2rm.display("from read monitor");
		end
		
	endtask:monitor
	
	virtual task start();
		fork
			repeat(10)
				begin
					monitor();
					data2sb=new data2rm;
					rd2sb.put(data2sb);
			                data2sb.display("from read monitor");

				end
		join_none
	endtask:start
endclass:rd_monitor	
