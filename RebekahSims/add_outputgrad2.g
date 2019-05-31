

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
/*
	addmsg /cell/tertdend1_1/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend5_1/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend9_1/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend13_1/Fluo5FVavg /output/plot_out SAVE meanValue

	addmsg /cell/tertdend1_1/NMDApool /output/plot_out SAVE Ca
	addmsg /cell/tertdend5_1/NMDApool /output/plot_out SAVE Ca
	addmsg /cell/tertdend9_1/NMDApool /output/plot_out SAVE Ca
	addmsg /cell/tertdend13_1/NMDApool /output/plot_out SAVE Ca
	
	addmsg /cell/tertdend1_1/Lpool /output/plot_out SAVE Ca
	addmsg /cell/tertdend5_1/Lpool /output/plot_out SAVE Ca
	addmsg /cell/tertdend9_1/Lpool /output/plot_out SAVE Ca
	addmsg /cell/tertdend13_1/Lpool /output/plot_out SAVE Ca
*/
	addmsg /cell/tertdend1_1/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/tertdend5_1/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/tertdend9_1/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/tertdend13_1/fluorescence /output/plot_out SAVE ratio
/*
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


	addmsg /cell/tertdend1_1/KAf_channel /output/plot_out SAVE Gk
	addmsg /cell/tertdend5_1/KAf_channel /output/plot_out SAVE Gk
	addmsg /cell/tertdend9_1/KAf_channel /output/plot_out SAVE Gk
	addmsg /cell/tertdend13_1/KAf_channel /output/plot_out SAVE Gk
	
	addmsg /cell/tertdend1_1/KAs_channel /output/plot_out SAVE Gk
	addmsg /cell/tertdend5_1/KAs_channel /output/plot_out SAVE Gk
	addmsg /cell/tertdend9_1/KAs_channel /output/plot_out SAVE Gk
	addmsg /cell/tertdend13_1/KAs_channel /output/plot_out SAVE Gk
	
	addmsg /cell/tertdend1_1/Krp_channel /output/plot_out SAVE Gk
	addmsg /cell/tertdend5_1/Krp_channel /output/plot_out SAVE Gk
	addmsg /cell/tertdend9_1/Krp_channel /output/plot_out SAVE Gk
	addmsg /cell/tertdend13_1/Krp_channel /output/plot_out SAVE Gk

	addmsg /cell/tertdend1_1/SK_channel /output/plot_out SAVE Gk
	addmsg /cell/tertdend5_1/SK_channel /output/plot_out SAVE Gk
	addmsg /cell/tertdend9_1/SK_channel /output/plot_out SAVE Gk
	addmsg /cell/tertdend13_1/SK_channel /output/plot_out SAVE Gk
	
	addmsg /cell/tertdend1_1/BK_channel /output/plot_out SAVE Gk
	addmsg /cell/tertdend5_1/BK_channel /output/plot_out SAVE Gk
	addmsg /cell/tertdend9_1/BK_channel /output/plot_out SAVE Gk
	addmsg /cell/tertdend13_1/BK_channel /output/plot_out SAVE Gk
*/

	addmsg /cell/tertdend1_1/GkSum /output/plot_out SAVE output
	addmsg /cell/tertdend1_1/CaSum /output/plot_out SAVE output
end


/* copy into file: 
call /output/plot_out OUT_OPEN
call /output/plot_out OUT_WRITE "time SomaVm tert1Vm tert5Vm tert9Vm tert13Vm tert1Fura tert5Fura tert9Fura tert13Fura tert1_1GkSum tert1_1CaSum" //header	
*/


