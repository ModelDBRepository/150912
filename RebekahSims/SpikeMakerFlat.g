
str spiketypeFlat = "SpikeF1"

//F1 = glu *4; GABA *7

//these three functions used to provide synaptic input to neuron

function makeinputpreFlat(rate, path)
    str rate
    str path
    create randomspike {path}/randomspike
    setfield ^ min_amp 1.0 max_amp 1.0 rate {{rate}*{4}} reset 1 reset_value 0	
    create randomspike {path}/randomspike2
    setfield ^ min_amp 1.0 max_amp 1.0 rate {{rate}*{7}} reset 1 reset_value 0	
 end
	
function makeinputpostFlat(pathspike, path) 
	str path
	int msgnum
	addmsg {pathspike} {path} SPIKE
    	msgnum = {getfield {path} nsynapses} - 1
   	 setfield {path} \
  	 synapse[{msgnum}].weight 1 synapse[{msgnum}].delay 0
end


function stopinputFlat(path)
	str path
	deletemsg {path} 1 -incoming
end

function stopinput2Flat (path)
	str path
	deletemsg {path} 1 -incoming
end

function deletespikesFlat (path)
    str path
    delete {path}/randomspike
    delete {path}/randomspike2
end 

function makeallpreFlat (Hz)
	float Hz
	int i=1
	str path9
	for(i=1;i<5;i=i+1)
		foreach path9({el {cellpath}/primdend{i}})
			makeinputpreFlat {Hz} {path9}
		end
		reset
	end


	str path
	int i=1
	for(i=11;i<13;i=i+1)
		foreach path({el {cellpath}/secdend{i}})
			makeinputpreFlat {Hz} {path}
		end
		reset
	end
	for(i=21;i<23;i=i+1)
		foreach path({el {cellpath}/secdend{i}})
			makeinputpreFlat {Hz} {path}	
		end
		reset
	end
	for(i=31;i<33;i=i+1)
		foreach path({el {cellpath}/secdend{i}})
			makeinputpreFlat {Hz} {path}
		end
		reset
	end
	for(i=41;i<43;i=i+1)
		foreach path({el {cellpath}/secdend{i}})
			makeinputpreFlat {Hz} {path}
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
				makeinputpreFlat {Hz} {path4}
			end
		end
	end
	
	reset 
	reset       // twice?
	
end

function makeallpostFlat 
	str path1
	str path2
	str path5
	str path8
	int i=1
	int x=1

	for(i=1;i<5;i=i+1)
		foreach path8 ({el {cellpath}/primdend{i}})
			makeinputpostFlat {cellpath}/primdend{i}/randomspike {path8}/AMPA
			makeinputpostFlat {cellpath}/primdend{i}/randomspike {path8}/{subunit}
			makeinputpostFlat {cellpath}/primdend{i}/randomspike2 {path8}/GABA
		end
	end
	int i=1
	// sec 
	for(i=11;i<13;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			makeinputpostFlat {cellpath}/secdend{i}/randomspike {path1}/AMPA
			makeinputpostFlat {cellpath}/secdend{i}/randomspike {path1}/{subunit}
			makeinputpostFlat {cellpath}/secdend{i}/randomspike2 {path1}/GABA
		end
	end
	
	for(i=21;i<23;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			makeinputpostFlat {cellpath}/secdend{i}/randomspike {path1}/AMPA
			makeinputpostFlat {cellpath}/secdend{i}/randomspike {path1}/{subunit}
			makeinputpostFlat {cellpath}/secdend{i}/randomspike2 {path1}/GABA
		end
	end
	for(i=31;i<33;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			makeinputpostFlat {cellpath}/secdend{i}/randomspike {path1}/AMPA
			makeinputpostFlat {cellpath}/secdend{i}/randomspike {path1}/{subunit}
			makeinputpostFlat {cellpath}/secdend{i}/randomspike2 {path1}/GABA
		end
	end
	for(i=41;i<43;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			makeinputpostFlat {cellpath}/secdend{i}/randomspike {path1}/AMPA
			makeinputpostFlat {cellpath}/secdend{i}/randomspike {path1}/{subunit}
			makeinputpostFlat {cellpath}/secdend{i}/randomspike2 {path1}/GABA
		end
	end
		
	int j=1
	int k=1
	 // tert spines
		
	for(j=1;j<17;j=j+1)
		for(k=1;k<12;k=k+1)
			foreach path2 ({el {cellpath}/tertdend{j}_{k}})
				makeinputpostFlat {cellpath}/tertdend{j}_{k}/randomspike {path2}/AMPA
				makeinputpostFlat {cellpath}/tertdend{j}_{k}/randomspike {path2}/{subunit}
				makeinputpostFlat {cellpath}/tertdend{j}_{k}/randomspike2 {path2}/GABA
			end
		end
	end
end

function StopAllFlat
	str path1
	str path2
	str path5
	str path8
	str path9
	int i
	for(i=1;i<5;i=i+1)
		foreach path9 ({el {cellpath}/primdend{i}})
			stopinputFlat {path9}/AMPA
			stopinputFlat {path9}/{subunit}
			stopinput2Flat {path9}/GABA
		end
	end

	int i=1 
	int x=1
	// sec spines
	for(i=11;i<13;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			stopinputFlat {path1}/AMPA
			stopinputFlat {path1}/{subunit}
			stopinput2Flat {path1}/GABA
		end
	end
	
	for(i=21;i<23;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			stopinputFlat {path1}/AMPA
			stopinputFlat {path1}/{subunit}
			stopinput2Flat {path1}/GABA
		end
	end
	
	for(i=31;i<33;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			stopinputFlat {path1}/AMPA
			stopinputFlat {path1}/{subunit}
			stopinput2Flat {path1}/GABA	
		end
	end
	for(i=41;i<43;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			stopinputFlat {path1}/AMPA
			stopinputFlat {path1}/{subunit}
			stopinput2Flat {path1}/GABA
		end
	end
	int j=1
	int k=1
	 // tert spines
	
	for(j=1;j<17;j=j+1)
		for(k=1;k<12;k=k+1)
			foreach path2 ({el {cellpath}/tertdend{j}_{k}})
				stopinputFlat {path2}/AMPA
				stopinputFlat {path2}/{subunit}
				stopinput2Flat {path2}/GABA
			end
		end
	end
	
end
	
//deleting randomspike objects to prevent overwrite errors
 
function DeleteAllSpikesFlat
	int i
	str path9
	str path1
	str path2
	for(i=1;i<5;i=i+1)
		foreach path9 ({el {cellpath}/primdend{i}})
			deletespikesFlat {path9}
		end
	end
	
	int i=1 
	int x=1
	
	// sec spines
	for(i=11;i<13;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			deletespikesFlat {path1}
		end
	end
		
	for(i=21;i<23;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			deletespikesFlat {path1}
		end
	end
	
	for(i=31;i<33;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			deletespikesFlat {path1}
		end
	end
	for(i=41;i<43;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			deletespikesFlat {path1}
		end
	end
	int j=1
	int k=1
	 // tert spines
	
	for(j=1;j<17;j=j+1)
		for(k=1;k<12;k=k+1)
			foreach path2 ({el {cellpath}/tertdend{j}_{k}})
				deletespikesFlat {path2}
			end
		end
	end
end
		
		
				
