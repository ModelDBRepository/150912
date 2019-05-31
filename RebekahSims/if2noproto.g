//genesis
//IF2noproto.g

function add_output
	create asc_file /output/plot_out
	setfield /output/plot_out   flush 1  leave_open 1 append 1 \
          float_format %0.6g
    useclock /output/plot_out 1
	addmsg /cell/soma /output/plot_out  SAVE Vm
	addmsg /cell/soma/BK_channel /output/plot_out  SAVE Gk
	addmsg /cell/soma/SK_channel /output/plot_out  SAVE Gk
	addmsg /cell/secdend11/BK_channel /output/plot_out  SAVE Gk
	addmsg /cell/secdend11/SK_channel /output/plot_out  SAVE Gk
		
  if (calciumtype==0)
	addmsg /cell/soma/Ca_difshell_1 /output/plot_out SAVE C
	addmsg /cell/primdend1/Ca_difshell_1 /output/plot_out SAVE C
	addmsg /cell/secdend11/Ca_difshell_1 /output/plot_out SAVE C
	addmsg /cell/tertdend1_1/Ca_difshell_1 /output/plot_out SAVE C
	addmsg /cell/tertdend1_6/Ca_difshell_1 /output/plot_out SAVE C

  elif (calciumtype==1) //single time constant of decay
	addmsg /cell/soma/Ca_difshell_1 /output/plot_out SAVE Ca
	addmsg /cell/primdend1/Ca_difshell_1 /output/plot_out SAVE Ca
	addmsg /cell/secdend11/Ca_difshell_1 /output/plot_out SAVE Ca
	addmsg /cell/tertdend1_1/Ca_difshell_1 /output/plot_out SAVE Ca
	addmsg /cell/tertdend1_6/Ca_difshell_1 /output/plot_out SAVE Ca
  else
    echo "unrecognized calcium type"
  end
end

add_output
str stimtype

stimtype="IF-500"
diskpath={diskpath}@(stimtype)@".txt"
echo {diskpath}
setfield /output/plot_out filename output/{diskpath}
reset

call /output/plot_out OUT_OPEN
call /output/plot_out OUT_WRITE "time SomaVm BK SK BKSec SKsec SomaCa1 PrimCa1 SecCa1 TertCa1" //header	

int i = 0
float inj =  220e-12  //990e-12  //640e-12  //280e-12  
float inc = 100e-12 

float inject, delay, current_duration, total_duration
delay= 0.1
current_duration=0.4
total_duration=delay*2+current_duration

for (i=0; i<1; i=i+1)
		call /output/plot_out OUT_WRITE "/newplot" 
		call /output/plot_out OUT_WRITE "/plotname "{inj*1e9} 
        reset
    echo {inj} = "I inject"
	step {delay} -time
	setfield {neuronname}/soma inject {inj}
	step {current_duration}  -time
	setfield {neuronname}/soma inject 0.0e-9
	step {delay} -time

	inj= {inj}+{inc}
end

call /output/plot_out FLUSH

//gen2spkShape output/{diskpath} {delay} {current_duration} {total_duration} -stepsize {outputclock}


