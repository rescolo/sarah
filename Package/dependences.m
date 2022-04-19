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
addNewSym[par_,dep_]:=Block[{i,j,newSym,pos,pos2},
SA`Doc`File = "Package/dependences.nb";
SA`Doc`Name = "addNewSym";
SA`Doc`Info = "This routine takes an existing parameter of the model which depends on other parameters. It adds all the parameters needed to calculate the model parameter to the list of parameters. For instance, g1 is fundamental parameter of the model. Because of the defined dependence g1=e/Cos[ThetaW], also e and ThetaW are added to the list of parameters. \n
Moreover, all angles showing up in field rotations in the gauge sector are added to the list 'AssociatedMixingAngles'.";
SA`Doc`Input={"par"->"Considered Parameter", "dep"->"Defined dependence of this parameter"};
SA`Doc`GenerateEntry[];

newSym = DeleteCases[Intersection[Cases[dep /. Mass[a__]:>Random[],x_Symbol,99]],_?(MemberQ[{index1,index2,index3,i001,i002,i003,i004,i005,i006,i007,i008,i009,i010,sum,Pi},#]&)];
pos=Position[parameters,par][[1,1]];
For[j=1,j<=Length[newSym],
If[FreeQ[parameters,newSym[[j]]],
If[Head[dep]===List,
parameters=Join[parameters,{{newSym[[j]],{},{}}}];,
parameters=Join[parameters,{{newSym[[j]],parameters[[pos]][[2]],parameters[[pos]][[3]]}}];
];
pos2=Position[Transpose[ParameterDefinitions][[1]],newSym[[j]]];
If[pos2=!={},
If[(Real /. ParameterDefinitions[[pos2[[1,1]],2]])==True && Head[newSym[[j]]]=!=Mass,
realVar=Join[realVar,{newSym[[j]]}];
];
];
];
j++;];
For[i=1,i<=Length[NameOfStates],
If[FreeQ[DEFINITION[NameOfStates[[i]]][GaugeSector],par]==False,
AssociatedMixingAngles[par]=newSym;
If[(FreeQ[dep,Sin]==False || FreeQ[dep,Cos] ==False || FreeQ[dep,Tan] ==False) && FreeQ[dep,I],realVar = Join[realVar, {par}];]; 
SA`RotationMatricesGaugeSector=Join[SA`RotationMatricesGaugeSector,{par}];
];
i++;];

SA`Doc`EndEntry[];
];


(* ::Input::Initialization:: *)

MakeParameterDependenceList :=Block[{i,j,temp},
SA`Doc`File = "Package/dependences.nb";
SA`Doc`Name = "MakeParameterDependenceList";
SA`Doc`Info = "This routines loops over all existing parameter in the model and checks if dependences (DependenceSPheno,DependenceNum) are defined in the model implementation. These dependences are then stored in replacement rules 'subDependencesSPheno' and 'subNumDependences' for later usage.";
SA`Doc`GenerateEntry[];

subDependences =MakeEntryDependences[DependenceOptional];
temp=MakeEntryDependences[Dependence];
For[i=1,i<=Length[temp],
If[FreeQ[Table[subAlways[[i,1]],{i,1,Length[subAlways]}],temp[[i,1]]],
subAlways =Join[subAlways,{temp[[i]]}];
];
i++;];

subDependencesSPheno ={};


For[i=1, i<=Length[ParameterDefinitions],
If[((DependenceSPheno /. ParameterDefinitions[[i,2]])=!= None) &&
((DependenceSPheno /. ParameterDefinitions[[i,2]])=!= DependenceSPheno), 
subDependencesSPheno = Join[subDependencesSPheno,{ParameterDefinitions[[i,1]]-> (DependenceSPheno /. ParameterDefinitions[[i,2]])}];
];
i++;];

subNumDependences = {};
dependtPara ={};

For[i=1, i<=Length[ParameterDefinitions],
If[((DependenceNum /. ParameterDefinitions[[i,2]])=!= None) &&
((DependenceNum /. ParameterDefinitions[[i,2]])=!= DependenceNum), 

If[FreeQ[parameters,ParameterDefinitions[[i,1]]]==False,
pos=Position[parameters,ParameterDefinitions[[i,1]]][[1,1]];
dependtPara=Join[dependtPara,{ParameterDefinitions[[i,1]]}];
indices = Extract[parameters,pos][[2]];
val=DependenceNum/. ParameterDefinitions[[i,2]];
Switch[Length[indices],
0,subNumDependences = Join[subNumDependences ,{ParameterDefinitions[[i,1]] -> DependenceNum/. ParameterDefinitions[[i,2]]} ];,
1,
	If[Head[val]===List,
	If[getDimParameter[ParameterDefinitions[[i,1]]]==Dimensions[val],
	subNumDependences = Join[subNumDependences ,{ParameterDefinitions[[i,1]][index1_Integer] :>VAL[[index1]]} ];
	subNumDependences = Join[subNumDependences ,{ParameterDefinitions[[i,1]][index1_] :>VAL[index1]} ];,
	Message[Parameter::FalseDimension,ParameterDefinitions[[i,1]]];
	];,
	subNumDependences = Join[subNumDependences ,{ParameterDefinitions[[i,1]][index1_] ->val} ];
	];,
2,
	If[Head[val]===List,
	If[getDimParameter[ParameterDefinitions[[i,1]]]==Dimensions[val],
	subNumDependences = Join[subNumDependences ,{ParameterDefinitions[[i,1]][index1_Integer,index2_Integer] :>VAL[[index1,index2]]} ];
	subNumDependences = Join[subNumDependences ,{ParameterDefinitions[[i,1]][index1_,index2_] :>VAL[index1,index2]} ];,
	Message[Parameter::FalseDimension,ParameterDefinitions[[i,1]]];
	];,
	subNumDependences = Join[subNumDependences ,{ParameterDefinitions[[i,1]][index1_,index2_] ->val} ];
	];,
3,
	If[Head[val]===List,
	If[getDimParameter[ParameterDefinitions[[i,1]]]==Dimensions[val],
		subNumDependences = Join[subNumDependences ,{ParameterDefinitions[[i,1]][index1_Integer, index2_Integer, index3_Integer] :>VAL[[index1,index2,index3]]} ];
	subNumDependences = Join[subNumDependences ,{ParameterDefinitions[[i,1]][index1_, index2_, index3_] :>VAL[index1,index2,index3]} ];,
	Message[Parameter::FalseDimension,ParameterDefinitions[[i,1]]];
	];,
		subNumDependences = Join[subNumDependences ,{ParameterDefinitions[[i,1]][index1_, index2_, index3_] ->val} ];
	];,
4,
	If[Head[val]===List,
	If[getDimParameter[ParameterDefinitions[[i,1]]]==Dimensions[val],
	 subNumDependences = Join[subNumDependences ,{ParameterDefinitions[[i,1]][index1_Integer, index2_Integer,index3_Integer,index4_Integer] :>VAL[[index1,index2,index3,index4]]} ];,
	Message[Parameter::FalseDimension,ParameterDefinitions[[i,1]]];
	];,
	subNumDependences = Join[subNumDependences ,{ParameterDefinitions[[i,1]][index1_, index2_,index3_,index4_] ->val} ];
	];
];
subNumDependences = subNumDependences /. VAL->val;
addNewSym[ParameterDefinitions[[i,1]], DependenceNum/. ParameterDefinitions[[i,2]]];
];
];
i++;];

SA`ListGaugeMixedAll = Select[SA`ListGaugeMixedAll,((#[[2,2]] /. subAlways)=!=0)&];
SA`ListGauginoMixed = Select[SA`ListGauginoMixed,((#[[2,2]] /. subAlways)=!=0)&];
SA`ListGaugeMixed = Select[SA`ListGaugeMixed,((#[[2,2]] /. subAlways)=!=0)&];

SA`Doc`EndEntry[];
];


(* ::Input::Initialization:: *)

MakeEntryDependences[Condition_]:=Block[{list={}},
SA`Doc`File = "Package/dependences.nb";
SA`Doc`Name = "MakeEntryDependences";
SA`Doc`Info = "This routine takes a given kind of dependence (e.g. 'Dependence') and rewrites the condition to carry explicitly the correct number of indices. ";
SA`Doc`Input={"Condition"->"Considered type of dependence"};
SA`Doc`GenerateEntry[];

For[i=1, i<=Length[ParameterDefinitions],
If[((Condition /. ParameterDefinitions[[i,2]])=!= None) &&
((Condition /. ParameterDefinitions[[i,2]])=!= Condition), 

If[FreeQ[parameters,ParameterDefinitions[[i,1]]]==False,
pos=Position[parameters,ParameterDefinitions[[i,1]]][[1,1]];
indices = Extract[parameters,pos][[2]];
If[Head[Condition  /. ParameterDefinitions[[i,2]]]===List,
Clear[dep];
DEP=Condition  /. ParameterDefinitions[[i,2]];
If[getDimParameter[ParameterDefinitions[[i,1]]]==Dimensions[DEP],
Switch[Length[indices],
1,list = Join[list ,{(ParameterDefinitions[[i,1]][index1_Integer] :> dep[[index1]])/. dep->DEP} ];,
2,list = Join[list ,{(ParameterDefinitions[[i,1]][index1_Integer,index2_Integer] :> dep[[index1,index2]])/. dep->DEP} ];,
3,list = Join[list ,{(ParameterDefinitions[[i,1]][index1_Integer, index2_Integer, index3_Integer] :> dep[[index1,index2,index3]])/. dep->DEP} ];,
4, list = Join[list ,{(ParameterDefinitions[[i,1]][index1_Integer, index2_Integer,index3_Integer,index4_Integer] :> dep[[index1,index2,index3,index4]])/. dep->DEP} ];
];,
Message[Parameter::FalseDimension,ParameterDefinitions[[i,1]]];
];,
Switch[Length[indices],
0,list = Join[list ,{ParameterDefinitions[[i,1]] -> Condition /. ParameterDefinitions[[i,2]]} ];,
1,list = Join[list ,{ParameterDefinitions[[i,1]][index1_] -> Condition /.  ParameterDefinitions[[i,2]]} ];,
2,list = Join[list ,{ParameterDefinitions[[i,1]][index1_,index2_] -> Condition  /. ParameterDefinitions[[i,2]]} ];,
3,list = Join[list ,{ParameterDefinitions[[i,1]][index1_, index2_, index3_] -> Condition  /. ParameterDefinitions[[i,2]]} ];,
4, list = Join[list ,{ParameterDefinitions[[i,1]][index1_, index2_,index3_,index4_] -> Condition  /. ParameterDefinitions[[i,2]]} ];
];
];
addNewSym[ParameterDefinitions[[i,1]], Condition/. ParameterDefinitions[[i,2]]];
];
];
i++;];

SA`Doc`Return[list];
];



MakeDepParList[ES_]:=Block[{i,j,k,temp,parNum,parDep,tempOld,tempNew,remaining, add, par,parNames,iterations},
SA`Doc`File = "Package/dependences.nb";
SA`Doc`Name = "MakeDepParList";
SA`Doc`Info = "This routine takes all defined dependences and brings them into the correct order to calculate them step by step. For instance {A=B+C, C=X, B=C+Y} is order as {C=X, B=C+Y, A=B+C}. Note, not only depdences are included in this ordering, but also explicit numerical values which might be defined in parameters.m. \n
Moreover, the routine checks which parameters show up as argument of trigonometrix function and stores them in the list of involved angles ('SA`Angles').";
SA`Doc`Input={"ES"->"Considered eigenstates"};
SA`Doc`GenerateEntry[];

SA`Angles = Select[Intersection[DeleteCases[Flatten[{Cases[VertexListNonCC,x_Sin,99],Cases[VertexListNonCC,x_Cos,99],Cases[VertexListNonCC,x_Tan,99],Cases[VertexListNonCC,x_Sec,99],Cases[VertexListNonCC,x_Sec,99],Cases[VertexListNonCC,x_Cot,99],Cases[subNumDependences,x_Cot,99],Cases[subNumDependences,x_Cos,99],Cases[subNumDependences,x_Csc,99],Cases[subNumDependences,x_Sec,99],Cases[subNumDependences,x_Sin,99],Cases[subNumDependences,x_Tan,99],Cases[subAlways,x_Cot,99],Cases[subAlways,x_Cos,99],Cases[subAlways,x_Csc,99],Cases[subAlways,x_Sec,99],Cases[subAlways,x_Sin,99],Cases[subAlways,x_Tan,99],Cases[subDependences,x_Cot,99],Cases[subDependences,x_Cos,99],Cases[subDependences,x_Csc,99],Cases[subDependences,x_Sec,99],Cases[subDependences,x_Sin,99],Cases[subDependences,x_Tan,99]}] /. Sec[x_]->x /. Cos[x_]-> x /. Tan[x_]->x /. Cot[x_]->x /. Sin[x_]-> x /. Csc[x_]->x,_Integer,5]],(Head[#]==Symbol)&];

parDep=Select[Table[subNumDependences[[i,1]],{i,1,Length[subNumDependences]}],(FreeQ[#,Integer])&];
parNum=Select[Table[DefinedNumericalValues[[i,1]],{i,1,Length[DefinedNumericalValues]}],(FreeQ[#,Integer])&];

temp =Flatten[{subAlways,subNumDependences,subDependences}] /.Part -> PartM /. PartM[a_,b__]->a;
allDependences={};
For[i=1,i<=Length[temp],
If[Head[Head[temp[[i,2]]]]===List,
allDependences=Join[allDependences,{Head[temp[[i,1]]]->Head[temp[[i,2]]] }];,
If[Head[temp[[i,2]]]===Part,
allDependences=Join[allDependences,{temp[[i,1,0]]->temp[[i,2,1]] }];,
allDependences=Join[allDependences,{temp[[i]]}];
];
];
i++;];

dependendParameter=Table[allDependences[[i,1]],{i,1,Length[allDependences]}];

For[i=1,i<=Length[subAlways],
If[FreeQ[parDep,subAlways[[i,1]]] && FreeQ[parNum,subAlways[[i,1]]],parDep=Join[parDep,{subAlways[[i,1]]}];];
i++;];

For[i=1,i<=Length[subDependences],
If[FreeQ[parDep,subDependences[[i,1]]] && FreeQ[parNum,subDependences[[i,1]]],parDep=Join[parDep,{subDependences[[i,1]]}];];
i++;];

parDep=Select[parDep,(FreeQ[parNum,#])&];
parNames = Transpose[parameters][[1]];

temp = Select[parNames,((FreeQ[VertexListNonCC[ES],#]==False || FreeQ[allDependences,#]==False) && (FreeQ[SA`RotationMatricesGaugeSector,#] || FreeQ[subAlways,#]))&];
SA`ParNum = Select[temp,(FreeQ[parNum,#]==False)&];
SA`ParDep=Select[temp,(FreeQ[parDep,#]==False)&];

SA`ParNeed = Select[temp,(FreeQ[SA`ParNum ,#]&& FreeQ[SA`ParDep,#])&];

subMassTemp=Select[parDep,(Head[#]==Mass)&];
subMassTempRe = Table[(ToExpression["M"<>ToString[subMassTemp[[i,1]]]])->subMassTemp[[i]],{i,1,Length[subMassTemp]}];
subMassTemp = Table[subMassTemp[[i]]->(ToExpression["M"<>ToString[subMassTemp[[i,1]]]]),{i,1,Length[subMassTemp]}];

tempNew=SA`ParNeed ;
tempOld= {};


While[tempOld=!=tempNew,
tempOld=tempNew;
For[i=1,i<=Length[SA`ParDep],
pos = Position[dependendParameter,SA`ParDep[[i]]];
par=Intersection[Select[Cases[{allDependences[[pos[[1,1]],2]]}/. Mass[a__]:>Random[] /. A_[b__Pattern]->A,x_Symbol,99],(FreeQ[parNames,#]==False)&]];
For[j=1,j<=Length[par],
If[FreeQ[parNum,par[[j]]]==False && FreeQ[SA`ParNum,par[[j]]],
SA`ParNum = Join[SA`ParNum,{par[[j]]}];,
If[FreeQ[parDep,par[[j]]]==False && FreeQ[SA`ParDep,par[[j]]],
SA`ParDep = Join[SA`ParDep,{par[[j]]}];,
If[FreeQ[tempNew,par[[j]]] && FreeQ[parDep,par[[j]]] && FreeQ[parNum,par[[j]]],
tempNew = Join[tempNew,{par[[j]]}];
];
];
];
j++;];
i++;];
];



SA`ParNeed = tempNew ;

temp = SA`ParDep /. subMassTemp;
SA`ParDep = {};


allDep = Flatten[{subAlways,subNumDependences,subDependences}] /.A_?(MemberQ[Transpose[parameters][[1]],#]&)[b_Integer,c___]->A ;

iterations =1;


tempNew={};
For[i=1,i<=Length[temp],
If[FreeQ[{temp[[i]]/. allDep,temp[[i]][a]/.allDep,temp[[i]][a,b]/.allDep,temp[[i]][a,b,c]/.allDep},sum],
tempNew=Join[tempNew,{temp[[i]]}];
];
i++;];

temp=tempNew;

 While[temp=!={} && iterations <=1000,
tempNew={};
For[i=1,i<=Length[temp],
(* par=Cases[{temp[[i]]} /. subAlways/. subNumDependences /. subDependences /. subMassTemp/. Mass[a__]:>Random[] /. A_[b__Pattern]\[Rule]A,x_Symbol,99]; *)
par=Cases[{temp[[i]]} /.(allDep /. A_[b__Pattern]->A   /. Part ->PART /. PART[a_,b__]->a  /. subMassTemp) /. subMassTemp/. Mass[a__]:>Random[] /. A_[b__Pattern]->A,x_Symbol,99];
remaining=Join[tempNew,Table[temp[[k]]/. Mass[a__]->Random[],{k,i+1,Length[temp]}]];
add=True;
For[j=1,j<=Length[par],
If[FreeQ[DeleteCases[remaining,x_Pattern,10],par[[j]]]==False,
add=False;
];
j++;];
If[add==False,
tempNew=Join[tempNew,{temp[[i]]}];,
SA`ParDep = Join[SA`ParDep,{temp[[i]]}];
];
i++;];
temp=tempNew;

iterations++;
 ]; 


If[iterations>= 999,
If[Select[temp,(FreeQ[SA`VertexListNonCC,#]==False)&]=!={},
SortParameters::Error="There has been a problem sorting the dependent parameters. Please check the array \"parDepExpand\" and your input for the definitions if it may not possible to resolve the dependences.";
Message [SortParameters::Error]; 
];
];

SA`ParDep = SA`ParDep /. subMassTempRe;

SA`Doc`EndEntry[];
];

