

function add_output
	create asc_file /output/plot_out
	setfield /output/plot_out   flush 1  leave_open 1 append 1 \
          float_format %0.6g
    useclock /output/plot_out 1
	addmsg /cell/soma /output/plot_out  SAVE Vm
	addmsg /cell/tertdend1_1 /output/plot_out SAVE Vm
	addmsg /cell/tertdend5_1 /output/plot_out SAVE Vm
	addmsg /cell/tertdend9_1 /output/plot_out SAVE Vm
	addmsg /cell/tertdend13_1 /output/plot_out SAVE Vm

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

	addmsg /cell/tertdend1_1/NMDApool /output/plot_out SAVE Ca
	addmsg /cell/tertdend5_1/NMDApool /output/plot_out SAVE Ca
	addmsg /cell/tertdend9_1/NMDApool /output/plot_out SAVE Ca
	addmsg /cell/tertdend13_1/NMDApool /output/plot_out SAVE Ca
	
	addmsg /cell/tertdend1_1/Lpool /output/plot_out SAVE Ca
	addmsg /cell/tertdend5_1/Lpool /output/plot_out SAVE Ca
	addmsg /cell/tertdend9_1/Lpool /output/plot_out SAVE Ca
	addmsg /cell/tertdend13_1/Lpool /output/plot_out SAVE Ca
	

/*
	addmsg /cell/tertdend1_1/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/tertdend5_1/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/tertdend9_1/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/tertdend13_1/fluorescence /output/plot_out SAVE ratio

	addmsg /cell/tertdend1_1/volavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend5_1/volavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend9_1/volavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend13_1/volavg /output/plot_out SAVE meanValue

	addmsg /cell/tertdend1_1/NR2A/GHK /output/plot_out SAVE Gk
	addmsg /cell/tertdend1_1/NR2A/block /output/plot_out SAVE Gk
	addmsg /cell/tertdend5_1/NR2A/GHK /output/plot_out SAVE Gk
	addmsg /cell/tertdend5_1/NR2A/block /output/plot_out SAVE Gk
	addmsg /cell/tertdend9_1/NR2A/GHK /output/plot_out SAVE Gk
	addmsg /cell/tertdend9_1/NR2A/block /output/plot_out SAVE Gk

	addmsg /cell/tertdend1_1/CaL12_channelGHK /output/plot_out SAVE Gk
	addmsg /cell/tertdend5_1/CaL12_channelGHK /output/plot_out SAVE Gk
	addmsg /cell/tertdend9_1/CaL12_channelGHK /output/plot_out SAVE Gk

	addmsg /cell/tertdend1_1/CaL13_channelGHK /output/plot_out SAVE Gk
	addmsg /cell/tertdend5_1/CaL13_channelGHK /output/plot_out SAVE Gk
	addmsg /cell/tertdend9_1/CaL13_channelGHK /output/plot_out SAVE Gk

	addmsg /cell/tertdend1_1/CaN_channelGHK /output/plot_out SAVE Gk
	addmsg /cell/tertdend5_1/CaN_channelGHK /output/plot_out SAVE Gk
	addmsg /cell/tertdend9_1/CaN_channelGHK /output/plot_out SAVE Gk

	addmsg /cell/tertdend1_1/CaT_channelGHK /output/plot_out SAVE Gk
	addmsg /cell/tertdend5_1/CaT_channelGHK /output/plot_out SAVE Gk
	addmsg /cell/tertdend9_1/CaT_channelGHK /output/plot_out SAVE Gk

	addmsg /cell/tertdend1_1/CaR_channelGHK /output/plot_out SAVE Gk
	addmsg /cell/tertdend5_1/CaR_channelGHK /output/plot_out SAVE Gk
	addmsg /cell/tertdend9_1/CaR_channelGHK /output/plot_out SAVE Gk
*/
end

/* copy into file: 
call /output/plot_out OUT_OPEN
call /output/plot_out OUT_WRITE "time SomaVm tert1Vm tert5Vm tert9Vm tert13Vm tert1Vavg tert5Vavg tert9Vavg tert13Vavg tert1CaMN tert5CaMN tert9CaMN tert13CaMN tert1CaMC tert5CaMC tert9CaMC tert13CaMC tert1NMDACa tert5NMDACa tert9NMDACa tert13NMDACa tert1LCa tert5LCa tert9LCa tert13LCa" //header	
*/


