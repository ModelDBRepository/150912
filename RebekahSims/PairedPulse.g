//genesis PairedPulse.g

include RebekahSims/addoutput.g

add_output
str cellpath = "/cell"
str stimtype = "PP50ms"
diskpath={diskpath}@(stimtype)@".txt"
echo {diskpath}
setfield /output/plot_out filename output/{diskpath}
reset

setfield /output/plot_out filename output/{diskpath}
		call /output/plot_out OUT_OPEN
		call /output/plot_out OUT_WRITE "time SomaVm somaVavg primVavg secVavg tertVavg" //header

int i
float isi = 0.05 //50ms

for (i=0; i<1; i=i+1)
	step 0.1 -time

		setfield {cellpath}/secdend11/presyn_ext z {1/{getclock 0}}
		
	step 1

		setfield {cellpath}/secdend11/presyn_ext z 0

	step {isi} -time
	
		setfield {cellpath}/secdend11/presyn_ext z {1/{getclock 0}}
		
	step 1
	
		setfield {cellpath}/secdend11/presyn_ext z 0
		
	step 0.5 -time
	isi={isi}+0.01
end 
