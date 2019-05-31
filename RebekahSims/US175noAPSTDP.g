


str cellpath = "/cell"
str othercell = "/othercell"


include RebekahSims/SpikeMakerSTDP.g
include RebekahSims/add_outputgradSTDP




create compartment {othercell}
addmsg {othercell} {cellpath}/tertdend1_1/spikegen INPUT Vm
addmsg {othercell} {cellpath}/tertdend1_2/spikegen INPUT Vm
addmsg {othercell} {cellpath}/tertdend1_3/spikegen INPUT Vm
addmsg {othercell} {cellpath}/tertdend1_4/spikegen INPUT Vm
addmsg {othercell} {cellpath}/tertdend1_5/spikegen INPUT Vm
addmsg {othercell} {cellpath}/tertdend1_6/spikegen INPUT Vm
addmsg {othercell} {cellpath}/tertdend1_7/spikegen INPUT Vm
addmsg {othercell} {cellpath}/tertdend1_8/spikegen INPUT Vm
addmsg {othercell} {cellpath}/tertdend1_9/spikegen INPUT Vm
addmsg {othercell} {cellpath}/tertdend1_10/spikegen INPUT Vm
addmsg {othercell} {cellpath}/tertdend1_11/spikegen INPUT Vm

addmsg {othercell} {cellpath}/tertdend1_1/spikegen INPUT Vm
addmsg {othercell} {cellpath}/tertdend2_1/spikegen INPUT Vm
addmsg {othercell} {cellpath}/tertdend3_1/spikegen INPUT Vm
addmsg {othercell} {cellpath}/tertdend4_1/spikegen INPUT Vm
addmsg {othercell} {cellpath}/tertdend5_1/spikegen INPUT Vm
addmsg {othercell} {cellpath}/tertdend6_1/spikegen INPUT Vm
addmsg {othercell} {cellpath}/tertdend7_1/spikegen INPUT Vm
addmsg {othercell} {cellpath}/tertdend8_1/spikegen INPUT Vm
addmsg {othercell} {cellpath}/tertdend9_1/spikegen INPUT Vm
addmsg {othercell} {cellpath}/tertdend10_1/spikegen INPUT Vm
addmsg {othercell} {cellpath}/tertdend11_1/spikegen INPUT Vm
addmsg {othercell} {cellpath}/tertdend12_1/spikegen INPUT Vm
addmsg {othercell} {cellpath}/tertdend13_1/spikegen INPUT Vm
addmsg {othercell} {cellpath}/tertdend14_1/spikegen INPUT Vm
addmsg {othercell} {cellpath}/tertdend15_1/spikegen INPUT Vm
addmsg {othercell} {cellpath}/tertdend16_1/spikegen INPUT Vm

add_output

float inj = 0

str stimtype = "175msAPstdpnoAP"
diskpath={diskpath}@(stimtype)@{spiketype}@".txt"
echo {diskpath}
setfield /output/plot_out filename output/{diskpath}
reset
call /output/plot_out OUT_OPEN
call /output/plot_out OUT_WRITE "time SomaVm tert1_1F5F tert5_1F5F tert9_1F5F tert13_1F5F tert1_2F5F tert1_3F5F tert1_1NMDACa tert1_1LCa tert5_1NMDACa tert5_1LCa tert1_2NMDACa tert1_2LCa" //header	

int Hz = 10 //for glu, function multiplies this by 2 for GABA
float upstate_time = 0.3
float isi = 0.01  //10ms
float AP_time = 0.175  //AP latency from upstate onset
float AP_durtime = 0.005 //duration of AP depolarization at soma, 5 ms
float high_time = 0.01
float med_time  = 0.2
float low_time  = 0.09

// use randomspike to put inputs into NMDA and AMPA receptors 

makeALLpre {Hz}


step 0.05 -time

makeALLpost "high"

	step {high_time} -time

stopGlu
stopGABA
makeALLpost "med"

	step {{AP_time}-{high_time}} -time

		setfield {othercell} Vm 10

	step 1 

		setfield {othercell} Vm -0.090

	step {isi} -time

		setfield {cellpath}/soma inject {inj}

	step {AP_durtime} -time

		setfield {cellpath}/soma inject 0
	
	step {{med_time}-{{AP_time}-{high_time}}-{AP_durtime}-{isi}} -time
	

stopGlu
stopGABA
makeALLpost "low"

	step {low_time} -time

stopGlu
stopGABA
	step 0.2 -time


