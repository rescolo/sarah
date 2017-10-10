(* ::Package:: *)

(************************************************************************)
(* This file was generated automatically by the Mathematica front end.  *)
(* It contains Initialization cells from a Notebook file, which         *)
(* typically will have the same name as this file except ending in      *)
(* ".nb" instead of ".m".                                               *)
(*                                                                      *)
(* This file is intended to be loaded into the Mathematica kernel using *)
(* the package loading commands Get or Needs.  Doing so is equivalent   *)
(* to using the Evaluate Initialization Cells menu command in the front *)
(* end.                                                                 *)
(*                                                                      *)
(* DO NOT EDIT THIS FILE.  This entire file is regenerated              *)
(* automatically each time the parent Notebook file is saved in the     *)
(* Mathematica front end.  Any changes you make to this file will be    *)
(* overwritten.                                                         *)
(************************************************************************)



(* ::Input::Initialization:: *)
GenerateLesHouchesFile := Block[{i,i1, i2,i3,i4,k,l,listIn,fin,iminpar},
(*
Print["--------------------------------- "];
Print["Writing templates for input files "];
Print["--------------------------------- "];
*)

Print[StyleForm["Write templates for input files","Section",FontSize->12]];

Print["  Writing LesHouches input file"];

If[Head[MINPAR[[1,1]]]=!=List,fin=1;,fin=Length[MINPAR];];

For[iminpar=1,iminpar<=fin,

If[Head[DefaultInputValues]===List,
defv=DefaultInputValues;,
If[Head[DefaultInputValues[iminpar]]===List,
defv=DefaultInputValues[iminpar];,
defv={};
];
];

$SPhenoInputFilesDir=ToFileName[{$sarahCurrentSPhenoDir,"Input_Files"}];
If[FileExistsQ[$SPhenoInputFilesDir]=!=True,
CreateDirectory[$SPhenoInputFilesDir];
];

If[Head[MINPAR[[1,1]]]=!=List || iminpar==1,
sphenoLH=OpenWrite[ToFileName[$SPhenoInputFilesDir,"LesHouches.in."<>NameForModel]];
sphenoLHlow=OpenWrite[ToFileName[$SPhenoInputFilesDir,"LesHouches.in."<>NameForModel<>"_low"]];,
sphenoLH=OpenWrite[ToFileName[$SPhenoInputFilesDir,"LesHouches.in."<>NameForModel<>"_"<>ToString[iminpar]]];
sphenoLHlow=OpenWrite[ToFileName[$SPhenoInputFilesDir,"LesHouches.in."<>NameForModel<>"_low_"<>ToString[iminpar]]];
];
filenames= {sphenoLH, sphenoLHlow};

CombindedBlocks={};

BlocksForSSP={{},{}};

For[l=1,l<=2,
CombindedBlocks={};
WriteString[filenames[[l]],"Block MODSEL      #  \n"];
If[l==1,
WriteString[filenames[[l]],"1 1               #  1/0: High/low scale input \n"];,
WriteString[filenames[[l]],"1 0               #  1/0: High/low scale input \n"];
];
WriteString[filenames[[l]],"2 "<>ToString[iminpar]<>"              # Boundary Condition  \n"];
WriteString[filenames[[l]],"6 1               # Generation Mixing \n"];
If[l==2,
WriteString[filenames[[l]],"12 1000.          # Renormalization scale \n"];
];
WriteString[filenames[[l]],"Block SMINPUTS    # Standard Model inputs \n"];
WriteString[filenames[[l]],"2 1.166370E-05    # G_F,Fermi constant \n"];
WriteString[filenames[[l]],"3 1.187000E-01    # alpha_s(MZ) SM MSbar \n"];
WriteString[filenames[[l]],"4 9.118870E+01    # Z-boson pole mass \n"];
WriteString[filenames[[l]],"5 4.180000E+00    # m_b(mb) SM MSbar \n"];
WriteString[filenames[[l]],"6 1.735000E+02    # m_top(pole) \n"];
WriteString[filenames[[l]],"7 1.776690E+00    # m_tau(pole) \n"];
WriteString[filenames[[l]],"Block MINPAR      # Input parameters \n"];

If[Head[MINPAR[[1,1]]]=!=List,
For[i=1,i<=Length[MINPAR],
If[l==1 || (FreeQ[BoundaryLowScaleInput,MINPAR[[i,2]]]==False && FreeQ[EXTPAR,MINPAR[[i,2]]]==True),
 If[NumericQ[MINPAR[[i,2]]/.defv]===False,
WriteString[filenames[[l]],ToString[MINPAR[[i,1]]]<>"   0.000000E+00    # "<>ToString[MINPAR[[i,2]]] <>"\n"];,
WriteString[filenames[[l]],ToString[MINPAR[[i,1]]]<>"   "<>ToStringFNr[MINPAR[[i,2]]/.defv] <>"    # "<>ToString[MINPAR[[i,2]]] <>"\n"];
];
];
i++;];,
For[i=1,i<=Length[MINPAR[[iminpar]]],
If[l==1 || (FreeQ[BoundaryLowScaleInput,MINPAR[[iminpar,i,2]]]==False && FreeQ[EXTPAR,MINPAR[[iminpar,i,2]]]==True),
 If[NumericQ[MINPAR[[iminpar,i,2]]/.defv]===False,
WriteString[filenames[[l]],ToString[MINPAR[[iminpar,i,1]]]<>" 0.000000E+00    # "<>ToString[MINPAR[[iminpar,i,2]]] <>"\n"];,
WriteString[filenames[[l]],ToString[MINPAR[[iminpar,i,1]]]<>"  "<>ToStringFNr[MINPAR[[iminpar,i,2]]/.defv] <>"    # "<>ToString[MINPAR[[iminpar,i,2]]] <>"\n"];
];
];
i++;];
];

If[Head[EXTPAR]===List,
If[Select[Transpose[EXTPAR][[2]],(FreeQ[BoundarySUSYScale,#]==False || FreeQ[BoundaryEWSBScale,#]==False || FreeQ[BoundaryHighScale,#]==False || FreeQ[BoundaryConditionsUp,#]==False  || FreeQ[BoundaryConditionsDown,#]==False)&]=!={} || l==2,
WriteString[filenames[[l]],"Block EXTPAR      # Input parameters \n"];
For[i=1,i<=Length[EXTPAR],
If[l==1 || (FreeQ[BoundaryLowScaleInput,EXTPAR[[i,2]]]==False ),
 If[NumericQ[EXTPAR[[i,2]]/.defv]===False,
WriteString[filenames[[l]],ToString[EXTPAR[[i,1]]]<>" 0.000000E+00    # "<>ToString[EXTPAR[[i,2]]] <>"\n"];,
WriteString[filenames[[l]],ToString[EXTPAR[[i,1]]]<>" "<>ToStringFNr[EXTPAR[[i,2]]/.defv] <>"    # "<>ToString[EXTPAR[[i,2]]] <>"\n"];
];
];
i++;];
];
];


WriteString[filenames[[l]],"Block SPhenoInput   # SPheno specific input \n"];
WriteString[filenames[[l]],"  1 -1              # error level \n"];
WriteString[filenames[[l]],"  2  0              # SPA conventions \n"];
If[Include2LoopCorrections=!=False,
WriteString[filenames[[l]],"  7  0              # Skip 2-loop Higgs corrections \n"];
WriteString[filenames[[l]],"  8  3              # Method used for two-loop calculation \n"];
WriteString[filenames[[l]],"  9  1              # Gaugeless limit used at two-loop \n"];
WriteString[filenames[[l]]," 10  0              # safe-mode used at two-loop \n"];
];
WriteString[filenames[[l]]," 11 1               # calculate branching ratios \n"];
WriteString[filenames[[l]]," 13 1               # 3-Body decays: none (0), fermion (1), scalar (2), both (3) \n"];
WriteString[filenames[[l]]," 14 0               # Run couplings to scale of decaying particle \n"];
WriteString[filenames[[l]]," 12 1.000E-04       # write only branching ratios larger than this value \n"];
WriteString[filenames[[l]]," 15 1.000E-30       # write only decay if width larger than this value \n"];
If[SA`AddOneLoopDecay === True,
WriteString[filenames[[l]]," 16 1              # One-loop decays \n"];
];
WriteString[filenames[[l]]," 31 -1              # fixed GUT scale (-1: dynamical GUT scale) \n"];
WriteString[filenames[[l]]," 32 0               # Strict unification \n"];
WriteString[filenames[[l]]," 34 1.000E-04       # Precision of mass calculation \n"];
WriteString[filenames[[l]]," 35 40              # Maximal number of iterations\n"];
WriteString[filenames[[l]]," 36 5               # Minimal number of iterations before discarding points\n"];
WriteString[filenames[[l]]," 37 "<>If[Head[DefaultYukawaScheme]===Integer,ToString[DefaultYukawaScheme],"1"]<>"               # Set Yukawa scheme  \n"];
WriteString[filenames[[l]]," 38 2               # 1- or 2-Loop RGEs \n"];
WriteString[filenames[[l]]," 50 1               # Majorana phases: use only positive masses (put 0 to use file with CalcHep/Micromegas!) \n"];
WriteString[filenames[[l]]," 51 0               # Write Output in CKM basis \n"];
WriteString[filenames[[l]]," 52 0               # Write spectrum in case of tachyonic states \n"];
If[SupersymmetricModel=!=False,
WriteString[filenames[[l]]," 55 1               # Calculate loop corrected masses \n"];,
WriteString[filenames[[l]]," 55 0               # Calculate loop corrected masses \n"];
WriteString[filenames[[l]]," 61 0               # Running SM parameters\n"];
];
WriteString[filenames[[l]]," 57 1               # Calculate low energy constraints \n"];
If[Count[Gauge,U[1],3]>1,WriteString[filenames[[l]]," 60 1               # Include possible, kinetic mixing \n"];];
If[SeveralIndependentTadpoleSolutions=!=True,
WriteString[filenames[[l]]," 65 1               # Solution tadpole equation \n"];
];
WriteString[filenames[[l]]," 75 1               # Write WHIZARD files \n"];
WriteString[filenames[[l]]," 76 1               # Write HiggsBounds file   \n"];
WriteString[filenames[[l]]," 77 0               # Output for MicrOmegas (running masses for light quarks; real mixing matrices)   \n"];
WriteString[filenames[[l]]," 86 0.              # Maximal width to be counted as invisible in Higgs decays; -1: only LSP \n"];
If[AddCheckMaxMassInLoops==True,WriteString[filenames[[l]]," 88 1.0E4          # Maximal mass of particles taken into account in loops \n"];
];
WriteString[filenames[[l]],"510 0.              # Write tree level values for tadpole solutions \n"];
WriteString[filenames[[l]],"515 0               # Write parameter values at GUT scale \n"];
WriteString[filenames[[l]],"520 1.              # Write effective Higgs couplings (HiggsBounds blocks): put 0 to use file with MadGraph! \n"];
WriteString[filenames[[l]],"521 1.              # Diphoton/Digluon widths including higher order \n"];
WriteString[filenames[[l]],"525 0.              # Write loop contributions to diphoton decay of Higgs \n"];
WriteString[filenames[[l]],"530 1.              # Write Blocks for Vevacious \n"];
If[IncludeFineTuning===True,
WriteString[filenames[[l]],"550 1.             # Calculate Fine-Tuning \n"];
];


If[FlagLoopContributions===True,
For[i=1,i<=Length[PART[F]],
(* WriteString[sphenoInOut,"Case("<>ToString[1100+i]<>") \n"]; *) (* REMOVED 03/05/15 *)
WriteString[filenames[[l]],ToString[1100+i]<>" 1             # Include "<>SPhenoForm[PART[F][[i,1]]]<>" in 1.loop corrections \n"];
i++;];

For[i=1,i<=Length[PART[S]],
(* WriteString[filenames[[l]],"Case("<>ToString[1200+i]<>") \n"]; *)
WriteString[filenames[[l]],ToString[1200+i]<>" 1             # Include "<>SPhenoForm[PART[S][[i,1]]]<>" in 1.loop corrections \n"];
i++;];

For[i=1,i<=Length[PART[V]],
(* WriteString[sphenoInOut,"Case("<>ToString[1300+i]<>") \n"]; *)
WriteString[filenames[[l]],ToString[1300+i]<>" 1             # Include "<>SPhenoForm[PART[V][[i,1]]]<>" in 1.loop corrections \n"];
i++;];

For[i=1,i<=Length[PART[G]],
(* WriteString[sphenoInOut,"Case("<>ToString[1400+i]<>") \n"]; *)
WriteString[filenames[[l]],ToString[1400+i]<>" 1             # Include "<>SPhenoForm[PART[G][[i,1]]]<>" in 1.loop corrections \n"];
i++;];

WriteString[filenames[[l]],ToString[1500]<>" 1               # Include Wave diagrams 1.loop corrections \n"];
WriteString[filenames[[l]],ToString[1501]<>" 1               # Include Penguin diagrams 1.loop corrections \n"];
WriteString[filenames[[l]],ToString[1502]<>" 1               # Include Box diagrams 1.loop corrections \n"];

];

WriteString[filenames[[l]],"Block DECAYOPTIONS   # Options to turn on/off specific decays \n"];
For[i=1,i<=Length[ListDecayParticles3B],
WriteString[filenames[[l]],ToString[i]<>"    1     # Calc 3-Body decays of "<>SPhenoForm[ListDecayParticles3B[[i,1]]]<>" \n"];
i++;];
If[SA`AddOneLoopDecay === True,
WriteString[filenames[[l]], ToString[1000] <>" 0     # One loop-induced decays only \n"];
For[i=1,i<=Length[SA`ParticlesDecays1Loop],
WriteString[filenames[[l]],ToString[1000+i]<> " 1     # Loop Decay of "<>SPhenoForm[SA`ParticlesDecays1Loop[[i]]]<>" \n"];
i++;];
WriteString[filenames[[l]], ToString[1101] <>" 0      # Only UV divergent parts of integrals \n"];
WriteString[filenames[[l]], ToString[1102] <>" 0.     # Value used for divergence \n"];
WriteString[filenames[[l]], ToString[1110] <>" 0.     # Use pole masses \n"];
WriteString[filenames[[l]],"1201 1.0E-5               # Photon/Gluon mass in loop decays \n"];
];

If[l==1 && OnlyLowEnergySPheno=!=True,
listIn = Intersection[Select[Flatten[{BoundaryHighScale,BoundarySUSYScale,BoundaryEWSBScale,BoundaryConditionsUp,BoundaryConditionsDown}],(Head[#]==LHInput)&,99] /. LHInput[x_]->x];,
If[Head[BoundaryLowScaleInput]===List,
listIn = Intersection[DeleteCases[DeleteCases[listAllParametersAndVEVs,x_?(MemberQ[Transpose[BoundaryLowScaleInput][[1]],#]&)],x_?(MemberQ[ParametersToSolveTadpolesLowScaleInput,#]&)]];,
listIn = Intersection[DeleteCases[listAllParametersAndVEVs,x_?(MemberQ[ParametersToSolveTadpolesLowScaleInput,#]&)]];
];
If[Head[BoundaryLowScaleInput]===List,
listIn =Join[listIn, Select[Flatten[BoundaryLowScaleInput],(Head[#]==LHInput)&,99] /. LHInput[x_]->x];
];
];
If[AddSMrunning===True,
listIn = Complement[listIn,{ElectronYukawa,UpYukawa,DownYukawa,strongCoupling,leftCoupling,hyperchargeCoupling,VEVSM1,VEVSM2, VEVSM}];
];


For[i=1,i<=Length[listIn],
BlocksForSSP[[l]]=Join[BlocksForSSP[[l]],{{LHBlockName[listIn[[i]]],getDimSPheno[listIn[[i]]]}}];
If[getDimSPheno[listIn[[i]]]=!={} && getDimSPheno[listIn[[i]]]=!={1},
WriteString[filenames[[l]],"Block "<>ToUpperCase[LHBlockName[listIn[[i]]]] <>"IN    #  \n"];
];
Switch[Length[getDimSPheno[listIn[[i]]]],
0, CombindedBlocks = Join[CombindedBlocks,{{LHBlockName[listIn[[i]]],{LHPos[listIn[[i]]], listIn[[i]]}}}];
	(* WriteString[filenames[[l]],ToString[LHPos[listIn[[i]]]]<>"\t 0.000000E+00 \t  # "<>SPhenoForm[listIn[[i]]] <>"\n"]; *), 
1,
	If[getDimSPheno[listIn[[i]]]==={1},
	 CombindedBlocks = Join[CombindedBlocks,{{LHBlockName[listIn[[i]]],{LHPos[listIn[[i]]], listIn[[i]]}}}];,
	For[i1=1,i1<=getDimSPheno[listIn[[i]]][[1]],
	 If[NumericQ[listIn[[i]][i1]/.defv]===False,
	WriteString[filenames[[l]],ToString[i1]<>"   0.000000E+00         # "<>SPhenoForm[listIn[[i]]] <>"("<>ToString[i1] <>")\n"];,
	WriteString[filenames[[l]],ToString[i1]<>"   "<>ToStringFNr[listIn[[i]][i1]/.defv] <>"         # "<>SPhenoForm[listIn[[i]]] <>"("<>ToString[i1] <>")\n"];
	];
	i1++;];
	];,
2,
	For[i1=1,i1<=getDimSPheno[listIn[[i]]][[1]],
	For[i2=1,i2<=getDimSPheno[listIn[[i]]][[2]],
		 If[NumericQ[listIn[[i]][i1,i2]/.defv]===False,
	WriteString[filenames[[l]],ToString[i1]<>" "<>ToString[i2]<>"   0.000000E+00         # "<>SPhenoForm[listIn[[i]]] <>"("<>ToString[i1] <>","<>ToString[i2]<>")\n"];,
	WriteString[filenames[[l]],ToString[i1]<>" "<>ToString[i2]<>"   "<>ToStringFNr[listIn[[i]][i1,i2]/.defv] <>"         # "<>SPhenoForm[listIn[[i]]] <>"("<>ToString[i1] <>","<>ToString[i2]<>")\n"];
	];
	i2++;];
	i1++;];,
3,
	For[i1=1,i1<=getDimSPheno[listIn[[i]]][[1]],
	For[i2=1,i2<=getDimSPheno[listIn[[i]]][[2]],
	For[i3=1,i3<=getDimSPheno[listIn[[i]]][[3]],
	If[NumericQ[listIn[[i]][i1,i2,i3]/.defv]===False,
	WriteString[filenames[[l]],ToString[i1]<>" "<>ToString[i2]<>" "<>ToString[i3]<>"   0.000000E+00         # "<>SPhenoForm[listIn[[i]]] <>"("<>ToString[i1] <>","<>ToString[i2]<>","<>ToString[i3]<>")\n"];,
	WriteString[filenames[[l]],ToString[i1]<>" "<>ToString[i2]<>" "<>ToString[i3]<>"  "<>ToStringFNr[listIn[[i]][i1,i2]/.defv] <>"         # "<>SPhenoForm[listIn[[i]]] <>"("<>ToString[i1] <>","<>ToString[i2]<>","<>ToString[i3]<>")\n"];
	];
	i3++;];
	i2++;];
	i1++;];
];
i++;];


saveC=CombindedBlocks;
CombindedBlocks = Intersection[Table[Select[CombindedBlocks,(CombindedBlocks[[i,1]]===#[[1]])&],{i,1,Length[CombindedBlocks]}]] //. {{A_,{x1_,x2_},c___},{A_,{y1_,y2_}},d___}->{{A,{x1,x2},c,{y1,y2}},d};

For[i=1,i<=Length[CombindedBlocks],
WriteString[filenames[[l]],"Block "<>ToUpperCase[CombindedBlocks[[i,1,1]]] <>"IN       #  \n"];
For[k=2,k<=Length[CombindedBlocks[[i,1]]],
WriteString[filenames[[l]],ToString[CombindedBlocks[[i,1,k,1]]]<>"   0.000000E+00         # "<>SPhenoForm[CombindedBlocks[[i,1,k,2]]] <>"\n"];
k++;];
i++;];

l++;];

Close[sphenoLH];
Close[sphenoLHlow];
iminpar++;
];

GenerateSSPtemplate;

];


(* ::Input::Initialization:: *)

GenerateMakeFile[NameForModel_,StandardCompiler_] :=Block[{i},
Print["  Writing Makefile"];

sphenoMake=OpenWrite[ToFileName[$sarahCurrentSPhenoDir,"Makefile"]];



WriteString[sphenoMake,"modname = "<>NameForModel<> "  # as an example  \n"];
If[Head[QuadruplePrecision]===List && QuadruplePrecision=!={},
WriteString[sphenoMake,"PreDef = -DGENERATIONMIXING \n"];,
WriteString[sphenoMake,"PreDef = -DGENERATIONMIXING -DONLYDOUBLE\n"];
];
WriteString[sphenoMake,"# setting various paths  \n"];
WriteString[sphenoMake,"InDir = ../include\n"];
WriteString[sphenoMake,"Mdir = ${InDir}\n"];
WriteString[sphenoMake,"VPATH = 3-Body-Decays:LoopDecays:TwoLoopMasses:Observables:SM \n"];
WriteString[sphenoMake,"name = ../lib/libSPheno"<>NameForModel<>".a\n \n"];
WriteString[sphenoMake,"# check if SARAH module and SPheno are compatibel  \n"];
WriteString[sphenoMake,"minV=330.00 \n"];
WriteString[sphenoMake,"cVersion =$(shell expr $(version) \\>= $(minV))\n"];
WriteString[sphenoMake,"#  \n"];
WriteString[sphenoMake,"# options for various compilers  \n"];
WriteString[sphenoMake,"#  \n"];

(* WriteString[sphenoMake,"# Intels ifort,default in optimized mode  \n"]; 
 WriteString[sphenoMake,"F90=gfortran  \n"]; *)
WriteString[sphenoMake,"# Default Compiler  \n"]; 
WriteString[sphenoMake,"F90="<>StandardCompiler<>"\n"];

If[SA`Version === "SARAHVERSION",
WriteString[sphenoMake,"comp= -c -g -module ${Mdir} -I${InDir}  \n"];
WriteString[sphenoMake,"LFlagsB= -g  \n"];,
WriteString[sphenoMake,"comp= -c -O -module ${Mdir} -I${InDir}  \n"];
WriteString[sphenoMake,"LFlagsB= -O  \n"];
];

WriteString[sphenoMake,"# Intels ifort,debug modus  \n"];
WriteString[sphenoMake,"ifeq (${F90},ifortg)  \n"];
WriteString[sphenoMake,"F90=ifort  \n"];
WriteString[sphenoMake,"comp= -c -g -module ${Mdir} -I${InDir}  \n"];
WriteString[sphenoMake,"LFlagsB= -g  \n"];
WriteString[sphenoMake,"endif  \n"];

WriteString[sphenoMake,"# gfortran  \n"];
WriteString[sphenoMake,"ifeq (${F90},gfortran)  \n"];
WriteString[sphenoMake,"comp= -c -g -ffree-line-length-none -J${Mdir} -I${InDir}  \n"];
WriteString[sphenoMake,"LFlagsB= -g  \n"];
WriteString[sphenoMake,"endif  \n"];

WriteString[sphenoMake,"# g95  \n"];
WriteString[sphenoMake,"ifeq (${F90},g95)  \n"];
WriteString[sphenoMake,"comp= -c -O -fmod=${Mdir} -I${InDir}  \n"];
WriteString[sphenoMake,"LFlagsB= -O  \n"];
WriteString[sphenoMake,"endif  \n"];

WriteString[sphenoMake,"# Lahey F95 compiler  \n"];
WriteString[sphenoMake,"ifeq (${F90},lf95)  \n"];
WriteString[sphenoMake,"comp=-c -O -M ${Mdir} -I${InDir}  \n"];
WriteString[sphenoMake,"LFlagsB=-O  \n"];
WriteString[sphenoMake,"endif  \n"];

WriteString[sphenoMake,"# NAG f95/2003  \n"];
WriteString[sphenoMake,"ifeq (${F90},nagfor)  \n"];
WriteString[sphenoMake,"comp= -c -O -mdir ${Mdir} -I${InDir}  \n"];
WriteString[sphenoMake,"LFlagsB= -O -DONLYDOUBLE -mdir ${MDir} -I${InDir}  \n"];
WriteString[sphenoMake,"endif   \n"];



WriteString[sphenoMake,".SUFFIXES : .o .ps .f90 .F90 .a \n"];
WriteString[sphenoMake,"bin/SPheno"<>NameForModel<>":\n"];
WriteString[sphenoMake,"ifeq (${cVersion},1)\n"];
WriteString[sphenoMake,"\t cd ../src ; ${MAKE} F90=${F90} \n"];
WriteString[sphenoMake,"\t ${MAKE} F90=${F90} ${name} \n"];
WriteString[sphenoMake,"\t ${MAKE} F90=${F90} SPheno"<>NameForModel<>".o \n"];

If[UseHiggs2LoopMSSM===True,
WriteString[sphenoMake,"\t ${F90} -c TwoLoopMasses/effpotasat.f \n"];
WriteString[sphenoMake,"\t ${F90} -o SPheno"<>NameForModel<>" ${LFlagsB} SPheno"<>NameForModel<>".o effpotasat.o ../lib/libSPheno"<>NameForModel<>".a ../lib/libSPheno.a\n"];,(*otherwise do not include the fortran file*)WriteString[sphenoMake,"\t ${F90} -o SPheno"<>NameForModel<>" ${LFlagsB} SPheno"<>NameForModel<>".o ../lib/libSPheno"<>NameForModel<>".a ../lib/libSPheno.a\n"];
];

WriteString[sphenoMake,"\t mv SPheno"<>NameForModel<>" ../bin\n"];
WriteString[sphenoMake,"\t rm SPheno"<>NameForModel<>".o  \n"];
WriteString[sphenoMake,"${name}:  ${name}(Settings.o) ${name}(Model_Data_"<>ModelName<>".o)  \\\n"]; 


WriteString[sphenoMake," ${name}(RGEs_"<>ModelName<>".o)   \\\n"];  
WriteString[sphenoMake," ${name}(Couplings_"<>ModelName<>".o) ${name}(TreeLevelMasses_"<>ModelName<>".o) ${name}(TadpoleEquations_"<>ModelName<>".o) \\\n"];  
If[SPhenoOnlyForHM=!=True,
WriteString[sphenoMake," ${name}(LoopCouplings_"<>ModelName<>".o) ${name}(CouplingsForDecays_"<>ModelName<>".o) \\\n"];,
WriteString[sphenoMake," ${name}(LoopCouplings_"<>ModelName<>".o)  \\\n"];  
];  

WriteString[sphenoMake," ${name}(TreeLevel_Decays_"<>ModelName<>".o) \\\n"]; 
If[Length[ListDecayParticles3B]>0,
For[i=1,i<=Length[ListDecayParticles3B],
WriteString[sphenoMake," ${name}("<>StringDrop[ToString[ListDecayParticles3B[[i,2]]],-4]<>".o) "];
i++;];
WriteString[sphenoMake ," \\\n"];
];

If[Include2LoopCorrections=!=False,
WriteString[sphenoMake," ${name}(EffPotFunctions.o) ${name}(DerivativesEffPotFunctions.o) ${name}(EffectivePotential_"<>ModelName<>".o) \\\n"];
WriteString[sphenoMake," ${name}(2LPoleFunctions.o) ${name}(2LPole_"<>ModelName<>".o) \\\n"];
If[UseHiggs2LoopMSSM===True,
WriteString[sphenoMake," ${name}(TwoLoopHiggsMass_SARAH.o) \\\n"];
];
];
WriteString[sphenoMake,"${name}(AddLoopFunctions.o) ${name}(Kinematics.o) \\\n"];
WriteString[sphenoMake," ${name}(LoopMasses_"<>ModelName<>".o) \\\n"];
If[OnlyLowEnergySPheno=!=True,
WriteString[sphenoMake," ${name}(RGEs_SM_HC.o) ${name}(Couplings_SM_HC.o) ${name}(TreeLevelMasses_SM_HC.o) ${name}(2LPole_SM_HC.o) ${name}(LoopMasses_SM_HC.o)   \\\n"];,
WriteString[sphenoMake," ${name}(RGEs_SM_HC.o) \\\n"];
];
If[Head[RegimeNr]===Integer,
WriteString[sphenoMake," ${name}(Shifts_"<>ModelName<>".o) \\\n"];
];

If[SA`AddOneLoopDecay === True && SPhenoOnlyForHM=!=True ,
WriteString[sphenoMake,"${name}(CouplingsCT_"<>ModelName<>".o) \\\n"];
WriteString[sphenoMake,"${name}(Bremsstrahlung.o) ${name}(DecayFFS.o) ${name}(DecayFFV.o) ${name}(DecaySSS.o) ${name}(DecaySSV.o) ${name}(DecaySFF.o) ${name}(DecaySVV.o) \\\n"];
For[i=1,i<=Length[SA`ParticlesDecays1Loop],
WriteString[sphenoMake," ${name}(LoopDecay"<>SPhenoForm[SA`ParticlesDecays1Loop[[i]]]<>".o) "];
i++;];
WriteString[sphenoMake,"${name}(OneLoopDecays_"<>ModelName<>".o) \\\n"];
];

WriteString[sphenoMake," ${name}(BranchingRatios_"<>ModelName<>".o) ${name}(HiggsCS_"<>ModelName<>".o) ${name}(RunSM_"<>ModelName<>".o) \\\n"];

If[IncludeFineTuning===True,
WriteString[sphenoMake," ${name}(FineTuning_"<>ModelName<>".o) \\\n"];
];


If[AddLowEnergyConstraint ===True,
WriteString[sphenoMake," ${name}(LowEnergy_"<>ModelName<>".o) \\\n"];
If[SkipFlavorKit=!=True,WriteString[sphenoMake,"${name}(FlavorKit_LFV_"<>ModelName<>".o) ${name}(FlavorKit_QFV_"<>ModelName<>".o) ${name}(FlavorKit_Observables_"<>ModelName<>".o)\\\n"];
];
];

If[OnlyLowEnergySPheno=!=True,
WriteString[sphenoMake," ${name}(Boundaries_"<>ModelName<>".o)  ${name}(InputOutput_"<>ModelName<>".o) \n"];,
WriteString[sphenoMake,"${name}(InputOutput_"<>ModelName<>".o) \n"];
];
WriteString[sphenoMake,"else \n"];
WriteString[sphenoMake,"\t @echo -------------------------------------------------------------------  \n"];
WriteString[sphenoMake,"\t @echo ERROR:  \n"];
WriteString[sphenoMake,"\t @echo The installed SPheno is version not compatibel with this module \n"];
WriteString[sphenoMake,"\t @echo Please, upgrade at least to SPheno version 3.3.0.  \n"];
WriteString[sphenoMake,"\t @echo The current SPheno version can be downloaded from \n"];
WriteString[sphenoMake,"\t @echo http://www.hepforge.org/downloads/spheno \n"];
WriteString[sphenoMake,"\t @echo ------------------------------------------------------------------- \n"];
WriteString[sphenoMake,"endif \n"];
WriteString[sphenoMake,"clean: \n"];
WriteString[sphenoMake,"\t rm -f *.o *~ */*.o */*~\n"];
WriteString[sphenoMake,"cleanall: \n"];
WriteString[sphenoMake,"\t rm -f bin/SPheno3 lib/*.a *~ */*.o */*~ include/*\n"];
WriteString[sphenoMake,"#\n"];
WriteString[sphenoMake,"# Suffix rules\n"];
WriteString[sphenoMake,"#\n"];
WriteString[sphenoMake,".f90.a:\n"];
WriteString[sphenoMake,"\t ${F90} ${comp} $< \n"]; 
WriteString[sphenoMake,"\t ar -ruc $@ $*.o\n"];
WriteString[sphenoMake,"\t rm -f $*.o\n"];
WriteString[sphenoMake,".F90.a:\n"];
WriteString[sphenoMake,"\t ${F90} ${comp} ${PreDef} $< \n"];
WriteString[sphenoMake,"\t ar -ruc $@ $*.o\n"];
WriteString[sphenoMake,"\t rm -f $*.o\n"];
WriteString[sphenoMake,".f90.o:\n"];
WriteString[sphenoMake,"\t ${F90} ${comp} $<\n"];
WriteString[sphenoMake,".f90.ps:\n"];
WriteString[sphenoMake,"\t a2ps -o $*.ps $<\n"];
WriteString[sphenoMake,".h.ps:\n"];
WriteString[sphenoMake,"\t a2ps -o $*.ps $<\n"];

Close[sphenoMake];



];


(* ::Input::Initialization:: *)
GenerateSSPtemplate:=Block[{i,j,k,l,pos,iminpar,fin},

Print["  Writing SSP templates"];

$sarahSSPtemplates=ToFileName[{$sarahCurrentSPhenoDir,"SSP_Templates"}];
If[FileExistsQ[$sarahSSPtemplates]=!=True,
CreateDirectory[$sarahSSPtemplates];
];


If[Head[MINPAR[[1,1]]]=!=List,fin=1;,fin=Length[MINPAR];];

For[iminpar=1,iminpar<=fin,

If[Head[MINPAR[[1,1]]]=!=List || iminpar ==1,
SSPfile=OpenWrite[ToFileName[$sarahSSPtemplates,"SSP_Template.m."<>NameForModel]];
SSPfileLOW=OpenWrite[ToFileName[$sarahSSPtemplates,"SSP_Template_lowScaleInput.m."<>NameForModel]];,
SSPfile=OpenWrite[ToFileName[$sarahSSPtemplates,"SSP_Template.m."<>NameForModel<>"_"<>ToString[iminpar]]];
SSPfileLOW=OpenWrite[ToFileName[$sarahSSPtemplates,"SSP_Template_lowScaleInput.m."<>NameForModel<>"_"<>ToString[iminpar]]];
];

filenames= {SSPfile, SSPfileLOW};

BlocksForSSP[[1]]=Intersection[BlocksForSSP[[1]]];
BlocksForSSP[[2]]=Intersection[BlocksForSSP[[2]]];


For[i=1,i<=2,
WriteString[filenames[[i]],"RunScans = {   }; \n \n"];

WriteString[filenames[[i]],"(*----------------------------------------------*) \n"];
WriteString[filenames[[i]],"(*   SETUP                                      *) \n"];
WriteString[filenames[[i]],"(*----------------------------------------------*) \n\n"];

WriteString[filenames[[i]],"(* Define location, in- and output of SPheno *) \n \n"];
WriteString[filenames[[i]],"LoadSettings=\"DefaultSettings.m."<>NameForModel<>"\";  \n \n"];


WriteString[filenames[[i]],"(* ----------------------- DARKMATTER ------------------------*) \n \n"];
WriteString[filenames[[i]],"(* Set to True to include MicrOmegas *) \n \n"];
WriteString[filenames[[i]],"DEFINITION[a_][IncludeMicrOmegas]=False; \n \n"];

WriteString[filenames[[i]],"(* ------------------------- CALCHEP -------------------------*) \n \n"];
WriteString[filenames[[i]],"(* Set to True to include CalcHep *) \n"];
WriteString[filenames[[i]],"DEFINITION[a_][IncludeCalcHep]=False; \n"];
WriteString[filenames[[i]],"(* Define processes *) \n"];
WriteString[filenames[[i]],"DEFINITION[a_][CalcHepRuns]={{\"DIRECTORY\",\"COMMAND\",\"FILE\"},... }; \n \n"];

WriteString[filenames[[i]],"(* ------------------------- WHIZARD ------------------------- *) \n \n"];
WriteString[filenames[[i]],"(* Set to True to include WHIZARD *) \n "];
WriteString[filenames[[i]],"DEFINITION[a_][IncludeWHIZARD]=False; \n"];
WriteString[filenames[[i]],"(* Define processes *) \n"];
WriteString[filenames[[i]],"DEFINITION[a_][WHIZARDruns]={\"InputFile\",... }; \n \n"];

WriteString[filenames[[i]],"(*----------------------------------------------*)\n"];
WriteString[filenames[[i]],"(*    INCLUDE FIT                               *)\n"];
WriteString[filenames[[i]],"(*----------------------------------------------*)\n\n"];

WriteString[filenames[[i]],"(*  \n"];
WriteString[filenames[[i]],"(* Define Constraints *) \n"];
WriteString[filenames[[i]],"DEFINITION[a_][FitValues]={{Parameter,Value,Error},...}; \n"];
WriteString[filenames[[i]],"(* Free parameters *) \n"];
WriteString[filenames[[i]],"DEFINITION[FITHIGGS][FreeParameters]={{Parameter,{Min,Max}}}; \n"];
WriteString[filenames[[i]],"*) \n"];

WriteString[filenames[[i]],"(*----------------------------------------------*)\n"];
WriteString[filenames[[i]],"(*    INCLUDE CONTOUR SCAN                      *)\n"];
WriteString[filenames[[i]],"(*----------------------------------------------*)\n\n"];

WriteString[filenames[[i]],"(*  \n"];
WriteString[filenames[[i]]," DEFINITION[a_][CountourScan]={z-Value,{x-Value,min,max},{y-Value,min,max},OPTIONS,\"FILENAME\"}; \n"];
WriteString[filenames[[i]],"*) \n"];

WriteString[filenames[[i]],"(*----------------------------------------------*)\n"];
WriteString[filenames[[i]],"(*    NAMES FOR DIFFERENT SCANS                 *)\n"];
WriteString[filenames[[i]],"(*----------------------------------------------*)\n\n"];

WriteString[filenames[[i]],"RunScans = {Scan1, Scan2,...}; \n \n"];

WriteString[filenames[[i]],"(*----------------------------------------------*)\n"];
WriteString[filenames[[i]],"(*    PARAMETER RANGES                          *)\n"];
WriteString[filenames[[i]],"(*----------------------------------------------*)\n\n"];


WriteString[filenames[[i]],"DEFINITION[a_][Blocks]={MODSEL,SMINPUTS,SPhenoInput,MINPAR"];
If[Head[EXTPAR]===List,
WriteString[filenames[[i]],",EXTPAR"];
];
For[l=1,l<=Length[BlocksForSSP[[i]]],
WriteString[filenames[[i]],","<>ToString[BlocksForSSP[[i,l,1]]]<>"IN" ];
l++;];
 WriteString[filenames[[i]],"}; \n \n"];


WriteString[filenames[[i]],"DEFINITION[a_][MODSEL]={ \n"];
If[i===1,WriteString[filenames[[i]],"{{1},{Value->1}}, \n"];,WriteString[filenames[[i]],"{{1},{Value->0}}, \n"];];
WriteString[filenames[[i]],"{{2},{Value->"<>ToString[iminpar]<>"}}, \n"];
WriteString[filenames[[i]],"{{6},{Value->1}} \n"];
WriteString[filenames[[i]],"}; \n"];


WriteString[filenames[[i]],"DEFINITION[a_][SMINPUTS]={ \n"];
WriteString[filenames[[i]],"{{2},{Value\[Rule]1.166390*10^-5}}, \n"];
WriteString[filenames[[i]],"{{3},{Value\[Rule]0.1172}}, \n"];
WriteString[filenames[[i]],"{{4},{Value\[Rule]91.18760}}, \n"];
WriteString[filenames[[i]],"{{5},{Value\[Rule]4.2}}, \n"];
WriteString[filenames[[i]],"{{6},{Value\[Rule]172.9}}, \n"];
WriteString[filenames[[i]],"{{7},{Value\[Rule]1.777}} \n"];
WriteString[filenames[[i]],"}; \n"];

If[Head[MINPAR[[1,1]]]=!=List,
WriteString[filenames[[i]],"DEFINITION[a_][MINPAR]={ \n"];
For[j=1,j<=Length[MINPAR],
WriteString[filenames[[i]],"{{"<>ToString[MINPAR[[j,1]]]<>"},{Value->0}} (*" <>ToString[MINPAR[[j,2]]]<>"*)"];
If[j===Length[MINPAR],
WriteString[filenames[[i]],"}; \n \n"];,
WriteString[filenames[[i]],", \n"];
];
j++;];,
WriteString[filenames[[i]],"DEFINITION[a_][MINPAR]={ \n"];
For[j=1,j<=Length[MINPAR[[iminpar]]],
WriteString[filenames[[i]],"{{"<>ToString[MINPAR[[iminpar,j,1]]]<>"},{Value->0}} (*" <>ToString[MINPAR[[iminpar,j,2]]]<>"*)"];
If[j===Length[MINPAR[[iminpar]]],
WriteString[filenames[[i]],"}; \n \n"];,
WriteString[filenames[[i]],", \n"];
];
j++;];
];

If[Head[EXTPAR]===List,
WriteString[filenames[[i]],"DEFINITION[a_][EXTPAR]={ \n"];
For[j=1,j<=Length[EXTPAR],
WriteString[filenames[[i]],"{{"<>ToString[EXTPAR[[j,1]]]<>"},{Value->0}} (*" <>ToString[EXTPAR[[j,2]]]<>"*)"];
If[j===Length[EXTPAR],
WriteString[filenames[[i]],"}; \n \n"];,
WriteString[filenames[[i]],", \n"];
];
j++;];
];

WriteString[filenames[[i]],"DEFINITION[a_][SPhenoInput]={ \n"];
WriteString[filenames[[i]],"{{1},{Value\[Rule]-1}}, (* error level *)\n"];
WriteString[filenames[[i]],"{{2},{Value\[Rule]0}},  (* SPA conventions *) \n"];
WriteString[filenames[[i]],"{{11},{Value\[Rule]1}}, (* Calculate widhts and BRs *)\n"];
WriteString[filenames[[i]],"{{12},{Value\[Rule]0.0001}}, (* minimal BR to write out *) \n"];
WriteString[filenames[[i]],"{{13},{Value\[Rule]1}}, (* Enable 3-body decays *) \n"];
WriteString[filenames[[i]],"{{34},{Value\[Rule]0.0001}}, (* precision of masses *) \n"];
WriteString[filenames[[i]],"{{38},{Value\[Rule]2}}, (* 1/2 - Loop RGEs *) \n"];
WriteString[filenames[[i]],"{{51},{Value\[Rule]0}}, (* Switch to CKM matrix *) \n"];
WriteString[filenames[[i]],"{{55},{Value\[Rule]1}}, (* 1 - Loop masses *)\n"];
WriteString[filenames[[i]],"{{57},{Value\[Rule]1}}, (* low energy constraints *)\n"];
If[Count[Gauge,U[1],3]>1,WriteString[filenames[[i]],"{{60},{Value\[Rule]1}}, (* Include possible, kinetic mixing *)\n"];];
If[SeveralIndependentTadpoleSolutions=!=True,
WriteString[filenames[[i]],"{{65},{Value\[Rule]1}}, (* Solution tadpole equation *)\n"];
];
WriteString[filenames[[i]],"{{75},{Value\[Rule]1}}, (* Write WHIZARD files *) \n"];
WriteString[filenames[[i]],"{{76},{Value\[Rule]1}},  (* Write HiggsBounds files *) \n"];
WriteString[filenames[[i]],"{{86},{Value\[Rule]0.}},  (* Maximal width to be counted as invisible in Higgs decays; -1: only LSP *) \n"];
If[IncludeFineTuning===True,
WriteString[filenames[[i]],"{{550},{Value\[Rule]1}},  (* Calculate Fine-Tuning *) \n"];
];
WriteString[filenames[[i]],"{{530},{Value\[Rule]1.}}  (* Write Blocks for Vevacious *) \n"];
WriteString[filenames[[i]],"}; \n"];


For[k=1,k<=Length[BlocksForSSP[[i]]],
If[FreeQ[CombindedBlocks,BlocksForSSP[[i,k,1]]]==False,
pos=Position[CombindedBlocks,BlocksForSSP[[i,k,1]]][[1,1]];
WriteString[filenames[[i]],"DEFINITION[a_]["<>ToString[BlocksForSSP[[i,k,1]]]<>"IN]={ \n"];
For[i1=2,i1<=Length[CombindedBlocks[[pos,1]]],
	WriteString[filenames[[i]],"{{"<>ToString[CombindedBlocks[[pos,1,i1,1]]]<>"},{Value->0}}  (*"<>SPhenoForm[CombindedBlocks[[pos,1,i1,2]]]<> "*) "];
If[i1===Length[CombindedBlocks[[pos,1]]],WriteString[filenames[[i]],"}; \n \n"];,WriteString[filenames[[i]],", \n"];];
i1++;];
];
k++;];


For[k=1,k<=Length[BlocksForSSP[[i]]],
If[FreeQ[CombindedBlocks,BlocksForSSP[[i,k,1]]]==True,
WriteString[filenames[[i]],"DEFINITION[a_]["<>ToString[BlocksForSSP[[i,k,1]]]<>"IN]={ \n"];
Switch[Length[BlocksForSSP[[i,k,2]]],
1,
	For[i1=1,i1<=BlocksForSSP[[i,k,2]][[1]],
	WriteString[filenames[[i]],"{{"<>ToString[i1]<>"},{Value->0}} "];
	If[i1===BlocksForSSP[[i,k,2]][[1]],WriteString[filenames[[i]],"}; \n \n"];,WriteString[filenames[[i]],", \n"];];
	i1++;];,
2,
	For[i1=1,i1<=BlocksForSSP[[i,k,2]][[1]],
	For[i2=1,i2<=BlocksForSSP[[i,k,2]][[2]],
		WriteString[filenames[[i]],"{{"<>ToString[i1]<>","<>ToString[i2]<>"},{Value->0}} "];
	If[i1===BlocksForSSP[[i,k,2]][[1]] && i2===BlocksForSSP[[i,k,2]][[2]] ,WriteString[filenames[[i]],"}; \n \n"];,WriteString[filenames[[i]],", \n"];];
	i2++;];
	i1++;];,
3,
	For[i1=1,i1<=BlocksForSSP[[i,k,2]][[1]],
	For[i2=1,i2<=BlocksForSSP[[i,k,2]][[2]],
	For[i3=1,i3<=BlocksForSSP[[i,k,2]][[3]],
		WriteString[filenames[[i]],"{{"<>ToString[i1]<>","<>ToString[i2]<>","<>ToString[i3]<>"},{Value->0}} "];
If[i1===BlocksForSSP[[i,k,2]][[1]] && i2===BlocksForSSP[[i,k,2]][[2]] && i3===BlocksForSSP[[i,k,2]][[3]],WriteString[filenames[[i]],"}; \n \n"];,WriteString[filenames[[i]],", \n"];];
	i3++;];
	i2++;];
	i1++;];
];
];
k++;];

WriteString[filenames[[i]],"(*----------------------------------------------*)\n"];
WriteString[filenames[[i]],"(*    PLOTS                                     *)\n"];
WriteString[filenames[[i]],"(*----------------------------------------------*) \n\n"];

WriteString[filenames[[i]],"DEFINITION[a_][Plots]={ \n"];
WriteString[filenames[[i]],"}; \n"];


i++;];

Close[SSPfile];
Close[SSPfileLOW];
iminpar++;
];
];
