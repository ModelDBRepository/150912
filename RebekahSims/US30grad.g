

add_output
float inj = 800e-12
str stimtype = "30APgrad"
str diskpath={diskpath1}@(stimtype)@{spiketypeGrad}@".txt"
echo {diskpath}
setfield /output/plot_out filename output/{diskpath}
reset

include RebekahSims/header.g

int Hz = 10 //for glu, function multiplies this by 2 for GABA
float upstate_time = 0.3
float AP_time = 0.03  //AP latency from upstate onset
float AP_durtime = 0.005 //duration of AP depolarization at soma, 5 ms
float high_time = 0.01
float med_time  = 0.2
float low_time  = 0.09

// use randomspike to put inputs into NMDA and AMPA receptors 

makeALLpreGrad {Hz}


step 0.05 -time

makeALLpostGrad "high"

	step {high_time} -time

stopGluGrad
stopGABAGrad
makeALLpostGrad "med"

	step {{AP_time}-{high_time}} -time

		setfield {cellpath}/soma inject {inj}

	step {AP_durtime} -time

		setfield {cellpath}/soma inject 0
	
	step {{med_time}-{{AP_time}-{high_time}}-{AP_durtime}} -time
	

stopGluGrad
stopGABAGrad
makeALLpostGrad "low"

	step {low_time} -time

stopGluGrad
stopGABAGrad
	step 0.2 -time


