class environment;
	virtual mod12if.WD wr_drv_if;
	virtual mod12if.WM wr_mon_if;
	virtual mod12if.RM rd_mon_if;

	function new(virtual mod12if.WD wr_drv_if,
		virtual mod12if.WM wr_mon_if,
		virtual mod12if.RM rd_mon_if);
		this.wr_drv_if=wr_drv_if;
		this.wr_mon_if=wr_mon_if;
		this.rd_mon_if=rd_mon_if;
	endfunction

	mailbox #(transaction) gen2wd=new();
	mailbox #(transaction) wm2rm=new();
	mailbox #(transaction) rm2sb=new();
	mailbox #(transaction) rd2sb=new();
	
	generator   gen_h;
	wr_driver   wr_drv_h;
	wr_monitor  wr_mon_h;
	rd_monitor  rd_mon_h;
	ref_model   ref_h;
	score_board  sb_h;
	
	virtual task build();
		gen_h=new(gen2wd);
		wr_drv_h=new(wr_drv_if,gen2wd);
		wr_mon_h=new(wr_mon_if,wm2rm);
		rd_mon_h=new(rd_mon_if,rd2sb);
		ref_h=new(wm2rm,rm2sb);
		sb_h=new(rm2sb,rd2sb);
	endtask:build
	
	/*task reset_dut();begin
		wr_drv_if.wd_cb.reset<=0;
	
	wr_drv_if.wd_cb.load<=0;
			wr_drv_if.wd_cb.up_down<=0;
		end
	endtask:reset_dut*/
	
	virtual task start();
		gen_h.start();
		wr_drv_h.start();
		wr_mon_h.start();
		#10;		
		rd_mon_h.start();
		ref_h.start();
		sb_h.start();
		#50; $finish;

	endtask:start
	
	////virtual task stop();
	//	wait(sb_h.DONE.triggered);
	//endtask

	virtual task run();
		//reset_dut();
		start();
		//stop();
		//sb_h.report();
	endtask:run
	
endclass:environment
