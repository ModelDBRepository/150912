//genesis
//MScellSyn.g
//This routine takes the MScell without synapses, and adds synapses

include MScell/MScellshort.g                 //MScell without synapses
include MScell/SynParamsCtx.g               //parameters on synaptic channels
include MScell/channels/nmda_channel.g   //function to make nmda channel, either GHK or not, in library
include MScell/channels/synaptic_channel.g // function to make non nmda synaptic channels in library
include MScell/AddSynapticChannels.g	// contains functions to add channels to compartments

function makeMScellSyn (cellname,pfile)
   str cellname,pfile

   str CompName

   make_MS_cell {cellname} {pfile}

	//************* create synaptic channels in library *********
	pushe /library

  	make_synaptic_channel  {AMPAname} {AMPAtau1} {AMPAtau2} {AMPAgmax} {EkAMPA} {AMPAdes} {AMPAdestau}
  	make_NMDA_channel    {NMDAname} {EkNMDA} {Kmg} {NMDAtau2} {NMDAgmax} {ghk_yesno} {NMDAdes} {NMDAdestau}
	make_synaptic_channel  {GABAname} {GABAtau1} {GABAtau2} {GABAgmax} {EkGABA} {0} {0}
        pope {cellname}
	
   //********************* end synaptic channels in library **************

      foreach CompName ({el {cellname}/##[TYPE=compartment]}) 
        addNMDAchannel {CompName} {NMDAname} {outermostshell} {NMDAgmax} {ghk_yesno}
        addSynChannel  {CompName} {AMPAname} {AMPAgmax} {outermostshell} 
        addSynChannel  {CompName} {GABAname} {GABAgmax}	{dummyshell} 
	//add_extra_pools {CompName} {NMDACaGHK}
/*
		create spikegen {CompName}/spikegen
		setfield {CompName}/spikegen thresh 10
		addmsg   {CompName}/spikegen  {CompName}/{NMDAname} SPIKE 
		addmsg   {CompName}/spikegen  {CompName}/{AMPAname} SPIKE 
		
		create neutral {CompName}/presyn_ext
		setfield {CompName}/presyn_ext z 0
		addmsg   {CompName}/presyn_ext  {CompName}/{NMDAname} ACTIVATION z 
		addmsg   {CompName}/presyn_ext  {CompName}/{AMPAname} ACTIVATION z 

		create neutral {CompName}/presyn_inh
		setfield {CompName}/presyn_inh z 0
		addmsg   {CompName}/presyn_inh  {CompName}/{GABAname} ACTIVATION z
 */    	
       end

	

end
