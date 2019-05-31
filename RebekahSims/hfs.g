//genesis HFS.g


include RebekahSims/addoutput.g
str cellpath = "/cell"
add_output

str stimtype = "HFS"
diskpath={diskpath}@(stimtype)@".txt"
echo {diskpath}
setfield /output/plot_out filename output/{diskpath}
reset

setfield /output/plot_out filename output/{diskpath}
		call /output/plot_out OUT_OPEN
		call /output/plot_out OUT_WRITE "time SomaVm somaVavg primVavg secVavg tertVavg" //header

int i
int j

step 0.1 -time

//for (i=0; i<4; i=i+1)
	for (j=0; j<100; j=j+1)	
		setfield {cellpath}/tertdend1_1/presyn_ext z {1/{getclock 0}}
		step 1
		setfield {cellpath}/tertdend1_1/presyn_ext z 0
		step 0.01 -time
	end
	//step 10 -time 
//end 




