//genesis Shindou3AP.g

include RebekahSims/addoutput.g
str cellpath = "/cell"
add_output

str stimtype = "Shindou3APonly"
diskpath={diskpath}@(stimtype)@".txt"
echo {diskpath}
setfield /output/plot_out filename output/{diskpath}
reset

setfield /output/plot_out filename output/{diskpath}
		call /output/plot_out OUT_OPEN
		call /output/plot_out OUT_WRITE "time SomaVm somaVavg primVavg secVavg tertVavg" //header


step 0.1 -time

	//setfield {cellpath}/tertdend1_1/presyn_ext z {1/{getclock 0}}
	
step 1

	//setfield {cellpath}/tertdend1_1/presyn_ext z 0

step 0.01 -time
//Shindou uses 100Hz triplets
	
	step 0 -time	
	setfield {cellpath}/soma inject 1e-9 
	step 0.005 -time
	setfield {cellpath}/soma inject 0
	step 0.005 -time
	setfield {cellpath}/soma inject 1e-9 
	step 0.005 -time
	setfield {cellpath}/soma inject 0
	step 0.005 -time
	setfield {cellpath}/soma inject 1e-9 
	step 0.005 -time
	setfield {cellpath}/soma inject 0

step {0.5} -time

	
