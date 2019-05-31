//genesis theta.g


include RebekahSims/addoutput.g
str cellpath = "/cell"
add_output

str stimtype = "ThetaLong"
diskpath={diskpath}@(stimtype)@".txt"
echo {diskpath}
setfield /output/plot_out filename output/{diskpath}
reset

setfield /output/plot_out filename output/{diskpath}
		call /output/plot_out OUT_OPEN
		call /output/plot_out OUT_WRITE "time SomaVm somaVavg primVavg secVavg tertVavg" //header

float trainHz = 10.5
float burstHz = 50
int i
int j

step 0.1 -time

for (j=0; j<10; j=j+1)
	step 14.845 -time
	for (i=0; i<10; i=i+1)
		
		setfield {cellpath}/tertdend1_1/presyn_ext z {1/{getclock 0}}
		step 1
		setfield {cellpath}/tertdend1_1/presyn_ext z 0
	
		step 0.02 -time

		setfield {cellpath}/tertdend1_1/presyn_ext z {1/{getclock 0}}
		step 1
		setfield {cellpath}/tertdend1_1/presyn_ext z 0

		step 0.02 -time

		setfield {cellpath}/tertdend1_1/presyn_ext z {1/{getclock 0}}
		step 1
		setfield {cellpath}/tertdend1_1/presyn_ext z 0

		step 0.02 -time

		setfield {cellpath}/tertdend1_1/presyn_ext z {1/{getclock 0}}
		step 1
		setfield {cellpath}/tertdend1_1/presyn_ext z 0
	
		step 0.095 -time
	end
	
end 




