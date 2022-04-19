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
SA`Doc`ToDo="This file contrains the routine to generated an input file for Ben O'learies spectrum plotter LHPC. As far as I know, it was only used once and also LHPC is not under development for years. Because of that, you might consider removing it from SARAH.  "

MakeLHPCstyle[Eigenstates_]:=Block[{i,j,f,g,part,k},
SA`Doc`File = "Package/Output/lhpc.nb";
SA`Doc`Name = "MakeLHPCstyle";
SA`Doc`Info = "Writes the model information needed for LHPC: for each particle the colour is set which should be used for plotting.";
SA`Doc`GenerateEntry[];

(* Print["Write style file for LHPC "]; *)

Print[StyleForm["Generate style file for LHPC","Section"]];

$sarahCurrentOutputDir=ToFileName[{$sarahCurrentOutputMainDir,ToString[Eigenstates]}];
$sarahCurrentLHPCdir=ToFileName[{$sarahCurrentOutputDir,"LHPC"}];

If[FileExistsQ[$sarahCurrentLHPCdir]=!=True,CreateDirectory[$sarahCurrentLHPCdir];];

LHPC = OpenWrite[ToFileName[$sarahCurrentLHPCdir,"LHPC_"<>ModelName<>"_Control.txt"]];

SA`CurrentStates=Eigenstates;


WriteString[LHPC,"# LHPC spectrum plotting default control file. \n"];
WriteString[LHPC,"# created by Ben O'Leary (benjamin.oleary@gmail.com) on 29/02/2012. \n"];
WriteString[LHPC,"Block LHPCSPECTRUMPLOTCONTROL # general parameters \n"];
WriteString[LHPC,"11 \t GeV \t  # which unit to use for the masses (the masses read from the \n"]; WriteString[LHPC,"  \t \t      # SLHA file are assumed to be in GeV,this entry is for \n"];
WriteString[LHPC,"   \t \t     # plotting in e.g.TeV instead) \n"];
WriteString[LHPC,"12 \t -1.0 \t # maximum range in the above units (0.0 or negative numbers  \n"];
WriteString[LHPC,"  \t \t      # mean that the range is automatically 1.1 times the largest \n"];
WriteString[LHPC,"   \t \t     # mass in the spectrum).13 5.0   \n"];
WriteString[LHPC,"  \t \t      # how much vertical room to leave for each particle's label, \n"];
WriteString[LHPC,"   \t \t    # as a percentage of the vertical range.14 50.0  \n"];
WriteString[LHPC,"   \t  \t     # how much horizontal room to leave for each particle's  \n"];
WriteString[LHPC,"  \t   \t    # label,as a percentage of the width of the plotted line.  \n"];
WriteString[LHPC,"21 \t /usr/bin/gnuplot \t # the path to the gnuplot executable. \n"];
WriteString[LHPC,"22 \t /usr/bin/latex \t # the path to the latex executable. \n"];
WriteString[LHPC,"23 \t /usr/bin/dvips  \t # the path to the dvips executable. \n"];
WriteString[LHPC,"24 \t /usr/bin/ps2eps \t # the path to the ps2eps (or ps2epsi) executable. \n"];
WriteString[LHPC,"25 \t /usr/bin/rm  \t # the path to the file deletion executable. \n"];
WriteString[LHPC,"26 \t /bin/mv \t # the path to the file moving executable.\n"];
WriteString[LHPC,"Block LHPCSPECTRUMPLOTPARTICLES # how to plot the mass of each particle.\n"];
WriteString[LHPC,"\t \t # input \"show palette colornames\" in \n"];
WriteString[LHPC,"\t \t # gnuplot to see the available colors. \n"];

diracTemp=diracSub[Eigenstates];
PART[S]={}; PART[F]={}; PART[V]={};
For[i=1,i<=Length[Particles[Eigenstates]],
Switch[Particles[Eigenstates][[i,4]],
S, PART[S] = Join[PART[S],{{Particles[Eigenstates][[i,1]],Particles[Eigenstates][[i,3]], Particles[Eigenstates][[i,5]],TrueQ[Particles[Eigenstates][[i,1]]== conj[Particles[Eigenstates][[i,1]]]]}}];,
F, pos=Position[diracTemp,Particles[Eigenstates][[i,1]]];
	If[Length[pos]>0,
	PART[F]=Join[PART[F],{{Extract[diracTemp,pos[[1,1]]][[1]],Particles[Eigenstates][[i,3]], Particles[Eigenstates][[i,5]], MemberQ[MajoranaPart,Particles[Eigenstates][[i,1]]/.diracSubBack1[Eigenstates]/. diracSubBack2[Eigenstates]]}}];
	diracTemp=Delete[diracTemp,pos[[1,1]]];
	];,
V, PART[V] = Join[PART[V],{{Particles[Eigenstates][[i,1]],Particles[Eigenstates][[i,3]], Particles[Eigenstates][[i,5]],TrueQ[Particles[Eigenstates][[i,1]]== conj[Particles[Eigenstates][[i,1]]]]}}];
];
i++;];

generic={S,V,F};
For[j=1,j<=Length[generic],
For[i=1,i<=Length[PART[generic[[j]]]],
part=PART[generic[[j]]][[i,1]];
If[getLHPCcolor[part]=!=None,
For[g=1,g<= getGen[part],
For[f=1,f<=getFla[part],
If[getPDG[part,g,f]=!=0,
WriteString[LHPC,ToString[Abs[getPDG[part,g,f]]]<>"\t"<>ToString[getLHPCcolumn[part]]<>"\t"<>getLHPCcolor[part] <>"\t"<>"$"<>ToString[getLaTeXField[part,g,f]]<>"$"<>"\n"];
];
f++;];
g++;];
];
i++;];
j++;];

Print["Done... Output is in ",$sarahCurrentLHPCdir];

Close[LHPC];

SA`Doc`EndEntry[];
];

getLHPCcolor[x_]:=Block[{temp},
temp=getEntryField[x,LHPC];
If[Head[temp]===List &&Length[temp]==2,
Return[temp[[2]]];,
Return[None];
];
];
getLHPCcolumn[x_]:=Block[{temp},
temp=getEntryField[x,LHPC];
If[Head[temp]===List &&Length[temp]==2,
Return[temp[[1]]];,
Return[None];
];
];
