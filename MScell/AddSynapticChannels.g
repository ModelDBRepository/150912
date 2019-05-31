//genesis

/***************************		MS Model, Version 9.4	**********************
**************************** 	     AddSynapticChannels.g 	**********************

******************************************************************************/


function addNMDAchannel(compPath, chanpath,caBuffer, gbar, ghk)

  str compPath, chanpath
  float gbar
  str caBuffer 
  int ghk

  copy /library/{chanpath} {compPath}/{chanpath}
  addmsg {compPath} {compPath}/{chanpath}/block VOLTAGE Vm
  addmsg {compPath} {compPath}/{chanpath} VOLTAGE Vm
  addmsg {compPath}/{chanpath}/block {compPath} CHANNEL Gk Ek
  

  if (ghk==1)
    addmsg {compPath} {compPath}/{chanpath}/GHK VOLTAGE Vm
  end

  // Set the new conductance
  float len = {getfield {compPath} len}
  float dia = {getfield {compPath} dia}
  float pi = 3.141592653589793
  float surf = {len*dia*pi}

/*
    echo "XXXXXXXXXXXXXXX addNMDAchannel XXXXXXXXXXXXXXXX"
	echo "compPath = "{compPath}
	echo "chanpath = "{chanpath}
	echo "caBuffer = "{caBuffer}
	echo "gbar = "{gbar}
	echo "NMDACaGHK=" {NMDACaGHK}
	echo "XXXXXXXXXXXXXXX addNMDAchannel XXXXXXXXXXXXXXXX"
*/

  setfield {compPath}/{chanpath} gmax {gbar}



//while the block object always controls the voltage, either the block object or the ghk object controls the calcium. 
//ghk_yesno set in SynParams.g
// adds NMDA to Ca buffer in difshell or concen 
	if (ghk==0)
		if ({isa difshell  {compPath}/{caBuffer}} )         // dif_shell 
	 		addmsg {compPath}/{chanpath}/block {compPath}/{caBuffer} FINFLUX Ik {NMDAperCa}  //set in SynParams.g
		elif ({isa Ca_concen {compPath}/{caBuffer}})      // Ca_conc
			addmsg {compPath}/{chanpath}/block {compPath}/{caBuffer} fI_Ca Ik {NMDAperCa}		end
	elif (ghk==1)
		if ({isa difshell  {compPath}/{caBuffer}})         // dif_shell 
	 		addmsg {compPath}/{chanpath}/GHK {compPath}/{caBuffer} FINFLUX Ik {NMDACaGHK}  //set in SynParams.g
			addmsg {compPath}/{caBuffer} {compPath}/{chanpath}/GHK CIN C
		elif ({isa Ca_concen {compPath}/{caBuffer}})      // Ca_conc
			addmsg {compPath}/{chanpath}/GHK {compPath}/{caBuffer} fI_Ca Ik {NMDACaGHK}  //0.35e-8 is necessary because GHK reads in Gk from block and interprets it as permeability.  this results in calcium that is ridiculous. a factor of e-9 reduces calcium back to normal levels. 
			addmsg {compPath}/{caBuffer} {compPath}/{chanpath}/GHK CIN Ca		end
	end

end


function addSynChannel (compPath, chanpath, gbar, caBuffer)

  str compPath, chanpath, caBuffer
  float gbar

  copy /library/{chanpath} {compPath}/{chanpath}

  addmsg {compPath} {compPath}/{chanpath} VOLTAGE Vm
  addmsg {compPath}/{chanpath} {compPath} CHANNEL Gk Ek

  // Set the new conductance
  float len = {getfield {compPath} len}
  float dia = {getfield {compPath} dia}
  float pi = 3.141592653589793
  float surf = {len*dia*pi}

/*	echo "XXXXXXXXXXXXXXX addSynChannel XXXXXXXXXXXXXXXX"
	echo "compPath = "{compPath}
	echo "chanpath = "{chanpath}
	echo "gbar = "{gbar}
	echo "XXXXXXXXXXXXXXX addSynchannel XXXXXXXXXXXXXXXX"
*/

//  setfield {compPath}/{chanName} gmax {surf*gbar}
  setfield {compPath}/{chanpath} gmax {gbar}
  
  if ({chanpath} == "AMPA")
	if ({NMDABufferMode == 1} && {isa difshell {compPath}/{caBuffer}}) 
		//echo spine calcium model is difshell
		addmsg {compPath}/{chanpath} {compPath}/{caBuffer} FINFLUX Ik {AMPACaper}
	end
  end
end
 
 
