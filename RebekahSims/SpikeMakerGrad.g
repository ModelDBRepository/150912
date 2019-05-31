

str spiketypeGrad = "spke18"

//18: high=*50, med=*3, low=*1, gaba=*7
//19: high=*40, med=*5, low=*2, gaba=*7

//****start local subroutines

function makeinputpreGrad(rate, path)
    str rate
    str path
    create randomspike {path}/randomspikehigh
    setfield ^ min_amp 1.0 max_amp 1.0 rate {{rate}*50} reset 1 reset_value 0	
    create randomspike {path}/randomspikemed
    setfield ^ min_amp 1.0 max_amp 1.0 rate {{rate}*3} reset 1 reset_value 0	
    create randomspike {path}/randomspikelow
    setfield ^ min_amp 1.0 max_amp 1.0 rate {{rate}*1} reset 1 reset_value 0	
    create randomspike {path}/randomspike2
    setfield ^ min_amp 1.0 max_amp 1.0 rate {{rate}*7} reset 1 reset_value 0	
 end
	
function makeinputpostGrad(pathspike, path) 
	str path
	int msgnum
	addmsg {pathspike} {path} SPIKE
    	msgnum = {getfield {path} nsynapses} - 1
   	setfield {path} \
  	synapse[{msgnum}].weight 1 synapse[{msgnum}].delay 0
end


function stopinputGrad (path)
	str path
	deletemsg {path} 1 -incoming
end

function stopinput2Grad (path)
	str path
	deletemsg {path} 1 -incoming
end

function deletespikesGrad (path)
    str path
    delete {path}/randomspikehigh
    delete {path}/randomspikemed
    delete {path}/randomspikelow
    delete {path}/randomspike2
end    

//***end local subroutines 

//***start main functions


function makeALLpreGrad (Hz)
	float Hz
	int i=1
	str path9
	for(i=1;i<5;i=i+1)
		foreach path9({el {cellpath}/primdend{i}})
			makeinputpreGrad {Hz} {path9}
		end
		reset
	end

	str path
	int i=1
	for(i=11;i<13;i=i+1)
		foreach path({el {cellpath}/secdend{i}})
			makeinputpreGrad {Hz} {path}
		end
		reset
	end
	for(i=21;i<23;i=i+1)
		foreach path({el {cellpath}/secdend{i}})
			makeinputpreGrad {Hz} {path}
		end
		reset
	end
	for(i=31;i<33;i=i+1)
		foreach path({el {cellpath}/secdend{i}})
			makeinputpreGrad {Hz} {path}
		end
		reset
	end
	for(i=41;i<43;i=i+1)
		foreach path({el {cellpath}/secdend{i}})
			makeinputpreGrad {Hz} {path}
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
				makeinputpreGrad {Hz} {path4}
			end
		end
	end
	
	reset 
	reset       // twice?
	
end

function deleteALLspikesGrad 
	int i=1
	str path9
	for(i=1;i<5;i=i+1)
		foreach path9({el {cellpath}/primdend{i}})
			deletespikesGrad {path9}
		end
		reset
	end

	str path
	int i=1
	for(i=11;i<13;i=i+1)
		foreach path({el {cellpath}/secdend{i}})
			deletespikesGrad {path}
		end
		reset
	end
	for(i=21;i<23;i=i+1)
		foreach path({el {cellpath}/secdend{i}})
			deletespikesGrad {path}
		end
		reset
	end
	for(i=31;i<33;i=i+1)
		foreach path({el {cellpath}/secdend{i}})
			deletespikesGrad {path}
		end
		reset
	end
	for(i=41;i<43;i=i+1)
		foreach path({el {cellpath}/secdend{i}})
			deletespikesGrad {path}
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
				deletespikesGrad {path4}
			end
		end
	end
	
	reset 
	reset       // twice?	
end


