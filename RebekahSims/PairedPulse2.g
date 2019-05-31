//genesis PairedPulse2.g

include RebekahSims/addoutput.g

add_output
str cellpath = "/cell"
str othercell = "/othercell"
str stimtype = "PPtrain"
diskpath={diskpath}@(stimtype)@".txt"
echo {diskpath}
setfield /output/plot_out filename output/{diskpath}
reset

setfield /output/plot_out filename output/{diskpath}
		call /output/plot_out OUT_OPEN
		call /output/plot_out OUT_WRITE "time SomaVm secVm SecVavg secNMDAgk secAMPAgk secFura" //header

//because we are using the facsynchan which cannot recieve activation messages, we have to use spikegen 
//objects and send input into them.
 
	create compartment {othercell}
	addmsg {othercell} {cellpath}/secdend11/spikegen INPUT Vm
int i
float isi = 0.01 //50ms

for (i=0; i<5; i=i+1)
	call /output/plot_out OUT_WRITE "/newplot" 
	call /output/plot_out OUT_WRITE "/plotname " {isi} 
	step 0.1 -time

		setfield {othercell} Vm 10
		
	step 1

		setfield {othercell} Vm -0.090

	step {isi} -time
	
		setfield {othercell} Vm 10
		
	step 1
	
		setfield {othercell} Vm -0.090
		
	step 0.3 -time
	reset
	isi={isi}+0.01
end 
