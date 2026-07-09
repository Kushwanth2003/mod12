class transaction;
	rand bit reset;
	rand bit load;
	rand bit mode;
	rand bit [3:0]data_in;
	logic [3:0]data_out;
	
	constraint c1{data_in inside {[0:11]};}
//	constraint c2{load dist{1:=80,1:=20};}
	constraint c3{mode dist{0:=90,1:=10};}
	constraint c4{reset dist{0:=70,1:=30};}

	function void display(input string s);
		$display("t=%0t,string:%s:reset=%0d,load=%0d,mode=%0d,data_in=%0d,data_out=%0d",$time,s,reset,load,mode,data_in,data_out);
	endfunction:display
	
	function void post_randomize();
		display("Randomize Data");
	endfunction:post_randomize
endclass:transaction