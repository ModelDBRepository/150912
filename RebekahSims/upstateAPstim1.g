

//set random seed so for each simulation the randomspike train will be the same
randseed 5757538
//2 = 9824501
//1 = 2394075

/****************begin local subroutines*************/
function add_output
	create asc_file /output/plot_out
	setfield /output/plot_out   flush 1  leave_open 1 append 1 \
          float_format %0.6g
    useclock /output/plot_out 1
	addmsg /cell/soma /output/plot_out  SAVE Vm
	//addmsg /cell/soma/KIR_channel /output/plot_out SAVE Gk
	//addmsg /cell/soma/Ca_difshell_1 /output/plot_out  SAVE C
	//addmsg /cell/soma/Ca_difshell_2 /output/plot_out  SAVE C
	//addmsg /cell/soma/Ca_difshell_4 /output/plot_out  SAVE C
	//addmsg /cell/soma/Ca_difshell_5 /output/plot_out  SAVE C
	//addmsg /cell/soma/BKK_channel /output/plot_out  SAVE Ik
	//addmsg /cell/soma/SK_channel /output/plot_out  SAVE Ik
	
	addmsg /cell/soma/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/primdend1/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/secdend11/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/tertdend1_1/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/tertdend1_2/fluorescence /output/plot_out SAVE ratio

	addmsg /cell/primdend2/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/secdend21/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/tertdend2_1/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/tertdend2_2/fluorescence /output/plot_out SAVE ratio

	addmsg /cell/primdend3/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/secdend31/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/tertdend3_1/fluorescence /output/plot_out SAVE ratio
	addmsg /cell/tertdend3_2/fluorescence /output/plot_out SAVE ratio


	//addmsg /cell/tertdend1/tert_dend3/fluorescence /output/plot_out SAVE ratio
	//addmsg /cell/tertdend1/tert_dend5/fluorescence /output/plot_out SAVE ratio
	//addmsg /cell/tertdend1/tert_dend7/fluorescence /output/plot_out SAVE ratio
	//addmsg /cell/tertdend1/tert_dend9/fluorescence /output/plot_out SAVE ratio
	//addmsg /cell/tertdend1/tert_dend11/fluorescence /output/plot_out SAVE ratio

end



//these three functions used to provide synaptic input to neuron

function makeinputpre(rate, path)
    str rate
    str path
    create randomspike {path}/randomspike
    setfield ^ min_amp 1.0 max_amp 1.0 rate {rate} reset 1 reset_value 0	
 end
	
function makeinputpost(pathspike, path) 
	str path
	int msgnum
	addmsg {pathspike} {path} SPIKE
    msgnum = {getfield {path} nsynapses} - 1
    setfield {path} \
    synapse[{msgnum}].weight 1 synapse[{msgnum}].delay 0
end


function stopinput(path)
	str path
	deletemsg {path} 2 -incoming
end


/*********end local subroutines*****************/

//add_output

int Hz = 8
float upstate_time = 0.3
float AP_time = 0.175  //AP latency from upstate onset
float AP_durtime = 0.002 //duration of AP depolarization at soma, 5 ms

str cellpath = "/cell"
str stimtype = "8Hz300ms175msAP"
diskpath={diskpath}@(stimtype)@".txt"
echo {diskpath}
setfield /output/plot_out filename output/{diskpath}
reset

call /output/plot_out OUT_OPEN
call /output/plot_out OUT_WRITE "time SomaVm somafura 1prim1fura 1sec1fura 1tert1fura 1tert2fura 2prim1fura 2sec1fura 2tert1fura 2tert2fura 3prim1fura 3sec1fura 3tert1fura 3tert2fura" //header	


// use randomspike to put inputs into NMDA and AMPA receptors 
int i=1
str path9
for(i=1;i<5;i=i+1)
	foreach path9({el {cellpath}/primdend{i}})
		makeinputpre {Hz} {path9}
	end
	reset
end


str path
int i=1
for(i=11;i<13;i=i+1)
	foreach path({el {cellpath}/secdend{i}})
		makeinputpre {Hz} {path}
	end
	reset
end
for(i=21;i<23;i=i+1)
	foreach path({el {cellpath}/secdend{i}})
		makeinputpre {Hz} {path}
	end
	reset
