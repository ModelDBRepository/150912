


/****************begin local subroutines*************/
function add_output
	create asc_file /output/plot_out
	setfield /output/plot_out   flush 1  leave_open 1 append 1 \
          float_format %0.6g
    useclock /output/plot_out 1
	addmsg /cell/soma /output/plot_out  SAVE Vm

	addmsg /cell/tertdend1_1/fluorescence /output/plot_out SAVE ratio
	
	addmsg /cell/tertdend2_1/fluorescence /output/plot_out SAVE ratio
	
	addmsg /cell/tertdend3_1/fluorescence /output/plot_out SAVE ratio

	addmsg /cell/tertdend1_1/NR2A/GHK /output/plot_out SAVE Ik
	addmsg /cell/tertdend1_1/NR2A/block /output/plot_out SAVE Ik
	addmsg /cell/tertdend2_1/NR2A/GHK /output/plot_out SAVE Ik
	addmsg /cell/tertdend2_1/NR2A/block /output/plot_out SAVE Ik
	addmsg /cell/tertdend3_1/NR2A/GHK /output/plot_out SAVE Ik
	addmsg /cell/tertdend3_1/NR2A/block /output/plot_out SAVE Ik


end



//these three functions used to provide synaptic input to neuron

function makeinputpre(rate, path)
    str rate
    str path
    create randomspike {path}/randomspike
    setfield ^ min_amp 1.0 max_amp 1.0 rate {rate} reset 1 reset_value 0	
    create randomspike {path}/randomspike2
    setfield ^ min_amp 1.0 max_amp 1.0 rate {{rate}*{2}} reset 1 reset_value 0	
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

add_output

int Hz = 15  //for glu, function incrases by 2.5 this for GABA
float upstate_time = 0.3
float AP_time = 0.1  //AP latency from upstate onset
float AP_durtime = 0.002 //duration of AP depolarization at soma, 5 ms

str cellpath = "/cell"
str stimtype = "AP100"
diskpath={diskpath}@(stimtype)@".txt"
echo {diskpath}
setfield /output/plot_out filename output/{diskpath}
reset

call /output/plot_out OUT_OPEN
call /output/plot_out OUT_WRITE "time SomaVm  1tert1fura 2tert1fura 3tert1fura GHK1 block1 GHK2 block2 GHK3 block3" //header	


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
		makeinputpost {cellpath}/primdend{i}/randomspike2 {path8}/GABA
	end
end
int i=1
// sec 
for(i=11;i<13;i=i+1)
	foreach path1 ({el {cellpath}/secdend{i}})
		makeinputpost {cellpath}/secdend{i}/randomspike {path1}/AMPA
		makeinputpost {cellpath}/secdend{i}/randomspike {path1}/{subunit}
		makeinputpost {cellpath}/secdend{i}/randomspike2 {path1}/GABA
	end
end

for(i=21;i<23;i=i+1)
	foreach path1 ({el {cellpath}/secdend{i}})
		makeinputpost {cellpath}/secdend{i}/randomspike {path1}/AMPA
		makeinputpost {cellpath}/secdend{i}/randomspike {path1}/{subunit}
		makeinputpost {cellpath}/secdend{i}/randomspike2 {path1}/GABA
	end
end
for(i=31;i<33;i=i+1)
	foreach path1 ({el {cellpath}/secdend{i}})
		makeinputpost {cellpath}/secdend{i}/randomspike {path1}/AMPA
		makeinputpost {cellpath}/secdend{i}/randomspike {path1}/{subunit}
		makeinputpost {cellpath}/secdend{i}/randomspike2 {path1}/GABA
	end
end
for(i=41;i<43;i=i+1)
	foreach path1 ({el {cellpath}/secdend{i}})
		makeinputpost {cellpath}/secdend{i}/randomspike {path1}/AMPA
		makeinputpost {cellpath}/secdend{i}/randomspike {path1}/{subunit}
		makeinputpost {cellpath}/secdend{i}/randomspike2 {path1}/GABA
	end
end




j=1
int k=1
 // tert spines

for(j=1;j<17;j=j+1)
	for(k=1;k<12;k=k+1)
		foreach path2 ({el {cellpath}/tertdend{j}_{k}})
			makeinputpost {cellpath}/tertdend{j}_{k}/randomspike {path2}/AMPA
			makeinputpost {cellpath}/tertdend{j}_{k}/randomspike {path2}/{subunit}
			makeinputpost {cellpath}/tertdend{j}_{k}/randomspike2 {path2}/GABA
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
		stopinput {path9}/GABA
	end
end

i=1 
x=1
// sec spines
for(i=11;i<13;i=i+1)
	foreach path1 ({el {cellpath}/secdend{i}})
		stopinput {path1}/AMPA
		stopinput {path1}/{subunit}
		stopinput {path1}/GABA
	end
end

for(i=21;i<23;i=i+1)
	foreach path1 ({el {cellpath}/secdend{i}})
		stopinput {path1}/AMPA
		stopinput {path1}/{subunit}
		stopinput {path1}/GABA
	end
end

for(i=31;i<33;i=i+1)
	foreach path1 ({el {cellpath}/secdend{i}})
		stopinput {path1}/AMPA
		stopinput {path1}/{subunit}
		stopinput {path1}/GABA	
	end
end
for(i=41;i<43;i=i+1)
	foreach path1 ({el {cellpath}/secdend{i}})
		stopinput {path1}/AMPA
		stopinput {path1}/{subunit}
		stopinput {path1}/GABA
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
			stopinput {path2}/GABA
		end
	end
end

step 0.2 -t


