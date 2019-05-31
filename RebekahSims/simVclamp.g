//genesis
//IF2.g

function add_output
	create asc_file /output/plot_out
	setfield /output/plot_out   flush 1  leave_open 1 append 1 \
          float_format %0.6g
    useclock /output/plot_out 1
	addmsg /cell/soma /output/plot_out  SAVE Vm

	addmsg /cell/soma/BK_channel /output/plot_out  SAVE Gk
	addmsg /cell/soma/SK_channel /output/plot_out  SAVE Gk
	addmsg /cell/secdend11/BK_channel /output/plot_out  SAVE Gk
	addmsg /cell/secdend11/SK_channel /output/plot_out  SAVE Gk

	addmsg /cell/soma/BK_channel /output/plot_out  SAVE Ik
	addmsg /cell/soma/SK_channel /output/plot_out  SAVE Ik
	addmsg /cell/secdend11/BK_channel /output/plot_out  SAVE Ik
	addmsg /cell/secdend11/SK_channel /output/plot_out  SAVE Ik
/*
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
	addmsg /cell/secdend12/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/tertdend1_1/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/tertdend1_2/fluorescence /output/plot_out SAVE ratio

	addmsg /cell/tertdend1_3/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/tertdend1_4/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/tertdend1_5/fluorescence /output/plot_out SAVE ratio	
	addmsg /cell/tertdend1_6/fluorescence /output/plot_out SAVE ratio

	addmsg /cell/soma/volavg /output/plot_out SAVE meanValue
	addmsg /cell/primdend1/volavg /output/plot_out SAVE meanValue
	addmsg /cell/secdend12/volavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend1_1/volavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend1_5/volavg /output/plot_out SAVE meanValue
	addmsg /cell/tertdend1_9/volavg /output/plot_out SAVE meanValue
*/
	//call /output/plot_out OUT_OPEN
   // call /output/plot_out OUT_WRITE "time SomaVm somafura primfura secfura tert1fura" //header
end

add_output
str stimtype

stimtype="BKSK700pA+"
diskpath={diskpath}@(stimtype)@".txt"
echo {diskpath}
setfield /output/plot_out filename output/{diskpath}
reset

call /output/plot_out OUT_OPEN
call /output/plot_out OUT_WRITE "time SomaVm somaBKg somaSKg secBKg secSKg somaBKi somaSKi secBKi secSKi" //header

int i = 0
float inj =  700e-12  //990e-12  //640e-12  //280e-12   

float inject, delay, current_duration, total_duration
float start_current = 0
delay= 0.1
current_duration=0.3
total_duration=delay*2+current_duration
reset
for (i=0; i<5; i=i+1)
		call /output/plot_out OUT_WRITE "/newplot" 
		call /output/plot_out OUT_WRITE "/plotname "{inj*1e9} 
        
    echo {inj} = "I inject"
	setfield {neuronname}/soma inject {start_current}
	step {delay} -time
	setfield {neuronname}/soma inject {inj}
	step {current_duration}  -time
	setfield {neuronname}/soma inject {start_current}
	step {{delay}+0.1} -time
	reset
	inj= {inj}+100.0e-12
end

call /output/plot_out FLUSH

//gen2spkShape output/{diskpath} {delay} {current_duration} {total_duration} -stepsize {outputclock}


