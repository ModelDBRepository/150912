//genesis SingleStim.g

include RebekahSims/addoutput.g
str cellpath = "/cell"
add_output

str stimtype = "Singletert"
diskpath={diskpath}@(stimtype)@".txt"
echo {diskpath}
setfield /output/plot_out filename output/{diskpath}
reset

setfield /output/plot_out filename output/{diskpath}
		call /output/plot_out OUT_OPEN
		call /output/plot_out OUT_WRITE "time SomaVm tert1_1volavg tert1_1Cadif1 tert1_1fura" //header


step 0.05 -time

	setfield {cellpath}/tertdend1_1/presyn_ext z {1/{getclock 0}}
	
step 1

	setfield {cellpath}/tertdend1_1/presyn_ext z 0

step 0.1 -time