function makeALLpostGrad (freq)
	str freq
	str path1
	str path2
	str path5
	str path8
	int i=1
	int x=1
	
	for(i=1;i<5;i=i+1)
		foreach path8 ({el {cellpath}/primdend{i}})
			makeinputpostGrad {cellpath}/primdend{i}/randomspike{freq} {path8}/AMPA
			makeinputpostGrad {cellpath}/primdend{i}/randomspike{freq} {path8}/{subunit}
			makeinputpostGrad {cellpath}/primdend{i}/randomspike2 {path8}/GABA
		end
	end
	int i=1
	// sec 
	for(i=11;i<13;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			makeinputpostGrad {cellpath}/secdend{i}/randomspike{freq} {path1}/AMPA
			makeinputpostGrad {cellpath}/secdend{i}/randomspike{freq} {path1}/{subunit}
			makeinputpostGrad {cellpath}/secdend{i}/randomspike2 {path1}/GABA
		end
	end

	for(i=21;i<23;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			makeinputpostGrad {cellpath}/secdend{i}/randomspike{freq} {path1}/AMPA
			makeinputpostGrad {cellpath}/secdend{i}/randomspike{freq} {path1}/{subunit}
			makeinputpostGrad {cellpath}/secdend{i}/randomspike2 {path1}/GABA
		end
	end
	for(i=31;i<33;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			makeinputpostGrad {cellpath}/secdend{i}/randomspike{freq} {path1}/AMPA
			makeinputpostGrad {cellpath}/secdend{i}/randomspike{freq} {path1}/{subunit}
			makeinputpostGrad {cellpath}/secdend{i}/randomspike2 {path1}/GABA
		end
	end
	for(i=41;i<43;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			makeinputpostGrad {cellpath}/secdend{i}/randomspike{freq} {path1}/AMPA
			makeinputpostGrad {cellpath}/secdend{i}/randomspike{freq} {path1}/{subunit}
			makeinputpostGrad {cellpath}/secdend{i}/randomspike2 {path1}/GABA
		end
	end

	int j=1
	int k=1
	 // tert spines
	
	for(j=1;j<17;j=j+1)
		for(k=1;k<12;k=k+1)
			foreach path2 ({el {cellpath}/tertdend{j}_{k}})
				makeinputpostGrad {cellpath}/tertdend{j}_{k}/randomspike{freq} {path2}/AMPA
				makeinputpostGrad {cellpath}/tertdend{j}_{k}/randomspike{freq} {path2}/{subunit}
				makeinputpostGrad {cellpath}/tertdend{j}_{k}/randomspike2 {path2}/GABA
			end
		end
	end
end

function makeGLUpostGrad (freq)
	str freq
	str path1
	str path2
	str path5
	str path8
	int i=1
	int x=1
	
	for(i=1;i<5;i=i+1)
		foreach path8 ({el {cellpath}/primdend{i}})
			makeinputpostGrad {cellpath}/primdend{i}/randomspike{freq} {path8}/AMPA
			makeinputpostGrad {cellpath}/primdend{i}/randomspike{freq} {path8}/{subunit}
		end
	end
	int i=1
	// sec 
	for(i=11;i<13;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			makeinputpostGrad {cellpath}/secdend{i}/randomspike{freq} {path1}/AMPA
			makeinputpostGrad {cellpath}/secdend{i}/randomspike{freq} {path1}/{subunit}
		end
	end

	for(i=21;i<23;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			makeinputpostGrad {cellpath}/secdend{i}/randomspike{freq} {path1}/AMPA
			makeinputpostGrad {cellpath}/secdend{i}/randomspike{freq} {path1}/{subunit}
		end
	end
	for(i=31;i<33;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			makeinputpostGrad {cellpath}/secdend{i}/randomspike{freq} {path1}/AMPA
			makeinputpostGrad {cellpath}/secdend{i}/randomspike{freq} {path1}/{subunit}
		end
	end
	for(i=41;i<43;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			makeinputpostGrad {cellpath}/secdend{i}/randomspike{freq} {path1}/AMPA
			makeinputpostGrad {cellpath}/secdend{i}/randomspike{freq} {path1}/{subunit}
		end
	end

	int j=1
	int k=1
	 // tert spines
	
	for(j=1;j<17;j=j+1)
		for(k=1;k<12;k=k+1)
			foreach path2 ({el {cellpath}/tertdend{j}_{k}})
				makeinputpostGrad {cellpath}/tertdend{j}_{k}/randomspike{freq} {path2}/AMPA
				makeinputpostGrad {cellpath}/tertdend{j}_{k}/randomspike{freq} {path2}/{subunit}
			end
		end
	end
end


function makeGABApostGrad (freq)
	str freq
	str path1
	str path2
	str path5
	str path8
	int i=1
	int x=1
	
	for(i=1;i<5;i=i+1)
		foreach path8 ({el {cellpath}/primdend{i}})
			makeinputpostGrad {cellpath}/primdend{i}/randomspike2 {path8}/GABA
		end
	end
	int i=1
	// sec 
	for(i=11;i<13;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			makeinputpostGrad {cellpath}/secdend{i}/randomspike2 {path1}/GABA
		end
	end

	for(i=21;i<23;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			makeinputpostGrad {cellpath}/secdend{i}/randomspike2 {path1}/GABA
		end
	end
	for(i=31;i<33;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			makeinputpostGrad {cellpath}/secdend{i}/randomspike2 {path1}/GABA
		end
	end
	for(i=41;i<43;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			makeinputpostGrad {cellpath}/secdend{i}/randomspike2 {path1}/GABA
		end
	end

	int j=1
	int k=1
	 // tert spines
	
	for(j=1;j<17;j=j+1)
		for(k=1;k<12;k=k+1)
			foreach path2 ({el {cellpath}/tertdend{j}_{k}})
				makeinputpostGrad {cellpath}/tertdend{j}_{k}/randomspike2 {path2}/GABA
			end
		end
	end
end

function stopGluGrad
	int i
	str path1
	str path2
	str path9
	for(i=1;i<5;i=i+1)
		foreach path9 ({el {cellpath}/primdend{i}})
			stopinputGrad {path9}/AMPA
			stopinputGrad {path9}/{subunit}
		end
	end
	
	int i=1 
	int x=1
	// sec spines
	for(i=11;i<13;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			stopinputGrad {path1}/AMPA
			stopinputGrad {path1}/{subunit}
		end
	end
	
	for(i=21;i<23;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			stopinputGrad {path1}/AMPA
			stopinputGrad {path1}/{subunit}
		end
	end
	
	for(i=31;i<33;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			stopinputGrad {path1}/AMPA
			stopinputGrad {path1}/{subunit}
		end
	end
	for(i=41;i<43;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			stopinputGrad {path1}/AMPA
			stopinputGrad {path1}/{subunit}
		end
	end
	int j=1
	int k=1
	 // tert spines
	
	for(j=1;j<17;j=j+1)
		for(k=1;k<12;k=k+1)
			foreach path2 ({el {cellpath}/tertdend{j}_{k}})
				stopinputGrad {path2}/AMPA
				stopinputGrad {path2}/{subunit}
			end
		end
	end
end
	
function stopGABAGrad
	int i
	str path1
	str path2
	str path9
	for(i=1;i<5;i=i+1)
		foreach path9 ({el {cellpath}/primdend{i}})
			stopinput2Grad {path9}/GABA
		end
	end
	
	int x=1
	// sec spines
	for(i=11;i<13;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			stopinput2Grad {path1}/GABA
		end
	end
	
	for(i=21;i<23;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			stopinput2Grad {path1}/GABA
		end
	end
	
	for(i=31;i<33;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			stopinput2Grad {path1}/GABA
		end
	end
	for(i=41;i<43;i=i+1)
		foreach path1 ({el {cellpath}/secdend{i}})
			stopinput2Grad {path1}/GABA
		end
	end
	int j=1
	int k=1
	 // tert spines
	
	for(j=1;j<17;j=j+1)
		for(k=1;k<12;k=k+1)
			foreach path2 ({el {cellpath}/tertdend{j}_{k}})
				stopinput2Grad {path2}/GABA
			end
		end
	end
end

		
