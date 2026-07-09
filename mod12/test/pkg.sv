package mod12_pkt;

   int number_of_transactions = 1;

  	 `include "transaction.sv"
 	 `include "generator.sv"
 	 `include "wr_driver.sv" 
 	 `include "wr_monitor.sv"
 	 `include "rd_monitor.sv"
	 `include "ref_model.sv"
	 `include "score_broad.sv"       
  	 `include "env.sv"
	 `include "test.sv"
endpackage