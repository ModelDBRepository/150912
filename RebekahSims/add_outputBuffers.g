

function add_output
	create asc_file /output/plot_out
	setfield /output/plot_out   flush 1  leave_open 1 append 1 \
          float_format %0.6g
    useclock /output/plot_out 1
	addmsg /cell/soma /output/plot_out  SAVE Vm
	
	addmsg /cell/tertdend1_1/volavg /output/plot_out SAVE meanValue 
	addmsg /cell/tertdend5_1/volavg /output/plot_out SAVE meanValue 
	addmsg /cell/tertdend9_1/volavg /output/plot_out SAVE meanValue 
	addmsg /cell/tertdend13_1/volavg /output/plot_out SAVE meanValue

	addmsg /cell/tertdend1_1/Ca_difshell_1CaMN /output/plot_out SAVE Bbound
	addmsg /cell/tertdend5_1/Ca_difshell_1CaMN /output/plot_out SAVE Bbound
	addmsg /cell/tertdend9_1/Ca_difshell_1CaMN /output/plot_out SAVE Bbound
	addmsg /cell/tertdend13_1/Ca_difshell_1CaMN /output/plot_out SAVE Bbound

	addmsg /cell/tertdend1_1/Ca_difshell_1CaMC /output/plot_out SAVE Bbound
	addmsg /cell/tertdend5_1/Ca_difshell_1CaMC /output/plot_out SAVE Bbound
	addmsg /cell/tertdend9_1/Ca_difshell_1CaMC /output/plot_out SAVE Bbound
	addmsg /cell/tertdend13_1/Ca_difshell_1CaMC /output/plot_out SAVE Bbound

	addmsg /cell/tertdend1_1/Ca_difshell_1calbindin /output/plot_out SAVE Bbound
	addmsg /cell/tertdend5_1/Ca_difshell_1calbindin /output/plot_out SAVE Bbound
	addmsg /cell/tertdend9_1/Ca_difshell_1calbindin /output/plot_out SAVE Bbound
	addmsg /cell/tertdend13_1/Ca_difshell_1calbindin /output/plot_out SAVE Bbound

end

/* copy into file: 
call /output/plot_out OUT_OPEN
call /output/plot_out OUT_WRITE "time SomaVm tert1volavg tert5volavg tert9volavg tert13volavg tert1CaMN tert5CaMN tert9CaMN tert13CaMN tert1CaMC tert5CaMC tert9CaMC tert13CaMC tert1cb tert5cb tert9cb tert13cb" //header	
*/

