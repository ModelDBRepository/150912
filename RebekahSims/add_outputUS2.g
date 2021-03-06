

function add_output
	create asc_file /output/plot_out
	setfield /output/plot_out   flush 1  leave_open 1 append 1 \
          float_format %0.6g
    useclock /output/plot_out 1
	addmsg /cell/soma /output/plot_out  SAVE Vm

	addmsg /cell/tertdend1_1/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/tertdend5_1/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/tertdend9_1/fluorescence /output/plot_out SAVE ratio

	addmsg /cell/tertdend1_1/volavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend5_1/volavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend9_1/volavg /output/plot_out SAVE meanValue

	addmsg /cell/tertdend1_1/NR2A/GHK /output/plot_out SAVE Ik
	addmsg /cell/tertdend1_1/NR2A/block /output/plot_out SAVE Ik
	addmsg /cell/tertdend5_1/NR2A/GHK /output/plot_out SAVE Ik
	addmsg /cell/tertdend5_1/NR2A/block /output/plot_out SAVE Ik
	addmsg /cell/tertdend9_1/NR2A/GHK /output/plot_out SAVE Ik
	addmsg /cell/tertdend9_1/NR2A/block /output/plot_out SAVE Ik

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
end

/* copy into file: 
call /output/plot_out OUT_OPEN
call /output/plot_out OUT_WRITE "time SomaVm tert1fura tert5fura tert9fura tert1vol tert5vol tert9vol tert1nmdaGHK tert1block tert5nmdaGHK tert5block tert9nmdaGHK tert9block tert1nmdaGHKgk tert1blockgk tert5nmdaGHKgk tert5blockgk tert9nmdaGHKgk tert9blockgk tert1L12 tert5L12 tert9L12 tert1L13 tert5L13 tert9L13 tert1N tert5N tert9N tert1T tert5T tert9T tert1R tert5R tert9T" //header	
*/


