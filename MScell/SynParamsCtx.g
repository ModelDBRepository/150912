//genesis
//SynParams.g

	str AMPAname = "AMPA"
	float EkAMPA = 0.0
        float AMPAtau1 = 1.1e-3   //wolf with qfact of 2 taken into account (t1 and t2)
        float AMPAtau2 = 5.75e-3  
        float AMPAgmax = 0.171e-9 //0.342e-9  25%or 50% Gsyn for shindou test//593e-12 I changed this to make the NMDA/AMPA ratio more like 2.75/1 which is what Ding 2008 finds int corticalstriatal synapses
	float AMPACaper = 0 //0.001 //percent AMPA conductance that is carried by calcium. value from wolf							//more like 2/1 for thalamus so should be 0.47e-9 for thalamo-striatal syanpnse if NMDA is 0.94e-9 Rebekah Evans 6/25/10
	float AMPAdes = 1 // 1  		//desensitization factor, (depr_per_spike field of facsynchan)
	float AMPAdestau = 100e-3 // 100e-3	// desensitixation t (how fast des recovers)


        str GABAname = "GABA"
        float GABAtau1 = 0.25e-3    // From Galarreta and Hestrin 1997 
        float GABAtau2 = 3.75e-3    //(used in Wolfs model)
        float EkGABA = -0.060  		//calculated Kerr and Plenz 2004 Erev for Cl, is -60 mV 5/2/12 RCE
        float GABAgmax = 900e-12  //was 750, Sri uses 900 //Modified Koos 2004 (Wolf uses 435e-12)

	int GABA2Spine = 0                                // = 0, No GABA; 
                                                  //   1, add GABA to spine head
                                                  //   2, add GABA to spine neck
	
	int addCa2Spine = 1		// 0, no ca channels in spine, 
					//1, yes ca channels in spine (non-synaptic)
	int ghk_yesno=1  //0 no ghk objects for NMDA, 1 add ghk to NMDA 
			 //ghk reduction factor and hoook ups to calcium shells are in Addsynapticchannels.g


setclock 0 5e-6 //was 5e-6
        // Simulation time step (Second)       
setclock 1 2e-5        //  time step for ascii output
//setclock 1 1e-4 // time step for graphic output


// parameters for NMDA subunits


// cortex
str	    subunit = "NR2A" // A= 50e-3, ctx = 112e-3 B=300e-3 taus
float   EkNMDA   = 0
float	Kmg       = 18 //18 new //3.57 old overwrites 1/eta in nmda_channel.g
float	NMDAtau2      = {(50e-3)/2} //FAST// {(112.5e-3)/2}:	ctx avg for .25 NR2B and .75 NR2A.  (300e-3)/2 (NR2B) (50e-3)/2 (NR2A) 75+37.5 = 112.5
float	NMDAgmax   = {0.47e-9} //0.94e-9 NR2A and B from (Moyner et al., 1994 figure 7)
float   NMDAperCa = 0.00 //HIGH// 0.05: percent calcium influx 
float 	NMDAfactGHK = 35e-9 	//adjustment factor for GHK to calcium shell/pool
float   NMDACaGHK = {{NMDAperCa}*{NMDAfactGHK}}
float   NMDAdes = 0 //1  		//desensitization factor, (depr_per_spike field of facsynchan)
float   NMDAdestau = 0 //200e-3	// desensitixation t (how fast des recovers)


str NMDAname = {subunit}
str outermostshell = "Ca_difshell_1"
str dummyshell = "stupid"

//for saving info on distal or proximal dendrites or massed and spaced. formula typeof dend, # of spines.
