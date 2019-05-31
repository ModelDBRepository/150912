//genesis
//IF2.g

function add_output
	create asc_file /output/plot_out
	setfield /output/plot_out   flush 1  leave_open 1 append 1 \
          float_format %0.6g
    useclock /output/plot_out 1
	addmsg /cell/soma /output/plot_out  SAVE Vm
	addmsg /cell/primdend1 /output/plot_out  SAVE Vm
	addmsg /cell/secdend11 /output/plot_out  SAVE Vm
	addmsg /cell/tertdend1_1 /output/plot_out  SAVE Vm
	addmsg /cell/tertdend1_2 /output/plot_out  SAVE Vm
	addmsg /cell/tertdend1_3 /output/plot_out  SAVE Vm
	addmsg /cell/tertdend1_4 /output/plot_out  SAVE Vm

	//addmsg /cell/soma/NaF_channel /output/plot_out  SAVE Gk
/*
	addmsg /cell/soma/BK_channel /output/plot_out  SAVE Gk
	addmsg /cell/soma/SK_channel /output/plot_out  SAVE Gk
	//addmsg /cell/soma/KAf_channel /output/plot_out  SAVE Gk
	//addmsg /cell/soma/KDR_channel /output/plot_out  SAVE Gk
	//addmsg /cell/soma/KAs_channel /output/plot_out  SAVE Gk

	addmsg /cell/soma/BK_channel /output/plot_out  SAVE Gk
	addmsg /cell/soma/SK_channel /output/plot_out  SAVE Gk

	addmsg /cell/soma/CaR_channelGHK /output/plot_out SAVE Gk
	addmsg /cell/soma/CaN_channelGHK /output/plot_out SAVE Gk
	addmsg /cell/soma/CaT_channelGHK /output/plot_out SAVE Gk
	addmsg /cell/soma/CaL13_channelGHK /output/plot_out SAVE Gk
	addmsg /cell/soma/CaL12_channelGHK /output/plot_out SAVE Gk

	addmsg /cell/secdend11/CaR_channelGHK /output/plot_out SAVE Gk
	addmsg /cell/secdend11/CaN_channelGHK /output/plot_out SAVE Gk
	addmsg /cell/secdend11/CaT_channelGHK /output/plot_out SAVE Gk
	addmsg /cell/secdend11/CaL13_channelGHK /output/plot_out SAVE Gk
	addmsg /cell/secdend11/CaL12_channelGHK /output/plot_out SAVE Gk

	addmsg /cell/tertdend1_1/CaR_channelGHK /output/plot_out SAVE Gk
	addmsg /cell/tertdend1_1/CaN_channelGHK /output/plot_out SAVE Gk
	addmsg /cell/tertdend1_1/CaT_channelGHK /output/plot_out SAVE Gk
	addmsg /cell/tertdend1_1/CaL13_channelGHK /output/plot_out SAVE Gk
	addmsg /cell/tertdend1_1/CaL12_channelGHK /output/plot_out SAVE Gk
		

	addmsg /cell/soma/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/primdend1/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/secdend11/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/tertdend1_1/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/tertdend1_2/fluorescence /output/plot_out SAVE ratio

	addmsg /cell/tertdend1_3/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/tertdend1_4/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/tertdend1_5/fluorescence /output/plot_out SAVE ratio	
	addmsg /cell/tertdend1_6/fluorescence /output/plot_out SAVE ratio

	addmsg /cell/soma/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/primdend1/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/secdend11/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend1_1/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend1_2/Fluo5FVavg /output/plot_out SAVE meanValue

	addmsg /cell/tertdend1_3/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend1_4/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend1_5/Fluo5FVavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend1_6/Fluo5FVavg /output/plot_out SAVE meanValue
*/
	addmsg /cell/soma/volavg /output/plot_out SAVE meanValue
	addmsg /cell/primdend1/volavg /output/plot_out SAVE meanValue
	addmsg /cell/secdend11/volavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend1_1/volavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend1_2/volavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend1_3/volavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend1_4/volavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend1_5/volavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend1_6/volavg /output/plot_out SAVE meanValue

	//call /output/plot_out OUT_OPEN
   // call /output/plot_out OUT_WRITE "time SomaVm tert1Fluo5F tert2Fluo5F tert3Fluo5F tert4Fluo5F tert5Fluo5F tert6Fluo5F" //header
end

add_output
str stimtype

stimtype="IF800p5ms"
str diskpath={diskpath1}@(stimtype)@".txt"
echo {diskpath}
setfield /output/plot_out filename output/{diskpath}
reset

call /output/plot_out OUT_OPEN
call /output/plot_out OUT_WRITE "time SomaVm primVm secVm tert1Vm tert2Vm tert3Vm tert4Vm somavolavg primvolavg secvolavg tert1volavg tert2volavg tert3volavg tert4volavg tert5volavg tert6volavg" //header
int i = 0
float inj = 800e-12  //990e-12  //640e-12  //280e-12   

float inject, delay, current_duration, total_duration
float start_current = 0
delay= 0.05
current_duration=0.005
total_duration=delay*2+current_duration
reset
setfield /data/soma overlay 1
setfield /data/spineVm overlay 1
setfield /data/spineCa overlay 1
setfield /data/Ca overlay 1
for (i=0; i<1; i=i+1)
		//call /output/plot_out OUT_WRITE "/newplot" 
		//call /output/plot_out OUT_WRITE "/plotname "{inj*1e9} 
        
    echo {inj} = "I inject"
	setfield {neuronname}/soma inject {start_current}
	step {delay} -time
	setfield {neuronname}/soma inject {inj}
	step {current_duration}  -time
	setfield {neuronname}/soma inject {start_current}
	step {delay} -time
	reset
	inj= {inj}+50.0e-12
end

call /output/plot_out FLUSH

//gen2spkShape output/{diskpath} {delay} {current_duration} {total_duration} -stepsize {outputclock}


