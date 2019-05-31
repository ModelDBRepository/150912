//genesis SingleBlast.g

include RebekahSims/add_outputgrad3.g

add_output
str cellpath = "/cell"
str othercell = "/othercell"
str stimtype = "SingleBlastlong"
diskpath={diskpath}@(stimtype)@".txt"
echo {diskpath}
setfield /output/plot_out filename output/{diskpath}
reset

setfield /output/plot_out filename output/{diskpath}
		call /output/plot_out OUT_OPEN
		call /output/plot_out OUT_WRITE "time SomaVm tert1Vm tert1Fluo5F tert1Vavg tert1NMDACa tert1LCa tert1NMDAGHKgk tert1NMDAblockgk tert1L12X tert1L12Y tert1L12Z tert1L13X tert1L13Y tert1L13Z tert1RX tert1RY tert1RZ" //header	

//because we are using the facsynchan which cannot recieve activation messages, we have to use spikegen 
//objects and send input into them.
 
	create compartment {othercell}
	str CompName
	foreach CompName ({el /cell/##[TYPE=compartment]})
		addmsg {othercell} {CompName}/spikegen INPUT Vm
	end

float deltaT = 0.01
float AP_durtime = 0.005
int i
setfield /data/soma overlay 1
setfield /data/spineVm overlay 1
setfield /data/spineCa overlay 1
setfield /data/Ca overlay 1

for (i=0; i<15; i=i+1)
		call /output/plot_out OUT_WRITE "/newplot" 
		call /output/plot_out OUT_WRITE "/plotname "{deltaT} 
	step 0.1 -time


		setfield {othercell} Vm 10
		
	step 1

		setfield {othercell} Vm -0.090

	step {deltaT} -time

		setfield {cellpath}/soma inject {1000e-12}

	step {AP_durtime} -time

		setfield {cellpath}/soma inject 0
	
	step {{0.3}-{deltaT}-{AP_durtime}} -time
	deltaT={deltaT}+0.01
	reset
	call /output/plot_out FLUSH

end 
