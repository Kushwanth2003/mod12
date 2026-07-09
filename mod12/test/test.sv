class test;
	virtual mod12if.WD wr_drv_if;
	virtual mod12if.WM wr_mon_if;
	virtual mod12if.RM rd_mon_if;

	environment env_h;

	function new(virtual mod12if.WD wr_drv_if,
		virtual mod12if.WM wr_mon_if,
		virtual mod12if.RM rd_mon_if);
		this.wr_drv_if=wr_drv_if;
		this.wr_mon_if=wr_mon_if;
		this.rd_mon_if=rd_mon_if;
		env_h=new(wr_drv_if,wr_mon_if,rd_mon_if);
	endfunction:new

	virtual task build_and_run();
		begin
			//number_of_transactions=10;
			env_h.build();
			env_h.run();
			
		end
	endtask:build_and_run
endclass:test