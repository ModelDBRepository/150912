//genesis

/***************************		MS Model, Version 9.1	*********************
**************************** 	      CaDifshell.g 	*********************
	Avrama Blackwell 	kblackw1@gmu.edu
	Wonryull Koh		wkoh1@gmu.edu
	Rebekah Evans 		rcolema2@gmu.edu
	Sriram 				dsriraman@gmail.com	
******************************************************************************

*****************************************************************************/

//***************************** Begin Local Subroutine ***********************
//old calcium concentration - single time constant of decay
function add_CaConcen (buffername, a, b, cellpath)
	str buffername,cellpath
    float a,b

    str compt
	float len,dia,position
    float Ca_tau,kb   		
	float PI = 3.14159
    float shell_thick={outershell_thickness}
    float Ca_base = {base}

	foreach compt ({el {cellpath}/##[TYPE=compartment]})
	
		//make sure this is the correct compartment type, and determine length and diameter
 		if (!{{compt} == {{cellpath}@"/axIS"} || {compt} == {{cellpath}@"/ax"}}) 
    		dia = {getfield {compt} dia}
    		position = {getfield {compt} position}
     		len = {getfield {compt} len}
    		if ({{getpath {compt} -tail} == "soma"})
              len = dia
            end
   		end

  			//if the compartment is not a spine and its position is between [a,b] 
   		if ({position >= a} && {position < b} ) 
     			// Sabatini's model. Sabatini, 2001,2004
      		create Ca_concen  {compt}/{buffername}  // create Ca_pool here!
      		if({dia} < 0.81e-6)        // this is tertiary dendrites
            		kb = 96
      		elif (dia < 1.5e-6)        // secondary dendrites
            		kb = 96
      		elif (dia < 1.8e-6)        // primary dendrites
            		kb = 96
 		else                       // soma 
      			kb = 200             	// the setting for soma is imaginary
   		end

   			if({dia}	<	15e-6)
   				Ca_tau = 25e-3
   			else 
      				Ca_tau = 100e-3       	// an imaginary setting to fit the model
   			end  
                
   			// set Ca_tau  according to diameters of dendrites      
   			float  shell_dia = dia - shell_thick*2
   			float  shell_vol= {PI}*(dia*dia/4-shell_dia*shell_dia/4)*len
   			float surf = dia*{PI}*dia
		if ({dia}>= 15e-6)
			echo {compt} "shell_vol=" {shell_vol} "+" {len}
			echo "shell_dia="{shell_dia}
			echo "dia=" {dia}
			echo "surface area=" {surf}
		end
		
			setfield {compt}/{buffername} \
               B          {1.0/(2.0*96494*shell_vol*(1+kb))}	\ 
               tau        {Ca_tau}                        		\  
               Ca_base    {Ca_base}   									\
               thick      {shell_thick}  

//
   		end
    end
end

//new calcium concentration - various buffers, pumps and diffusion
function create_difshell (shellName, base, compLen, r, shellThickness, mode)
	str shellName
	float base
	float compLen
	float r, shellThickness
    	str mode

	create difshell {shellName}
	setfield {shellName}	\
		C    {base}	\
        Ceq  {base}	\
        D    {dca}	\ //D_Ca = 2e-6 (cm^2)(s^(-1))
        val  2	\
        leak 0	\
        shape_mode {mode}	\ 
        len {compLen}	\
        dia {r*2}	\	//outer diameter of the shell
        thick {shellThickness}
end

function add_difbuffer_to_difshell (shellName, bname, btotal, kf, kb, d, compLen, r, shellThickness, mode)
	str shellName, bname
	float btotal, kf, kb, d, compLen, r
    	str mode
	create difbuffer {shellName}{bname}

    setfield {shellName}{bname}	\
		activation {base} \
		Btot {btotal}	\
        kBf {kf} \
        kBb {kb} \
        D {d} \
        shape_mode {mode} \
        len {compLen} \
        dia {r*2} \
        thick {shellThickness}

    addmsg {shellName}{bname} {shellName} BUFFER kBf kBb Bfree Bbound
    addmsg {shellName} {shellName}{bname} CONCEN C 
end

function add_mmpump (shellName, surfaceArea, kcat, km)
	str shellName
	float surfaceArea, kcat, km
	str pname = "MMpump"
	
	create mmpump {shellName}{pname}
	setfield {shellName}{pname}	\
        vmax {kcat*surfaceArea}	\ 
		val {2}	\	
        Kd {km}
   	addmsg {shellName}{pname} {shellName} MMPUMP vmax Kd
    addmsg {shellName} {shellName}{pname} CONCEN C
end

function make_fura (compt, totalshells, bufname, calname)
	str compt
	str calname
	str bufname
	int totalshells, i
	create fura2 {compt}/fluorescence
	i=1
	while (i < totalshells+1)
		str bnx = {calname} @ {i}
		//str bn = {bnx}{bufname}
		addmsg {compt}/{bnx}{bufname} {compt}/fluorescence CONCEN Bfree Bbound vol
		i=i+1
	end 
end

function make_volavg (compt, totalshells, calname)
	str compt
	str calname
	int totalshells, i
	create wgtavg {compt}/volavg
	i=1
	while (i < totalshells+1)
		str bnx2 = {calname} @ {i}
		addmsg {compt}/{bnx2} {compt}/volavg ValueWgt C vol
		i=i+1	
	end
end

function make_buffervolavg (compt, totalshells, calname, buffer)
	str compt
	str calname
	str buffer
	int totalshells, i
	create wgtavg {compt}/{buffer}Vavg
	i=1
	while (i < totalshells+1)
		str bnx3 = {calname} @ {i}
		addmsg {compt}/{bnx3}{buffer} {compt}/{buffer}Vavg ValueWgt Bbound vol
		i=i+1	
	end
end

function make_extra_pools (a, b, compt)  //called in mscellshort.g
	str compt
	float a, b

	str NMDApool = "NMDApool"
	str LVApool = "LVApool"
	str HVApool = "HVApool"
	add_CaConcen {NMDApool} {a} {b}   {compt} 
	add_CaConcen {HVApool} {a} {b}   {compt} 
	add_CaConcen {LVApool}  {a} {b}   {compt}

	str allpool = "allpool"
	add_CaConcen {allpool} {a} {b} {compt}
	//making an extra pool to add up all calcium accruing over the upstate, no decay so tau=0
	//add_CaConcen {allpool}  {a} {b}   {compt}
	//setfield {compt}/{allpool} B 0
end

//add_extra_pools is called by MScellshort.g 
function add_extra_pools (compt, NMDACaGHK)
	str compt
	float NMDACaGHK

	addmsg {compt}/CaL12_channelGHK {compt}/HVApool I_Ca Ik
	addmsg {compt}/CaL13_channelGHK {compt}/LVApool I_Ca Ik
	addmsg {compt}/NR2A/GHK {compt}/NMDApool fI_Ca Ik {NMDACaGHK}
	addmsg {compt}/CaR_channelGHK {compt}/HVApool I_Ca Ik
	addmsg {compt}/CaT_channelGHK {compt}/LVApool I_Ca Ik

	addmsg {compt}/CaL12_channelGHK {compt}/allpool I_Ca Ik
	addmsg {compt}/CaL13_channelGHK {compt}/allpool I_Ca Ik
	addmsg {compt}/NR2A/GHK {compt}/allpool fI_Ca Ik {NMDACaGHK}
	addmsg {compt}/CaR_channelGHK {compt}/allpool I_Ca Ik
	addmsg {compt}/CaT_channelGHK {compt}/allpool I_Ca Ik
	
end

//***************************** End Local Subroutines ************************

function add_caconcen_objects (calName, CELLPATH)
	str calName
	str CELLPATH
	str outermostShellName = {calName} @ 1
	str compt 
	float totalshells
	float thickness 

	//use maxshells if you want to set a low number of shells, and the thicknesses will be changed accordingly.  
//If you want the thicknesses to be determined 			

	int setshellnum = 0

	
//0= set thickness; max shell num determined by thickness, 1= set max shell num; thickness determined by max shell num.
	
	//set shell number
	int maxshellnum = 3
	
	//or thickness
	
	foreach compt ({el {CELLPATH}/##[TYPE=compartment]})
			float dia={getfield {compt} dia}
			float r = 0.5*{dia}
			float len = {getfield {compt} len}
			int numShells = 0 //initialize numShells at 0
			
//**********calculate how many shells are needed from the diameter and thickness
//*********when that works, can replace the next four sections of add_difbuffer ... with a single section
		
//If setting the initial thickness, this counts the number of shells for each compartment.  the outer shell is set to 
//equal thickness and then the thickness progressively doubles for each inner shell	
		float testsum = 0	
		if (setshellnum == 0)	
			thickness = {outershell_thickness}
			
			if ({{{r} >= {thickness}} && {r <= {1.1*thickness}}})
				numShells = 0
            else
				while ({r} >= {thickness*thicknessincrease}) 
					//echo "thickness=" {thickness}
					//echo "r=" {r}
					//echo "numshells=" {numShells}
					numShells = numShells + 1 
					r = r - thickness
					testsum = testsum + thickness
					thickness = thickness*thicknessincrease
				end	
				
			//this last thickness=r is to make one last shell that is the thickness of 'whatever is leftover'
				thickness=r
				testsum=testsum+thickness
				totalshells=numShells+1
			end		
			
			//echo "r=" {r}
			//echo "thickness=" {thickness}
			//echo "totalshells=" {totalshells}		
			//echo "testsum=" {testsum}
			r = 0.5*{dia}                //re-initialize r and thickness to make the shells.
			thickness = {outershell_thickness}
		end	
		
//If setting the max number of shells, this calculates the thickness.  
//NOTE: this results in different thicknesses depending on the total size of the compartment. 

		if (setshellnum == 1)
			thickness = {r}/{maxshellnum}
			totalshells = {maxshellnum}
			//echo "r=" {r}
			//echo "thickness=" {thickness}
			//echo "totalshells=" {totalshells}
		end
		
			
//make shells and buffers using the number of shells calculated above.  
	    int i = 1
        while (i < totalshells)
			float shellRadius = {r} 
			str shellname = {calName} @ {i}
			create_difshell {compt}/{shellname} {base} {len} {shellRadius} {thickness} SHELL 
			add_difbuffer_to_difshell {compt}/{shellname} {bname1} {btotal1} {kf1} {kb1} {d1} {len} {shellRadius} {thickness} SHELL
			add_difbuffer_to_difshell {compt}/{shellname} {bname2} {btotal2} {kf2} {kb2} {d2} {len} {shellRadius} {thickness} SHELL 
			add_difbuffer_to_difshell {compt}/{shellname} {bname4} {btotal4} {kf4} {kb4} {d4} {len} {shellRadius} {thickness} SHELL
			if (calciumdye == 1)
				add_difbuffer_to_difshell {compt}/{shellname} {bname3} {btotal3} {kf3} {kb3} {d3} {len} {shellRadius} {thickness} SHELL 
			elif (calciumdye == 2)
				add_difbuffer_to_difshell {compt}/{shellname} {bname5} {btotal5} {kf5} {kb5} {d5} {len} {shellRadius} {thickness} SHELL 
			end
			i = {i} + 1
			//echo "r=" {shellRadius}
			//echo "thickness=" {thickness}
			//echo "shellname=" {shellname}
			r = r-thickness
			if (setshellnum == 0)
				thickness=thickness*thicknessincrease
			end
		end
//make final shell with the 'remaining' radius
		shellRadius={r}
		thickness={shellRadius}
		str shellname = {calName} @ {i}
		//echo "r=" {shellRadius}
		//echo "thickness=" {thickness}
		//echo "shellname=" {shellname}
		create_difshell {compt}/{shellname} {base} {len} {shellRadius} {thickness} SHELL
		add_difbuffer_to_difshell {compt}/{shellname} {bname1} {btotal1} {kf1} {kb1} {d1} {len} {shellRadius} {thickness} SHELL 
		add_difbuffer_to_difshell {compt}/{shellname} {bname2} {btotal2} {kf2} {kb2} {d2} {len} {shellRadius} {thickness} SHELL
		add_difbuffer_to_difshell {compt}/{shellname} {bname4} {btotal4} {kf4} {kb4} {d4} {len} {shellRadius} {thickness} SHELL
		if (calciumdye == 1)
			add_difbuffer_to_difshell {compt}/{shellname} {bname3} {btotal3} {kf3} {kb3} {d3} {len} {shellRadius} {thickness} SHELL
		elif (calciumdye == 2)
			add_difbuffer_to_difshell {compt}/{shellname} {bname5} {btotal5} {kf5} {kb5} {d5} {len} {shellRadius} {thickness} SHELL 
		end

        reset

		//add fura object to each compartment to calc fluorescence
		if (calciumdye == 1)
			make_fura {compt} {totalshells} {bname3} {calName}
		end
		//add wgtavg object to calculated ca concentration without dyes
		make_volavg {compt} {totalshells} {calName}
		//add bound Fluo5F wgtavg object
		if (calciumdye == 2)
			make_buffervolavg {compt} {totalshells} {calName} {bname5}
		end
		

	
		//diffusion between shells
			i = 1
			while (i < totalshells)
				str sn = {calName} @ {i} 
				str innerSn = {calName} @ {i+1}
				addmsg {compt}/{sn} {compt}/{innerSn} DIFF_DOWN prev_C thick
				addmsg {compt}/{innerSn} {compt}/{sn} DIFF_UP prev_C thick
				addmsg {compt}/{sn}{bname4} {compt}/{innerSn}{bname4} DIFF_DOWN prev_free thick
				addmsg {compt}/{innerSn}{bname4} {compt}/{sn}{bname4} DIFF_UP prev_free thick
				i = {i} + 1
			end	
			
			//diffusion between difbuffers
			i = 1
			while (i < totalshells)
				str sn = {calName} @ {i} 
				str innerSn = {calName} @ {i+1}
				addmsg {compt}/{sn}{bname2} {compt}/{innerSn}{bname2} DIFF_DOWN prev_free thick
				addmsg {compt}/{innerSn}{bname2} {compt}/{sn}{bname2} DIFF_UP prev_free thick
				if (calciumdye == 1)
					addmsg {compt}/{sn}{bname3} {compt}/{innerSn}{bname3} DIFF_DOWN prev_free thick
					addmsg {compt}/{innerSn}{bname3} {compt}/{sn}{bname3} DIFF_UP prev_free thick
				elif (calciumdye == 2)
					addmsg {compt}/{sn}{bname5} {compt}/{innerSn}{bname5} DIFF_DOWN prev_free thick
					addmsg {compt}/{innerSn}{bname5} {compt}/{sn}{bname5} DIFF_UP prev_free thick
				end
				i = {i} + 1
			end	
		
			//pump @ outershell
			float surfaceArea = {getfield {compt}/{outermostShellName} surf_up}
			//echo "shell=" {compt}/{outermostShellName}
			//showfield {compt}/{outermostShellName} *
			if ({compt} == "/cell/soma")
				add_mmpump {compt}/{outermostShellName} {surfaceArea} {kcatsoma} {km}				float CaBase = {getfield {compt}/{outermostShellName} Ceq}
				float vmax = kcatsoma*surfaceArea
				float vol = {getfield {compt}/{outermostShellName} vol}
				float leak = {{vmax*CaBase}/{vol*{CaBase + km}}} // {{kcatsoma*CaBase}/{outershell_thickness*{CaBase + km}}} 
				setfield {compt}/{outermostShellName} leak {leak}
				echo "soma="{kcatsoma}
				echo "soma="{leak}
			elif ({compt} != "/cell/soma")
				add_mmpump {compt}/{outermostShellName} {surfaceArea} {kcatdend} {km}
				float CaBase = {getfield {compt}/{outermostShellName} Ceq}
				float vmax = kcatdend*surfaceArea
				float vol = {getfield {compt}/{outermostShellName} vol}
				float leak = {{vmax*CaBase}/{vol*{CaBase + km}}} // {{kcatdend*CaBase}/{outershell_thickness*{CaBase + km}}} 
				setfield {compt}/{outermostShellName} leak {leak}
			end			
	end
end

