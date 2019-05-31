
str cellpath = "/cell"

include RebekahSims/SpikeMaker.g
include RebekahSims/add_outputgrad

add_output

str stimtype = "20Hz5msAP"
diskpath={diskpath}@(stimtype)@".txt"
echo {diskpath}
setfield /output/plot_out filename output/{diskpath}
reset
call /output/plot_out OUT_OPEN
call /output/plot_out OUT_WRITE "time SomaVm tert1Vm tert5Vm tert9Vm tert13Vm tert1fura tert5fura tert9fura tert13fura tert1vol tert5vol tert9vol tert13vol" //header	



int Hz = 20 //for glu, function multiplies this by 2 for GABA
float upstate_time = 0.3
float AP_time = 0.005  //AP latency from upstate onset
float AP_durtime = 0.002 //duration of AP depolarization at soma, 5 ms
float high_time = 0.01
float med_time  = 0.2
float low_time  = 0.09

// use randomspike to put inputs into NMDA and AMPA receptors 

makeALLpre {Hz}


step 0.05 -time

makeALLpost "high"

	step {AP_time} -time

	setfield {cellpath}/soma inject {2000e-12}

	step {AP_durtime} -time

	setfield {cellpath}/soma inject 0
	
	step {{high_time}-{AP_time}-{AP_durtime}}

stopGlu
stopGABA
makeALLpost "med"

	step {med_time} -time

stopGlu
stopGABA
makeALLpost "low"

	step {low_time} -time

stopGlu
stopGABA
	step 0.2 -time


