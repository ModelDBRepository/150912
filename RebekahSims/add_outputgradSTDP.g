

function add_output
	create asc_file /output/plot_out
	setfield /output/plot_out   flush 1  leave_open 1 append 1 \
          float_format %0.6g
    useclock /output/plot_out 1
	addmsg /cell/soma /output/plot_out  SAVE Vm
		
	addmsg /cell/tertdend1_1/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend5_1/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend9_1/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend13_1/Fluo5FVavg /output/plot_out SAVE meanValue

	addmsg /cell/tertdend1_2/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend1_3/Fluo5FVavg /output/plot_out SAVE meanValue
	
	addmsg /cell/tertdend1_1/NMDApool /output/plot_out SAVE Ca
	addmsg /cell/tertdend1_1/Lpool /output/plot_out SAVE Ca
	addmsg /cell/tertdend5_1/NMDApool /output/plot_out SAVE Ca
	addmsg /cell/tertdend5_1/Lpool /output/plot_out SAVE Ca
	addmsg /cell/tertdend1_2/NMDApool /output/plot_out SAVE Ca
	addmsg /cell/tertdend1_2/Lpool /output/plot_out SAVE Ca

end

/* copy into file: 
call /output/plot_out OUT_OPEN
call /output/plot_out OUT_WRITE "time SomaVm tert1_1F5F tert5_1F5F tert9_1F5F tert13_1F5F tert1_2F5F tert1_3F5F tert1_1NMDACa tert1_1LCa tert5_1NMDACa tert5_1LCa tert1_2NMDACa tert1_2LCa" //header	
*/


