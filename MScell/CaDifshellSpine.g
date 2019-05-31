//genesis

/***************************		MS Model, Version 8	*********************
**************************** 	      CaDifshellSpines.g 	*********************
	Avrama Blackwell 	kblackw1@gmu.edu
	Wonryull Koh		wkoh1@gmu.edu
	Rebekah Evans 		rcolema2@gmu.edu
	Sriram 			dsriraman@gmail.com	
	Tom Sheehan 		tsheeha2@gmu.edu	
******************************************************************************
This file is a lot like CaDifshell.g, but is adjusted to make difshells in spines.
some key adjustments are that these difshells are in 'slab' format rather than 'onion'
and that these difshells start thinner than the main compartment difshells.
*****************************************************************************/

include MScell/New_Calcium/Ca_constants.g

//***************************** Begin Local Subroutine ***********************


function create_difshellspine (shellName, base, r, shellThickness)
	str shellName
	float base
	float r, shellThickness
	create difshell {shellName}
	setfield {shellName}	\
		C    {base}	\
        Ceq  {base}	\
        D    {dca}	\ //D_Ca = 2e-6 (cm^2)(s^(-1))
        val  2	\
        leak 0	\
        shape_mode {SLAB}	\ 
        dia {r*2}	\	//diameter of slab cylinder (len is not used for slabs)
        thick {shellThickness}  //thickness of slab
end

function add_difbuffer_to_difshellspine (shellName, bname, btotal, kf, kb, d, r, shellThickness)
	str shellName, bname
	float btotal, kf, kb, d, compLen, r
	
	create difbuffer {shellName}{bname}

    setfield {shellName}{bname}	\
		activation {base} \
		Btot {btotal}	\
        kBf {kf} \
        kBb {kb} \
        D {d} \
        shape_mode {SLAB} \
        dia {r*2} \
        thick {shellThickness}

    addmsg {shellName}{bname} {shellName} BUFFER kBf kBb Bfree Bbound
    addmsg {shellName} {shellName}{bname} CONCEN C 
end

function add_mmpumpspine (shellName, surfaceArea, kcat, km)
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

/***********end local subroutines***************/

function add_difshell_spine (calname, type, dia, len)
	str calname
	str type
	str uppershellname = {calname} @ 1
	str midshellname = {calname} @ 2
	str bottomshellname = {calname} @ 3 
	float dia = {dia}
	float len = {len}
	float r = 0.5*{dia}
		
	if (type == "head")
		int numshells = 3
		float uppershell_thickness = 0.07e-6   
		float midshell_thickness = 0.14e-6
		float bottomshell_thickness = 0.29e-6
		str compt = "spine/head"		
	elif (type == "neck")
		int numshells = 3
		float thickness = {len}/{numshells} 
		float uppershell_thickness = {thickness}   
		float midshell_thickness = {thickness}
		float bottomshell_thickness = {thickness}
		str compt = "spine"
	else 
		echo = "oh my god, what did you do???"
	end

//add the difshells and difbuffers
	create_difshellspine {compt}/{uppershellname} {base} {r} {uppershell_thickness}
	add_difbuffer_to_difshellspine {compt}/{uppershellname} {bname1} {btotal1} {kf1} {kb1} {d1} {r} {uppershell_thickness}			
	add_difbuffer_to_difshellspine {compt}/{uppershellname} {bname2} {btotal2} {kf2} {kb2} {d2} {r} {uppershell_thickness}
	add_difbuffer_to_difshellspine {compt}/{uppershellname} {bname3} {btotal3} {kf3} {kb3} {d3} {r} {uppershell_thickness}
		
	create_difshellspine {compt}/{midshellname} {base} {r} {midshell_thickness}
	add_difbuffer_to_difshellspine {compt}/{midshellname} {bname1} {btotal1} {kf1} {kb1} {d1} {r} {midshell_thickness}
	add_difbuffer_to_difshellspine {compt}/{midshellname} {bname2} {btotal2} {kf2} {kb2} {d2} {r} {midshell_thickness}
	add_difbuffer_to_difshellspine {compt}/{midshellname} {bname3} {btotal3} {kf3} {kb3} {d3} {r} {midshell_thickness}
		
	create_difshellspine {compt}/{bottomshellname} {base} {r} {bottomshell_thickness}	
	add_difbuffer_to_difshellspine {compt}/{bottomshellname} {bname1} {btotal1} {kf1} {kb1} {d1} {r} {bottomshell_thickness}
	add_difbuffer_to_difshellspine {compt}/{bottomshellname} {bname2} {btotal2} {kf2} {kb2} {d2} {r} {bottomshell_thickness}
	add_difbuffer_to_difshellspine {compt}/{bottomshellname} {bname3} {btotal3} {kf3} {kb3} {d3} {r} {bottomshell_thickness}
	
	make_fura {compt} {numshells} {bname3} {calname}

	//diffusion between shells
	int i = 1
	while (i < {numshells})
		str sn = {calname} @ {i} 
		str innerSn = {calname} @ {i+1}
		addmsg {compt}/{sn} {compt}/{innerSn} DIFF_DOWN prev_C thick
		addmsg {compt}/{innerSn} {compt}/{sn} DIFF_UP prev_C thick
		i = {i} + 1
	end	
			
	//diffusion between difbuffers
	i = 1
	while (i < {numshells})
		str sn = {calname} @ {i} 
		str innerSn = {calname} @ {i+1}
		addmsg {compt}/{sn}{bname2} {compt}/{innerSn}{bname2} DIFF_DOWN prev_free thick
		addmsg {compt}/{innerSn}{bname2} {compt}/{sn}{bname2} DIFF_UP prev_free thick
		addmsg {compt}/{sn}{bname3} {compt}/{innerSn}{bname3} DIFF_DOWN prev_free thick
		addmsg {compt}/{innerSn}{bname3} {compt}/{sn}{bname3} DIFF_UP prev_free thick
		i = {i} + 1
	end	
	
	if (type == "neck")  //to make sure this only happens once
		// add calcium diffusion from spine head to neck and vice versa
		addmsg {compt}/head/{bottomshellname} {compt}/{uppershellname} DIFF_DOWN prev_C thick
		addmsg {compt}/{uppershellname} {compt}/head/{bottomshellname} DIFF_UP prev_C thick
 		// add buffer diffusion from head to neck and vice versa
		addmsg {compt}/head/{bottomshellname}{bname2} {compt}/{uppershellname}{bname2} DIFF_DOWN prev_free thick
		addmsg {compt}/{uppershellname}{bname2} {compt}/head/{bottomshellname}{bname2} DIFF_UP prev_free thick
 		addmsg {compt}/head/{bottomshellname}{bname3} {compt}/{uppershellname}{bname3} DIFF_DOWN prev_free thick
		addmsg {compt}/{uppershellname}{bname3} {compt}/head/{bottomshellname}{bname3} DIFF_UP prev_free thick
 	end
end





