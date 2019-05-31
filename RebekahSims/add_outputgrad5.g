

function add_output
	create asc_file /output/plot_out
	setfield /output/plot_out   flush 1  leave_open 1 append 1 \
          float_format %0.6g
    useclock /output/plot_out 1
	addmsg /cell/soma /output/plot_out  SAVE Vm
	
	addmsg /cell/primdend1/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/primdend2/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/primdend3/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/primdend4/Fluo5FVavg /output/plot_out SAVE meanValue

	addmsg /cell/secdend11/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/secdend21/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/secdend31/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/secdend41/Fluo5FVavg /output/plot_out SAVE meanValue

	addmsg /cell/tertdend1_1/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend5_1/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend9_1/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend13_1/Fluo5FVavg /output/plot_out SAVE meanValue

	addmsg /cell/tertdend1_2/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend5_2/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend9_2/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend13_2/Fluo5FVavg /output/plot_out SAVE meanValue

	addmsg /cell/tertdend1_3/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend5_3/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend9_3/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend13_3/Fluo5FVavg /output/plot_out SAVE meanValue

end

/* copy into file: 
call /output/plot_out OUT_OPEN
call /output/plot_out OUT_WRITE "time SomaVm prim1F5F prim2F5F prim3F5F prim4F5F sec11F5F sec21F5F sec31F5F sec41F5f tert1_1F5F tert5_1F5F tert9_1F5F tert13_1F5F tert1_2F5F tert5_2F5F tert9_2F5F tert13_2F5F tert1_3F5F tert5_3F5F tert9_3F5F tert13_3F5F" //header	
*/