end
for(i=31;i<33;i=i+1)
	foreach path({el {cellpath}/secdend{i}})
		makeinputpre {Hz} {path}
	end
	reset
end
for(i=41;i<43;i=i+1)
	foreach path({el {cellpath}/secdend{i}})
		makeinputpre {Hz} {path}
	end
	reset
end


int j=1
int s=1
str path4
str path3
for(j=1;j<17;j=j+1)
	for(s=1;s<12;s=s+1)
		foreach path4({el {cellpath}/tertdend{j}_{s}})
			makeinputpre {Hz} {path4}
		end
	end
end

reset 
reset       // twice?


step 0.05 -time

str path1
str path2
str path5
str path8
int i=1
int x=1

for(i=1;i<5;i=i+1)
	foreach path8 ({el {cellpath}/primdend{i}})
		makeinputpost {cellpath}/primdend{i}/randomspike {path8}/AMPA
		makeinputpost {cellpath}/primdend{i}/randomspike {path8}/{subunit}
	end
end
int i=1
// sec 
for(i=11;i<13;i=i+1)
	foreach path1 ({el {cellpath}/secdend{i}})
		makeinputpost {cellpath}/secdend{i}/randomspike {path1}/AMPA
		makeinputpost {cellpath}/secdend{i}/randomspike {path1}/{subunit}
	end
end

for(i=21;i<23;i=i+1)
	foreach path1 ({el {cellpath}/secdend{i}})
		makeinputpost {cellpath}/secdend{i}/randomspike {path1}/AMPA
		makeinputpost {cellpath}/secdend{i}/randomspike {path1}/{subunit}
	end
end
for(i=31;i<33;i=i+1)
	foreach path1 ({el {cellpath}/secdend{i}})
		makeinputpost {cellpath}/secdend{i}/randomspike {path1}/AMPA
		makeinputpost {cellpath}/secdend{i}/randomspike {path1}/{subunit}
	end
end
for(i=41;i<43;i=i+1)
	foreach path1 ({el {cellpath}/secdend{i}})
		makeinputpost {cellpath}/secdend{i}/randomspike {path1}/AMPA
		makeinputpost {cellpath}/secdend{i}/randomspike {path1}/{subunit}
	end
end




j=1
int k=1
 // tert spines

for(j=1;j<17;j=j+1)
	for(k=1;k<12;k=k+1)
		foreach path2 ({el {cellpath}/tertdend{j}_{k}})
			makeinputpost {cellpath}/tertdend{j}_{k}/randomspike {path2}/AMPA
			//makeinputpost {cellpath}/tertdend{j}_{k}/randomspike {path2}/{subunit}
		end
	end
end

step {AP_time} -time
	
	//soma injection to get AP
	setfield {cellpath}/soma inject {1000e-12}

	step {AP_durtime} -time

	setfield {cellpath}/soma inject 0
	
step {{upstate_time}-{AP_time}-{AP_durtime}} -time


for(i=1;i<5;i=i+1)
	foreach path9 ({el {cellpath}/primdend{i}})
		stopinput {path9}/AMPA
		stopinput {path9}/{subunit}
	end
end

i=1 
x=1
// sec spines
for(i=11;i<13;i=i+1)
	foreach path1 ({el {cellpath}/secdend{i}})
		stopinput {path1}/AMPA
		stopinput {path1}/{subunit}
	end
end

for(i=21;i<23;i=i+1)
	foreach path1 ({el {cellpath}/secdend{i}})
		stopinput {path1}/AMPA
		stopinput {path1}/{subunit}
	end
end

for(i=31;i<33;i=i+1)
	foreach path1 ({el {cellpath}/secdend{i}})
		stopinput {path1}/AMPA
		stopinput {path1}/{subunit}
	end
end
for(i=41;i<43;i=i+1)
	foreach path1 ({el {cellpath}/secdend{i}})
		stopinput {path1}/AMPA
		stopinput {path1}/{subunit}
	end
end
j=1
k=1
 // tert spines

for(j=1;j<17;j=j+1)
	for(k=1;k<12;k=k+1)
		foreach path2 ({el {cellpath}/tertdend{j}_{k}})
			stopinput {path2}/AMPA
			stopinput {path2}/{subunit}
		end
	end
end

step 0.4 -t


