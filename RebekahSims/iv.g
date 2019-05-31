
//IF.g

//str srcpath={neuronname}@"/soma"
//str savefield="Vm"
//float outputclock = 2e-5
//create asc_file /output/plot_out

//useclock /output/plot_out 1
//setfield /output/plot_out   flush 1  leave_open 1 append 1 \
//          float_format %0.6g

 function add_output
	create asc_file /output/plot_out
	setfield /output/plot_out   flush 1  leave_open 1 append 1 \
          float_format %0.6g
    useclock /output/plot_out 1
	addmsg /cell/soma /output/plot_out  SAVE Vm
	call /output/plot_out OUT_OPEN
	call /output/plot_out OUT_WRITE "time SomaVm" //header
end

add_output
str diskpath
str subunit
str stimtype
echo "diskpath" 
reset

	stimtype="IVcurve"
	diskpath=(subunit)@(stimtype)@".txt"
	setfield /output/plot_out filename output/{diskpath}
		call /output/plot_out OUT_OPEN
		call /output/plot_out OUT_WRITE "time	somaVm" 
	

//setfield /data/soma overlay 1
int i = 0
float inj =  -500e-12  //990e-12  //640e-12  //280e-12   

float inject, delay, current_duration, total_duration
delay= 0.2 
current_duration=0.4
total_duration=delay*2+current_duration

for (i=0; i<15; i=i+1)
   echo {inj} = "I inject"
	step {delay} -time
	setfield {neuronname}/soma inject {inj}
		step {current_duration}  -time
	setfield {neuronname}/soma inject 0.0e-9

	step {delay} -time
	inj= {inj}+50.0e-12

end


