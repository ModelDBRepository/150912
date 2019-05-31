//genesis

/***************************		MS Model, Version 9	*********************
**************************** 	      Ca_constants.g 	*********************
	Avrama Blackwell 	kblackw1@gmu.edu
	Wonryull Koh		wkoh1@gmu.edu
	Rebekah Evans 		rcolema2@gmu.edu
	Sriram 			dsriraman@gmail.com	
******************************************************************************

*****************************************************************************/
    str  CalciumName = "Ca_difshell_"
    str  CA_BUFF_1 = "Ca_difshell_1"     // L and T type channels
    str  CA_BUFF_2 = "Ca_difshell_2"     // coupled to the other channels (N and R)
    str  CA_BUFF_3 = "Ca_difshell_3"     // all calcium channels
  
	int calciumdye = 0  //  flags for calcium dye. "0" means NO calcium dyes.
                     // 1= Fura-2 (default conc 100 uM, can change below)
                     // 2= Fluo-5F (300uM for Shindou, 100uM for Sabatini (check) and Lovinger)
	int calciumtype = 0     // we  have two shell-modes:
                     //  mode = 0 : detailed multi-shell model, using "difshell" object
                     //  mode = 1 : simple calcium pool adopted from  Sabatini's work(Sabatini, 2001, 2004)
	int calciuminact = 0 //calcium dependent inactivation of calcium channels, CaL1.2 and 1.3
		//0 = no CDI
		//1 = CDI for 1.3 and 1.2 N and R
	float cdiqfact = 1
	int NMDABufferMode = 0       // 1, connect both NMDA and AMPA calcium to NMDA_buffer
                                     // 0, connect only NMDA currents to NMDA_buffer


float base = 50e-6 //50nM

float outershell_thickness = 0.1e-6 //outermostshell thickness
float thicknessincrease=2 //perhaps only 1.5		

float dca = 200.0e-12 //200 (um^2)(s^(-1))
//dca = 0.1*dca

//buffer variables [Kim et al 2010 (J Neurosci)]
str bname1 = "calbindin"
float btotal1 = 80.0e-3 	//4 * 40 uM total
float kf1 =  0.028e6 //0.028 (nM^(-1))(s^(-1))  
float kb1 = 19.6 //19.6 (s^(-1))
float d1 = 0 

str bname2 = "CaMC"
if (calciumdye == 0)
	float btotal2 = 15.0e-3 	//was 30.0e-3, but Rodrigo's paper seems to have about half the CaM as Myungs.
else
	float btotal2 = 0.0e-3		//CaM is 'dialyzed' when there is a calcium dye present
end
float kf2 =  0.006e6 //0.006 (nM^(-1))(s^(-1))  
float kb2 = 9.1 //9.1 (s^(-1))
float d2 = 11.0e-12// 11 ((um)^2)(s^(-1)) 

str bname4 = "CaMN" //Ca4? in Kim et al. 2011
if (calciumdye == 0)
	float btotal4 = 15.0e-3 	//was 30.0e-3, but Rodrigo's paper seems to have about half the CaM as Myungs.
else
	float btotal4 = 0.0e-3		//CaM is 'dialyzed' when there is a calcium dye present
end		
float kf4 =  0.1e6 //0.1 (nM^-1)(s^-1)
float kb4 = 1000 // (s^(-1))
float d4 = 11.0e-12 

str bname3 = "Fura-2"  //parameters fall within ranges given in  deshutter's book chapter in Methods in Neuronal Modeling 
float btotal3 = 100e-3 	//100uM?  Kerr uses 100? others use 10? 
float kf3 =  100e3 //1000e3  // 1e5(mM^(-1))(s^(-1))  (deschutter range: 0.25-6e8 M-1sec-1) (25e3 to 6e5 mM-1sec-1) kb kf ratio 185nM (0.000185) 
float kb3 = 18.5 //185 //(s^(-1))  17-380 s^-1 range given in deShutter's chapter(methods in neuronal modeling)
float d3 = 6e-11 //((m)^2)(s^(-1)) (deschutter range: 0.4e-11 m^2sec-1 to 2e-10 m^2sec-1) 6e-11 based on Young's eqn and a viscossity of 4.1, eqn is in Rodrigo's EPAC paper

str bname5 = "Fluo5F" 
float btotal5 = 100.0e-3 //Shindou and Wickens use 300uM Lovinger will use 100uM
float kf5 = 236e3 //236,000 (mM^(-1))(s^(-1)) (2.36e8 M-1sec-1, from Zenisek et al., 2003 kd=2.3uM) 
float kb5 = 5.428e3 //5,428(s^(-1)) for kb/kf=0.023 (for Kd=2.3uM from Shindou 2011)
float d5 = 6e-11 //mol weight similar to Fura2, using same dif constants.  

//kcat & km for MMPump
float km = 0.3e-3
float kcat =  75.0e-8 //75 pmol ((cm)^(-2)) (s^(-1)) //Markram et al 1998

float kcatsoma = 85e-8
float kcatdend = 12e-8 //12e-8	

											


