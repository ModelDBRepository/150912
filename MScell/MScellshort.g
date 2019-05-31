//genesis


/***************************		MS Model, Version 8	*********************
**************************** 	      MScellqfact.g 	*********************
	Avrama Blackwell 	kblackw1@gmu.edu
	Wonryull Koh		wkoh1@gmu.edu
	Rebekah Evans 		rcolema2@gmu.edu
	Sriram 			dsriraman@gmail.com	
******************************************************************************

******************************************************************************************************
	MS_cell.g has only one externally called function: make_MS_cell. That primary 
	function uses the services of the following two local subroutines:
		set_position
		add_channels

******************************************************************************/

include MScell/globals  		// Defines & initializes cell specific parameters
include MScell/Ca_constants.g
include MScell/proto  // provides access to make_prototypes (and individual channels) 
include MScell/addchans	// provides access to add_uniform_channel & add_CaShells 
include MScell/CaDifshell.g        
    	
//************************ Begin Local Subroutines ****************************
//*****************************************************************************

	//************************ Begin function set_position *********************
	//**************************************************************************
	function set_position (cellpath)
		//********************* Begin Local Variables ************************
 		str compt, cellpath
 		float dist2soma,x,y,z
 		//********************* End Local Variables *****************************
 		
 		if (!{exists {cellpath}})
  			echo The current input {cellpath} does not exist (set_position) 
  			return
 		end
 
 		foreach compt ({el {cellpath}/##[TYPE=compartment]})
     		  x={getfield {compt} x}
     		  y={getfield {compt} y}
     		  z={getfield {compt} z}
     		  dist2soma={sqrt {({pow {x} 2 }) + ({pow {y} 2}) + ({pow {z} 2})} }  
     		  setfield {compt} position {dist2soma}
   	        end
	end
	//************************ End function set_position ***********************
	//**************************************************************************

	//************************ Begin function add_channels *********************
	//**************************************************************************
	function add_channels (cellpath)
         str cellpath
	
		/* add_uniform_channel (from addchans.g)
					channel_Name	a    		b 	density	  channeltype - VC for calcium permeable, KC for calcium dep*/

		// Naf in the soma 
		add_uniform_channel "NaF_channel"   0      {somaLen}	{gNaFsoma} {cellpath} "V"
		// Naf in the dendrites
		add_uniform_channel "NaFd_channel"   {somaLen} {mid} 	{gNaFprox}  {cellpath} "V"
		add_uniform_channel "NaFd_channel"   {mid}  {dist} 	{gNaFdist}  {cellpath} "V"  

		// potassium channels
		add_uniform_channel "KAf_channel"   0      {somaLen}	{gKAfsoma} {cellpath} "V"
		add_uniform_channel "KAf_channel"   {somaLen} {dist}	{gKAfdend}   {cellpath} "V"  
		
		add_uniform_channel "KAs_channel"  0       {somaLen}	{gKAssoma} {cellpath}  "V" 
		add_uniform_channel "KAs_channel"  {somaLen}  {dist} 	{gKAsdend} {cellpath} "V"
    
		
		//note that these two channels don't have distance dependent  conductances
		add_uniform_channel "KIR_channel"   0        {somaLen}	 {gKIRsoma}  {cellpath} "V"
		add_uniform_channel "KIR_channel"   {somaLen}  {dist}	 {gKIRdend}  {cellpath} "V"

  		add_uniform_channel "Krp_channel"    0        {somaLen}     {gKrpsoma}  {cellpath} "V"
		add_uniform_channel "Krp_channel"    {somaLen}  {dist}     {gKrpdend}  {cellpath} "V"

		
 echo "add VGCC"
		add_uniform_channel "CaR_channel" 		0 	{somaLen}  {gCaRsoma} {cellpath} "VC"
		add_uniform_channel "CaR_channel" 		{somaLen} 	{dist}  {gCaRdend} {cellpath} "VC"
 
		add_uniform_channel "CaN_channel" 		0 	{somaLen}  {gCaNsoma}  {cellpath} "VC"
		
		add_uniform_channel "CaL12_channel"     0 	{somaLen}  {gCaL12soma}  {cellpath} "VC"
		add_uniform_channel "CaL12_channel"     {somaLen} 	{dist}  {gCaL12dend}  {cellpath} "VC"
		
		add_uniform_channel "CaL13_channel" 	0 		{somaLen}  {gCaL13soma} {cellpath} "VC"
		add_uniform_channel "CaL13_channel" 	{somaLen} 	{mid}  {gCaL13dend} {cellpath} "VC"
		add_uniform_channel "CaL13_channel" 	{mid} 	{dist}  {gCaL13dend} {cellpath} "VC"
		
		add_uniform_channel "CaT_channel" 	{prox} 	{dist}  {gCaTdist} {cellpath} "VC"

echo "add KCa"
		add_uniform_channel "BK_channel" 		0 	{somaLen}	{gBKsoma} {cellpath} "KC"  
		add_uniform_channel "BK_channel" 		{somaLen}	{dist}	{gBKdend} {cellpath} "KC"  

		add_uniform_channel "SK_channel" 		0 	{somaLen} {gSKsoma} {cellpath} "KC"
		add_uniform_channel "SK_channel" 		{somaLen} 	{dist}  {gSKdend} {cellpath} "KC"

	end

 
	//************************ End function add_channels ***********************
	//**************************************************************************
//************************ End Local Subroutines ******************************
//*****************************************************************************

//************************ Begin Primary Routine ******************************
//*****************************************************************************

	//************************ Begin function make_MS_cell *********************
	//**************************************************************************
	function make_MS_cell (cellpath,pfile)
         str cellpath,pfile
         echo {cellpath}
 	// function make_MS_cell is the first call from the primary file (MSsim.g). 
	// Note that the first thing it does is to call make_protypes in proto.g. 
	// These prototypes must be made before the call to add_channels. 

		make_prototypes					//	see proto.g
//		readcell {pfile} {cellpath} -hsolve	//	see MScell.g
              readcell {pfile} {cellpath}
		set_position {cellpath}					// local call
//allow either the full calcium dynamics or the old single time constant of decay
        if (calciumtype==0)
		    add_caconcen_objects {CalciumName} {cellpath}
		    //make_extra_pools 0 500e-6 {cellpath} 
        else 
		// to be coupled with N/R Ca2+ channels 
            add_CaConcen {CA_BUFF_1}  0 500e-6   {cellpath} 
		// to be coupled with T/L Ca2+ channels 
            add_CaConcen {CA_BUFF_2}  0 500e-6  {cellpath} 
		// to be coupled with all Ca2+ channels    
            add_CaConcen {CA_BUFF_3}  0 500e-6   {cellpath}
        end

        echo "finished adding calcium"
		add_channels {cellpath}					// local call
		//SumGk {cellpath}/tertdend1_1  //SumGk in addchans.g
		//SumCa {cellpath}/tertdend1_1 //SumCa in addchans.g
	end	
	//************************ End function make_MS_cell ***********************
	//**************************************************************************			
//************************ End Primary Routine ********************************
//*****************************************************************************
