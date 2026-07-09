class generator;
	transaction gen_trans;
	transaction data2send;
	mailbox #(transaction) gen2wd;

	function new(mailbox #(transaction) gen2wd);
		this.gen2wd=gen2wd;
		this.gen_trans=new;
	endfunction:new

	virtual task start();
		fork
			begin
				//for(int i=0;i<12;i++)
					begin
						assert(gen_trans.randomize() with {gen_trans.load==0;});
						data2send=new gen_trans;
						gen2wd.put(data2send);
					end
			end
		join_none
	endtask:start
endclass:generator