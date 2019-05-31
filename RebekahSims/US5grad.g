
str cellpath = "/cell"


include RebekahSims/SpikeMaker.g
include RebekahSims/add_outputPools.g

add_output

str stimtype = "5APgrad"
str diskpath={diskpath1}@(stimtype)@{spiketype}@".txt"
echo {diskpath}
setfield /output/plot_out filename output/{diskpath}
reset

call /output/plot_out OUT_OPEN
call /output/plot_out OUT_WRITE "time SomaVm tert1pool tert5pool tert9pool tert13pool tert1volavg tert5volavg tert9volavg tert13volavg tert1dif1 tert5dif1 tert9dif1 tert13dif1 tert1F2 tert5F2 tert9F2 tert13F2 tert1NMDA tert5NMDA tert9NMDA tert13NMDA" //header	
int Hz = 10 //for glu, function multiplies this by 2 for GABA
float upstate_time = 0.3
float AP_time = 0.005  //AP latency from upstate onset
float AP_durtime = 0.005 //duration of AP depolarization at soma, 5 ms
float high_time = 0.01
float med_time  = 0.2
float low_time  = 0.09
float injection = 800e-12

// use randomspike to put inputs into NMDA and AMPA receptors 
deleteALLspikes
makeALLpre {Hz}


step 0.05 -time

makeALLpost "high"

	step {AP_time} -time

		setfield {cellpath}/soma inject {injection}

	step {AP_durtime} -time

		setfield {cellpath}/soma inject 0
	
	step {{high_time}-{AP_time}-{AP_durtime}} -time

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


