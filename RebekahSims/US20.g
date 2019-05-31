

add_output

float inj = 800e-12
int Hz = 10  //for glu, function incrases by 2.5 this for GABA
float upstate_time = 0.3
float AP_time = 0.02  //AP latency from upstate onset
float AP_durtime = 0.005 //duration of AP depolarization at soma, 5 ms


str stimtype = "AP20flat"
str diskpath={diskpath1}@(stimtype)@{spiketypeFlat}@".txt"
echo {diskpath}
setfield /output/plot_out filename output/{diskpath}
reset

include RebekahSims/header.g

	makeallpreFlat {Hz}

step 0.05 -time

	makeallpostFlat

step {AP_time} -time
	
	setfield {cellpath}/soma inject {inj}

step {AP_durtime} -time

	setfield {cellpath}/soma inject 0
	
step {{upstate_time}-{AP_time}-{AP_durtime}} -time

	StopAllFlat

step 0.2 -t


