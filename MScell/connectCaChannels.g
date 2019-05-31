//genesis

/***************************		MS Model, Version 9.1	*********************
**************************** 	  		connectCaChannels.g		*********************

******************************************************************************
******************************************************************************/

function coupleCaPoolCaChannel(bufferName, compPath, caChannelName)

  str bufferName
  str compPath
  str caChannelName

  pushe {compPath}

  if({isa difshell {compPath}/{bufferName}})
    addmsg {caChannelName}GHK {bufferName} INFLUX Ik 
    addmsg {bufferName} {caChannelName}GHK CIN C
  elif({isa Ca_concen {compPath}/{bufferName}})
    addmsg {caChannelName}GHK {bufferName} I_Ca Ik 
    addmsg {bufferName} {caChannelName}GHK CIN Ca  
  end

  pope {compPath}

end


function addCaChannel(channelName, compPath, conductance, caBufferName)

  str channelName, compPath
  float conductance
  str caBufferName

  pushe {compPath}

    // Copy the GHK part of the channel from library
    copy /library/{channelName}GHK {channelName}GHK

    coupleCaPoolCaChannel {caBufferName} {compPath} {channelName}

    // Couple channel, its GHK object and compartment together
    addmsg {compPath} {channelName}GHK VOLTAGE Vm
    addmsg {channelName}GHK {compPath} CHANNEL Gk Ek
    addmsg {channelName} {channelName}GHK PERMEABILITY Gk

  pope

end

