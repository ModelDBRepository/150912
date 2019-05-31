

function add_output
	create asc_file /output/plot_out
	setfield /output/plot_out   flush 1  leave_open 1 append 1 \
          float_format %0.6g
    useclock /output/plot_out 1
	addmsg /cell/soma /output/plot_out  SAVE Vm
	addmsg /cell/tertdend1_1 /output/plot_out SAVE Vm

	addmsg /cell/tertdend1_1/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend1_1/volavg /output/plot_out SAVE meanValue

	addmsg /cell/tertdend1_1/NMDApool /output/plot_out SAVE Ca
	addmsg /cell/tertdend1_1/Lpool /output/plot_out SAVE Ca

	addmsg /cell/tertdend1_1/NR2A/GHK /output/plot_out SAVE Gk
	addmsg /cell/tertdend1_1/NR2A/block /output/plot_out SAVE Gk

	addmsg /cell/tertdend1_1/CaL12_channel /output/plot_out SAVE X 
	addmsg /cell/tertdend1_1/CaL12_channel /output/plot_out SAVE Y
	addmsg /cell/tertdend1_1/CaL12_channel /output/plot_out SAVE Z

	addmsg /cell/tertdend1_1/CaL13_channel /output/plot_out SAVE X 
	addmsg /cell/tertdend1_1/CaL13_channel /output/plot_out SAVE Y
	addmsg /cell/tertdend1_1/CaL13_channel /output/plot_out SAVE Z
	
	addmsg /cell/tertdend1_1/CaR_channel /output/plot_out SAVE X 
	addmsg /cell/tertdend1_1/CaR_channel /output/plot_out SAVE Y
	addmsg /cell/tertdend1_1/CaR_channel /output/plot_out SAVE Z

end

/* copy into file: 
call /output/plot_out OUT_OPEN
call /output/plot_out OUT_WRITE "time SomaVm tert1Vm tert1Fluo5F tert1Vavg tert1NMDACa tert1LCa tert1NMDAGHKgk tert1NMDAblockgk tert1L12X tert1L12Y tert1L12Z tert1L13X tert1L13Y tert1L13Z tert1RX tert1RY tert1RZ" //header	
*/


