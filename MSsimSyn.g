                       //genesis
// MSsim.g 

/***************************		MS Model, Version 9.1	***************
*******************************************************************************
****************************** Begin includes *******************************/

str 	neuronname = "/cell"
str pfile="MScell/MScelltapershortCM3noproto.p" //thickdends
include MScell/MScellSyn	// access make_MS_cell this function is only called from MSsim.g
include graphics7		        // access functions make_control & make_graph
include RebekahSims/Store_Parameters.g
			     
// These two functions are only called from MSsimSyn.g
/****************************** End includes *********************************/
float outputclock=2e-5

	setclock 0 5e-6   // Simulation time step (Second)       
	setclock 1 {outputclock}

	makeMScellSyn {neuronname} {pfile}	// MS_cell.g

	reset

/* these graphics no longer work because of some globals and cell names
 * need to edit to pass in neuronname, etc. But, would be better to write to file. */
//	make_control		// graphics.g


	 make_graph {neuronname}		// graphics.g
		
/*uncomment the following lines (and one line in MScell.g) to use the hsolver
        setfield  {neuronname}  chanmode 1 
        call {neuronname} SETUP
        setmethod 11
*/	
	reset

/****************************** End MSsimSyn.g **********************************/
str diskpath1="11.008NaFda1g1noCaT"

//Store_Parameters

//set random seed so for each simulation the randomspike train will be the same
randseed 5757538

//3 = 5757538
//5 = 9824501
//4 = 2394075
//6 = 492
//7 = 2370


setfield /data/soma overlay 1
setfield /data/spineVm overlay 1
setfield /data/spineCa overlay 1
setfield /data/Ca overlay 1

include RebekahSims/if2.g

//include RebekahSims/USnoAP.g
randseed 5757538
//include RebekahSims/US5.g
randseed 5757538
//include RebekahSims/US10.g
randseed 5757538
//include RebekahSims/US20.g
randseed 5757538
//include RebekahSims/US30.g
randseed 5757538
//include RebekahSims/US50.g
randseed 5757538
//include RebekahSims/US100.g
randseed 5757538
//include RebekahSims/US175.g
randseed 5757538
//include RebekahSims/US290.g
randseed 5757538
//include RebekahSims/USnoAPgrad.g
randseed 5757538
//include RebekahSims/US5grad.g
randseed 5757538
//include RebekahSims/US10grad.g
randseed 5757538
//include RebekahSims/US20grad.g
randseed 5757538
//include RebekahSims/US30grad.g
randseed 5757538
//include RebekahSims/US50grad.g
randseed 5757538
//include RebekahSims/US100grad.g
randseed 5757538
//include RebekahSims/US175grad.g
randseed 5757538
//include RebekahSims/US290grad.g


