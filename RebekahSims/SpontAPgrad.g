
str cellpath = "/cell"


include RebekahSims/SpikeMaker.g
include RebekahSims/add_outputgrad2.g

add_output

float inj = 800e-12
str stimtype = "SpontAPgrad"
diskpath={diskpath}@(stimtype)@{spiketype}@".txt"
echo {diskpath}
setfield /output/plot_out filename output/{diskpath}
reset

call /output/plot_out OUT_OPEN
call /output/plot_out OUT_WRITE "time SomaVm tert1Vm tert5Vm tert9Vm tert13Vm tert1Fura tert5Fura tert9Fura tert13Fura tert1_1GkSum tert1_1CaSum" //header	


int Hz = 10 //for glu, function multiplies this by 2 for GABA
float upstate_time = 0.3
float AP_time = 0  //AP latency from upstate onset
float AP_durtime = 0 //duration of AP depolarization at soma, 5 ms
float high_time = 0.01
float med_time  = 0.2
float low_time  = 0.09

// use randomspike to put inputs into NMDA and AMPA receptors 

makeALLpre {Hz}


step 0.05 -time

makeGLUpost "high"

step {high_time} -time
	
stopGlu
makeALLpost "med"

step {med_time} -time

stopGlu
stopGABA
makeALLpost "low"

step {low_time} -time

stopGlu
stopGABA
step 0.2 -time


