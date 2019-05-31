

str spiketype = "spke4"

//1: high=*50, med =*1, low =/1.5, gaba = *2
//2: high=*40, med =*1, low =/1.5, gaba = *2
//3: high=*40, med =*1, low =/1.5, gaba = *3
//4: high=*40, med =*1, low =/1.5, gaba = *4
//5: high=*60, med =/2, low =/5, gaba = *4
//6: high=*30, med =*1, low =/1.5, gaba = *4


//****start local subroutines

function makeinputpre(rate, path)
    str rate
    str path
    create randomspike {path}/randomspikehigh
    setfield ^ min_amp 1.0 max_amp 1.0 rate {{rate}*40} reset 1 reset_value 0	
    create randomspike {path}/randomspikemed
    setfield ^ min_amp 1.0 max_amp 1.0 rate {{rate}} reset 1 reset_value 0	
    create randomspike {path}/randomspikelow
    setfield ^ min_amp 1.0 max_amp 1.0 rate {{rate}/1.5} reset 1 reset_value 0	
    create randomspike {path}/randomspike2
    setfield ^ min_amp 1.0 max_amp 1.0 rate {{rate}*4} reset 1 reset_value 0	
 end
	
function makeinputpost(pathspike, path) 
	str path
	int msgnum
	addmsg {pathspike} {path} SPIKE
    	msgnum = {getfield {path} nsynapses} - 1
   	setfield {path} \
  	synapse[{msgnum}].weight 1 synapse[{msgnum}].delay 0
end


function stopinput (path)
	str path
	deletemsg {path} 2 -incoming
end

function stopinput2 (path)
	str path
	deletemsg {path} 1 -incoming
end

//***end local subroutines 

//***start main functions


function makeALLpre (Hz)
	float Hz
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
	
end

function makeALLpost (freq)
	str freq
	str path1
	str path2
	str path5
	str path8
	int i=1
	int x=1
	
	for(i=1;i<5;i=i+1)
		foreach path8 ({el {cellpath}/primdend{i}})
			makeinputpost {cellpath}/primdend{i}/randomspike{freq} {path8}/AMPA
			makeinputpost {cellpath}/primdend{i}/randomspike{freq} {path8}/{subunit}
			makeinputpost {cellpath}/primdend{i}/randomspike2 {path8}/GABA
		end
	end
	int i=1
	// sec 
	for(i=11;i<13;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			makeinputpost {cellpath}/secdend{i}/randomspike{freq} {path1}/AMPA
			makeinputpost {cellpath}/secdend{i}/randomspike{freq} {path1}/{subunit}
			makeinputpost {cellpath}/secdend{i}/randomspike2 {path1}/GABA
		end
	end

	for(i=21;i<23;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			makeinputpost {cellpath}/secdend{i}/randomspike{freq} {path1}/AMPA
			makeinputpost {cellpath}/secdend{i}/randomspike{freq} {path1}/{subunit}
			makeinputpost {cellpath}/secdend{i}/randomspike2 {path1}/GABA
		end
	end
	for(i=31;i<33;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			makeinputpost {cellpath}/secdend{i}/randomspike{freq} {path1}/AMPA
			makeinputpost {cellpath}/secdend{i}/randomspike{freq} {path1}/{subunit}
			makeinputpost {cellpath}/secdend{i}/randomspike2 {path1}/GABA
		end
	end
	for(i=41;i<43;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			makeinputpost {cellpath}/secdend{i}/randomspike{freq} {path1}/AMPA
			makeinputpost {cellpath}/secdend{i}/randomspike{freq} {path1}/{subunit}
			makeinputpost {cellpath}/secdend{i}/randomspike2 {path1}/GABA
		end
	end

	int j=1
	int k=1
	 // tert spines
	
	for(j=2;j<17;j=j+1)
		for(k=2;k<12;k=k+1)
			foreach path2 ({el {cellpath}/tertdend{j}_{k}})
				makeinputpost {cellpath}/tertdend{j}_{k}/randomspike{freq} {path2}/AMPA
				makeinputpost {cellpath}/tertdend{j}_{k}/randomspike{freq} {path2}/{subunit}
			end
		end
	end
	for(j=1;j<17;j=j+1)
		for(k=1;k<12;k=k+1)
			foreach path2 ({el {cellpath}/tertdend{j}_{k}})
				makeinputpost {cellpath}/tertdend{j}_{k}/randomspike2 {path2}/GABA
			end
		end
	end
end

function stopGlu
	int i
	str path1
	str path2
	str path9
	for(i=1;i<5;i=i+1)
		foreach path9 ({el {cellpath}/primdend{i}})
			stopinput {path9}/AMPA
			stopinput {path9}/{subunit}
		end
	end
	
	int i=1 
	int x=1
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
	int j=1
	int k=1
	 // tert spines
	
	for(j=2;j<17;j=j+1)
		for(k=2;k<12;k=k+1)
			foreach path2 ({el {cellpath}/tertdend{j}_{k}})
				stopinput {path2}/AMPA
				stopinput {path2}/{subunit}
			end
		end
	end
end
	
function stopGABA
	int i
	str path1
	str path2
	str path9
	for(i=1;i<5;i=i+1)
		foreach path9 ({el {cellpath}/primdend{i}})
			stopinput2 {path9}/GABA
		end
	end
	
	int x=1
	// sec spines
	for(i=11;i<13;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			stopinput2 {path1}/GABA
		end
	end
	
	for(i=21;i<23;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			stopinput2 {path1}/GABA
		end
	end
	
	for(i=31;i<33;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			stopinput2 {path1}/GABA
		end
	end
	for(i=41;i<43;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			stopinput2 {path1}/GABA
		end
	end
	int j=1
	int k=1
	 // tert spines
	
	for(j=1;j<17;j=j+1)
		for(k=1;k<12;k=k+1)
			foreach path2 ({el {cellpath}/tertdend{j}_{k}})
				stopinput2 {path2}/GABA
			end
		end
	end
end

		
