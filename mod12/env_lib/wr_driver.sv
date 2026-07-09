class wr_driver;
	virtual mod12if.WD wr_drv_if;
	transaction data2duv;
	mailbox #(transaction) gen2wd;

	function new(virtual mod12if.WD wr_drv_if,mailbox #(transaction) gen2wd);
		this.wr_drv_if=wr_drv_if;
		this.gen2wd=gen2wd;
		data2duv=new();
	endfunction:new

	virtual task drive();
		begin
		@(wr_drv_if.wd_cb);
		begin
			wr_drv_if.wd_cb.load<=data2duv.load;
			wr_drv_if.wd_cb.mode<=data2duv.mode;
			wr_drv_if.wd_cb.data_in<=data2duv.data_in;
		end
		end
	endtask:drive

	virtual task start();
		fork
			begin
			@(wr_drv_if.wd_cb);
			wr_drv_if.wd_cb.reset<=1'b1;
		//	repeat(2)
			@(wr_drv_if.wd_cb);
			wr_drv_if.wd_cb.reset<=1'b0;end
			for(int i=0;i<10;i++)
				begin
					gen2wd.get(data2duv);
					drive();
					data2duv.display("WRITE DRIVER");
					
				end
		join_none
	endtask:start
endclass:wr_driver



	


