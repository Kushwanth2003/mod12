class wr_monitor;
	virtual mod12if.WM wr_mon_if;
	transaction data2rm,mondata;
	mailbox #(transaction) wm2rm;
	function new(virtual mod12if.WM wr_mon_if,mailbox #(transaction) wm2rm);
		this.wr_mon_if=wr_mon_if;
		this.wm2rm=wm2rm;
		this.data2rm=new();
	endfunction:new
	
	virtual task monitor();
		@(wr_mon_if.wm_cb);
		begin
		data2rm.reset=wr_mon_if.wm_cb.reset;
		data2rm.load=wr_mon_if.wm_cb.load;
		data2rm.mode=wr_mon_if.wm_cb.mode;
		data2rm.data_in=wr_mon_if.wm_cb.data_in;
		data2rm.display("-------------- DATA FROM WRITE MONITOR--------------");
		end
	endtask:monitor

	virtual task start();
		fork
			for(int i=0;i<10;i++)
				begin
					monitor();
					mondata=new data2rm;
					wm2rm.put(mondata);

				end
		join_none
	endtask:start
endclass:wr_monitor
