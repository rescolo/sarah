Off[General::spell]

Model`Name = "SDdiracDMU1BL";
Model`NameLaTeX =" U1 B-L extession of the Singlet doublet Dirac dark matter";
Model`Authors = "Andres Rivera. Base in SM by F.Staub";
Model`Date = "2019-01-22";

(* 2013-01-24: changed normalization of lambda term to convention of hep-ph/0207271 *)
(* 2013-06-24: using new name conventions (without inital "S" and "F" for scalar and matter fields) *)
(* 2013-09-01: changing to new conventions for FermionFields/MatterFields *)
(* 2014-11-06: Changed sign in Lagrangian to fit standard conventions *)
(* 2016-05-03: Changed sign of Yu *)
(* 2019-01-20: U1 B-L extession of the SDdiracDM model*)


(*-------------------------------------------*)
(*   Particle Content*)
(*-------------------------------------------*)


(* Gauge Groups *)

(*quite el +1 *)
Gauge[[1]]={B,   U[1], hypercharge, g1,False};
Gauge[[2]]={WB, SU[2], left,        g2,True};
Gauge[[3]]={G,  SU[3], color,       g3,False};
Gauge[[4]]={Bp,  U[1], BminusL,     g1p, False};


(* Matter Fields *)

FermionFields[[1]] = {q, 3, {uL, dL},     1/6, 2,  3,             1/3};  
FermionFields[[2]] = {l, 3, {vL, eL},    -1/2, 2,  1,      	   -1};
FermionFields[[3]] = {d, 3, conj[dR],     1/3, 1, -3,   	 -1/3};
FermionFields[[4]] = {u, 3, conj[uR],    -2/3, 1, -3,   	 -1/3};
FermionFields[[5]] = {e, 3, conj[eR],       1, 1,  1,              1};

FermionFields[[6]] = {nl1, 1, nL1,            0, 1,  1,   	  7/5};
FermionFields[[7]] = {nr2, 1, conj[nR2],            0, 1,  1,  	-10/5};
FermionFields[[8]] = {rd, 1, {vd, ed},   -1/2, 2,  1,    	 10/5};
FermionFields[[9]] = {ru, 1, {-conj[eu],conj[vu]},  1/2, 2,  1, -10/5};
FermionFields[[10]] = {vr, 2, conj[vR],      0, 1,  1,    	  8/5};
FermionFields[[11]] = {vr3, 1, conj[vR3],      0, 1,  1,  	  2/5};

ScalarFields[[1]] = {H, 1, {Hp, H0},      1/2, 2,  1,      	    0};
ScalarFields[[2]] = {SP, 1, S0,             0, 1,  1,     	  3/5};
ScalarFields[[3]] = {Si, 2, ssi,             0, 1,  1,   	 15/5};

(*RealScalars = {SP};*)

        
(*----------------------------------------------*)
(*   DEFINITION                                 *)
(*----------------------------------------------*)

NameOfStates={GaugeES, EWSB};

(* ----- Before EWSB ----- *)

DEFINITION[GaugeES][LagrangianInput]= {
	{LagHC,       {AddHC->True}},
	{LagNoHC,     {AddHC->False}},
        {Lagdoublet , {AddHC->True}},
        {LagSi , {AddHC->False}},
        {LagS , {AddHC->False}}(*,
        {Lagint , {AddHC->True}}*)
};


LagNoHC = -( -mu2 conj[H].H + 1/2 Lambda1 conj[H].H.conj[H].H );

LagHC =  -(Yd conj[H].d.q + Ye conj[H].e.l + Yu u.q.H);

Lagdoublet =  - ( MDF rd.ru  + YRD nr2.rd.H );

LagSi = -( MSi2 conj[Si].Si + LamSiH conj[Si].Si.conj[H].H  (*+ 1/2 LI conj[Si].Si.conj[Si].Si*) );

LagS = -( mS2 conj[SP].SP + LamSH conj[SP].SP.conj[H].H + 1/2 LamS conj[SP].SP.conj[SP].SP ); 

Lagint = -( YRA ru.l.Si + YRB nl1.vr.conj[Si] + YRC nr2.nl1.SP );

(* Gauge Sector *)

DEFINITION[EWSB][GaugeSector] =
{ 
  {{VB,VWB[3],VBp},{VP,VZ,VZp},ZZ},
  {{VWB[1],VWB[2]},{VWp,conj[VWp]},ZW}
};     



(* ----- VEVs ---- *)

DEFINITION[EWSB][VEVs]= 
{    {H0, {v, 1/Sqrt[2]}, {sigmaH, \[ImaginaryI]/Sqrt[2]},{phiH, 1/Sqrt[2]}},
     {S0, {vS, 1/Sqrt[2]}, {sigmaS, \[ImaginaryI]}, {phiS, 1/Sqrt[2]}}
};
 

DEFINITION[EWSB][MatterSector]=   
    {{{phiH,phiS},{hh,ZH}},
     {{sigmaH,sigmaS},{Ah,ZA}},
     {{{dL}, {conj[dR]}}, {{DL,Vd}, {DR,Ud}}},
     {{{uL}, {conj[uR]}}, {{UL,Vu}, {UR,Uu}}},
     {{{eL}, {conj[eR]}}, {{EL,Ve}, {ER,Ue}}},     
     {{{vL}, {conj[vR],conj[vR3]}}, {{VL, Vv}, {VR, Vvr}}},
     {{{vd, nL1}, {conj[vu], conj[nR2]}}, {{xVL,XV}, {xVR,XU}}},
     {{ssi}, {Ssc, VSs}}
    };  


(*------------------------------------------------------*)
(* Dirac-Spinors *)
(*------------------------------------------------------*)

DEFINITION[EWSB][DiracSpinors]={
 Fd ->{  DL, conj[DR]},
 Fe ->{  EL, conj[ER]},
 Fu ->{  UL, conj[UR]}, 
 Fv ->{  VL, conj[VR]},
 Fxe ->{  ed, conj[eu]},
 Fxv ->{  xVL, conj[xVR]}  
};

DEFINITION[EWSB][GaugeES]={
 Fd1 ->{  FdL, 0},
 Fd2 ->{  0, FdR},
 Fu1 ->{  Fu1, 0},
 Fu2 ->{  0, Fu2},
 Fe1 ->{  Fe1, 0},
 Fe2 ->{  0, Fe2}};



