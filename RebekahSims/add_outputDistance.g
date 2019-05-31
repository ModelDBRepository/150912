

function add_output
	create asc_file /output/plot_out
	setfield /output/plot_out   flush 1  leave_open 1 append 1 \
          float_format %0.6g
    useclock /output/plot_out 1
	addmsg /cell/soma /output/plot_out  SAVE Vm

	addmsg /cell/primdend1/volavg /output/plot_out SAVE meanValue 
	addmsg /cell/primdend2/volavg /output/plot_out SAVE meanValue
	addmsg /cell/primdend3/volavg /output/plot_out SAVE meanValue
	addmsg /cell/primdend4/volavg /output/plot_out SAVE meanValue

	addmsg /cell/secdend11/volavg /output/plot_out SAVE meanValue 
	addmsg /cell/secdend21/volavg /output/plot_out SAVE meanValue
	addmsg /cell/secdend31/volavg /output/plot_out SAVE meanValue
	addmsg /cell/secdend41/volavg /output/plot_out SAVE meanValue

	addmsg /cell/tertdend1_1/volavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend5_1/volavg /output/plot_out SAVE meanValue 
	addmsg /cell/tertdend9_1/volavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend13_1/volavg /output/plot_out SAVE meanValue

	addmsg /cell/tertdend1_2/volavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend5_2/volavg /output/plot_out SAVE meanValue 
	addmsg /cell/tertdend9_2/volavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend13_2/volavg /output/plot_out SAVE meanValue
end

/* copy into header.g file: 
call /output/plot_out OUT_OPEN
call /output/plot_out OUT_WRITE "time SomaVm prim1volavg prim2volavg prim3volavg prim4volavg sec11volavg sec21volavg sec31volavg sec41volavg tert1_1volavg tert5_1volavg tert9_1volavg tert13_1volavg tert1_2volavg tert5_2volavg tert9_2volavg tert13_2volavg" //header	
*/


