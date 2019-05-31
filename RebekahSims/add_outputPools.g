

function add_output
	create asc_file /output/plot_out
	setfield /output/plot_out   flush 1  leave_open 1 append 1 \
          float_format %0.6g
    useclock /output/plot_out 1
	addmsg /cell/soma /output/plot_out  SAVE Vm
	
	addmsg /cell/tertdend1_1/allpool /output/plot_out SAVE Ca
	addmsg /cell/tertdend5_1/allpool /output/plot_out SAVE Ca
	addmsg /cell/tertdend9_1/allpool /output/plot_out SAVE Ca
	addmsg /cell/tertdend13_1/allpool /output/plot_out SAVE Ca

	addmsg /cell/tertdend1_1/volavg /output/plot_out SAVE meanValue 
	addmsg /cell/tertdend5_1/volavg /output/plot_out SAVE meanValue 
	addmsg /cell/tertdend9_1/volavg /output/plot_out SAVE meanValue 
	addmsg /cell/tertdend13_1/volavg /output/plot_out SAVE meanValue

	addmsg /cell/tertdend1_1/Ca_difshell_1 /output/plot_out SAVE C
	addmsg /cell/tertdend5_1/Ca_difshell_1 /output/plot_out SAVE C
	addmsg /cell/tertdend9_1/Ca_difshell_1 /output/plot_out SAVE C
	addmsg /cell/tertdend13_1/Ca_difshell_1 /output/plot_out SAVE C
/*
	addmsg /cell/tertdend1_1/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/tertdend5_1/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/tertdend9_1/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/tertdend13_1/fluorescence /output/plot_out SAVE ratio
*/
	addmsg /cell/tertdend1_1/NMDApool /output/plot_out SAVE Ca
	addmsg /cell/tertdend5_1/NMDApool /output/plot_out SAVE Ca
	addmsg /cell/tertdend9_1/NMDApool /output/plot_out SAVE Ca
	addmsg /cell/tertdend13_1/NMDApool /output/plot_out SAVE Ca

end

/* copy into file: 
call /output/plot_out OUT_OPEN
call /output/plot_out OUT_WRITE "time SomaVm tert1pool tert5pool tert9pool tert13pool tert1volavg tert5volavg tert9volavg tert13volavg tert1dif1 tert5dif1 tert9dif1 tert13dif1 tert1NMDA tert5NMDA tert9NMDA tert13NMDA" //header	
//call /output/plot_out OUT_WRITE "time SomaVm tert1pool tert5pool tert9pool tert13pool tert1volavg tert5volavg tert9volavg tert13volavg tert1dif1 tert5dif1 tert9dif1 tert13dif1 tert1F2 tert5F2 tert9F2 tert13F2 tert1NMDA tert5NMDA tert9NMDA tert13NMDA" //header	
*/


