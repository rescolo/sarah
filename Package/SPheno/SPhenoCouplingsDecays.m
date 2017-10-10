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
GenerateSPhenoRunningCouplingsDecay:=Block[{i,currentRegime,readRegime},
(*
Print["--------------------------------------"];
Print["Writing file for running couplings in decays "];
Print["--------------------------------------"];
*)

Print[StyleForm["Write routine for running couplings in decays","Section",FontSize->12]];

(* $sarahCurrentSPhenoDir=ToFileName[{$sarahCurrentOutputDir,"SPheno"}]; *)
sphenoCoup=OpenWrite[ToFileName[$sarahCurrentSPhenoDir,"CouplingsForDecays_"<>ModelName<>".f90"]];


Print["  Writing module header"];

WriteCopyRight[sphenoCoup];





WriteString[sphenoCoup,"Module CouplingsForDecays_"<>ModelName<>"\n \n"];
WriteString[sphenoCoup, "Use Control \n"];
WriteString[sphenoCoup, "Use Settings \n"];
WriteString[sphenoCoup, "Use Model_Data_"<>ModelName<>" \n"];
If[OnlyLowEnergySPheno=!=True,
WriteString[sphenoCoup, "Use RGEs_"<>ModelName<>" \n"];
];
WriteString[sphenoCoup, "Use Couplings_"<>ModelName<>" \n"];
WriteString[sphenoCoup, "Use LoopCouplings_"<>ModelName<>" \n"];
WriteString[sphenoCoup,"Use Tadpoles_"<>ModelName<>" \n "];
WriteString[sphenoCoup, "Use TreeLevelMasses_"<>ModelName<>" \n"];
(* WriteString[sphenoCoup, "Use LoopMasses_"<>ModelName<>" \n"]; *)
WriteString[sphenoCoup, "Use Mathematics, Only: CompareMatrices, Adjungate \n \n"];

WriteString[sphenoCoup, "Use StandardModel \n"];

WriteString[sphenoCoup, "Contains \n \n "];


WriteString[sphenoCoup,"\n \n"];

Print["  writing running couplings for 2-body decays: ",Dynamic[DynamicRunCoupD2B],"/",Length[savedDecayInfos]," (",Dynamic[DynamicRunCoupNameD2B],")"];
For[i=1,i<=Length[savedDecayInfos],
DynamicRunCoupD2B=i;
DynamicRunCoupNameD2B=savedDecayInfos[[i,1]];
GenerateRunningCouplings[savedDecayInfos[[i,1]],Flatten[savedDecayInfos[[i,2]]],"2B"];
i++;];
DynamicRunCoupNameD2B="All Done";

Print["  writing running couplings for 3-body decays: ",Dynamic[DynamicRunCoupD3B],"/",Length[savedDecayInfos3Body]," (",Dynamic[DynamicRunCoupNameD3B],")"];
For[i=1,i<=Length[savedDecayInfos3Body],
DynamicRunCoupD3B=i;
DynamicRunCoupNameD3B=savedDecayInfos3Body[[i,1]];
GenerateRunningCouplings[savedDecayInfos3Body[[i,1]],savedDecayInfos3Body[[i,3]],"3B"];
i++;];
DynamicRunCoupNameD3B="All Done";

(*
For[i=1,i\[LessEqual]Length[savedDecayInfos3Body],
For[j=1,j\[LessEqual]Length[Last[savedDecayInfos3Body[[i]]]],
GenerateRunningCouplings[savedDecayInfos3Body[[i,1]],Flatten[Last[savedDecayInfos3Body[[i]]][[j]]],"3B"<>"_"<>ToString[j]];
j++;];
i++;];
*)

WriteString[sphenoCoup,"Function NFlav(m_in) \n"];
WriteString[sphenoCoup,"Implicit None \n"];
WriteString[sphenoCoup,"Real(dp), Intent(in) :: m_in \n"];
WriteString[sphenoCoup,"Real(dp) :: NFlav \n"];
WriteString[sphenoCoup,"If (m_in.lt.mf_d(3)) Then \n"];
WriteString[sphenoCoup,"  NFlav = 4._dp \n"];
WriteString[sphenoCoup,"Else If (m_in.lt.mf_u(3)) Then \n"];
WriteString[sphenoCoup,"  NFlav = 5._dp \n"];
WriteString[sphenoCoup,"Else \n"];
WriteString[sphenoCoup,"  NFlav = 6._dp \n"];
WriteString[sphenoCoup,"End if \n"];
WriteString[sphenoCoup,"End Function\n\n"];

AppendSourceCode["RunSM.f90",sphenoCoup];



WriteString[sphenoCoup,"End Module CouplingsForDecays_"<>ModelName<>"\n"];
Close[sphenoCoup];
];



(* ::Input::Initialization:: *)
GenerateRunningCouplings[particle_,couplings_,suffix_]:=Block[{i,j,i1,i2,i3,temp,res,alreadyCalculated, SPhenoCouplings},
MakeSubroutineTitle["CouplingsFor_"<>SPhenoForm[particle]<>"_decays_"<>suffix,Flatten[{Map[ToExpression[SPhenoForm[#]<>"input"]&,Join[NewMassParameters,listAllParametersAndVEVs]],couplings}],{"m_in","i1"},{"deltaM"},sphenoCoup]; 
WriteString[sphenoCoup, "Implicit None \n\n"];
WriteString[sphenoCoup,"Real(dp), Intent(in) :: m_in \n"];
WriteString[sphenoCoup,"Real(dp), Intent(in) :: deltaM \n"];
WriteString[sphenoCoup,"Integer, Intent(in) :: i1 \n"];
MakeVariableList[Map[ToExpression[SPhenoForm[#]<>"input"]&,listAllParametersAndVEVs],",Intent(in)",sphenoCoup];
MakeVariableList[Map[ToExpression[SPhenoForm[#]<>"input"]&,NewMassParameters],",Intent(in)",sphenoCoup];
MakeVariableList[listAllParametersAndVEVs,"",sphenoCoup];
MakeVariableList[couplings,",Intent(out)",sphenoCoup];
If[OnlyLowEnergySPheno=!=True,
WriteString[sphenoCoup,"Real(dp) ::  g1D("<>ToString[numberAllwithVEVs]<>") \n"];
];
WriteString[sphenoCoup,"Integer :: i2, i3, gt1, gt2, gt3, kont \n"];
MakeVariableList[NewMassParameters,"",sphenoCoup];
(* MakeVariableList[NewParametersFromTadpoles,"",sphenoCoup]; *)
If[particle===HiggsBoson  || particle === PseudoScalar,
MakeVariableList[NeededRatiosLoopCouplings,"",sphenoCoup];
MakeVariableList[NeededRatiosLoopCouplingsPseudo,"",sphenoCoup];
WriteString[sphenoCoup,"Complex(dp) :: coup \n"];
WriteString[sphenoCoup,"Real(dp) :: vev, gNLO, NLOqcd, NNLOqcd, NNNLOqcd, AlphaSQ, AlphaSQhlf \n"];
WriteString[sphenoCoup,"Real(dp) :: g1SM,g2SM,g3SM,vSM\n"];
WriteString[sphenoCoup,"Complex(dp) ::YuSM(3,3),YdSM(3,3),YeSM(3,3)\n"];
];
WriteString[sphenoCoup,"Real(dp) :: gSM(11), sinW2, dt, tz, Qin \n"];
If[DEFINITION[UseNonStandardYukwas]===True,
WriteString[sphenoCoup,"Real(dp) :: vSM, vd_aux, vu_aux\n"];
WriteString[sphenoCoup,"Complex(dp) :: Y_u(3,3), Y_d(3,3), Y_l(3,3) \n"];
];

WriteString[sphenoCoup, "Iname = Iname + 1 \n"];
WriteString[sphenoCoup, "NameOfUnit(Iname) = 'Couplings_"<>SPhenoForm[particle]<>"_"<>suffix<>"'\n \n"];

WriteString[sphenoCoup,"sinW2=1._dp-mW2/mZ2 \n"];

For[i=1,i<=Length[listAllParametersAndVEVs],
WriteString[sphenoCoup,SPhenoForm[listAllParametersAndVEVs[[i]]]<>" = "<>SPhenoForm[listAllParametersAndVEVs[[i]]]<>"input \n"];
i++;];

WriteString[sphenoCoup,"Qin=sqrt(getRenormalizationScale()) \n"];

If[OnlyLowEnergySPheno=!=True,
WriteGUTnormalization[sphenoCoup];
MakeCall["ParametersToG"<>ToString[numberAllwithVEVs],listAllParametersAndVEVs,{},{"g1D"},sphenoCoup];

(* Add check if running up or down ! *)

WriteString[sphenoCoup,"If ((m_in.le.Qin).and.(RunningCouplingsDecays)) Then \n"];
WriteString[sphenoCoup,"  tz=Log(m_in/Qin) \n"];
WriteString[sphenoCoup,"  If (m_in.le.mz) tz=Log(mz/Qin)  \n"];
WriteString[sphenoCoup,"  dt=tz/50._dp \n"];
WriteString[sphenoCoup,"  Call odeint(g1D,"<>ToString[numberAllwithVEVs]<>",0._dp,tz,deltaM,dt,0._dp,rge"<>ToString[numberAllwithVEVs]<>",kont)\n\n"];
(*
WriteString[sphenoCoup, "Else \n"];
WriteString[sphenoCoup,"  tz=Log(Qin/m_in) \n"];
WriteString[sphenoCoup,"  dt=tz/50._dp \n"];
WriteString[sphenoCoup,"  Call odeint(g1D,"<>ToString[numberAllwithVEVs]<>",tz,0._dp,deltaM,dt,0._dp,rge"<>ToString[numberAllwithVEVs]<>",kont)\n\n"];
*)
WriteString[sphenoCoup, "End if \n"];

MakeCall["GToParameters"<>ToString[numberAllwithVEVs],listAllParametersAndVEVs,{"g1D"},{},sphenoCoup];
WriteRemoveGUTnormalization[sphenoCoup];
];

(* Check if SM-like particle or heavier than SUSY scale *)

 If[AddSMrunning=!=False, 
If[getRParity[particle,SA`CurrentStates]===1,
WriteString[sphenoCoup,"If (m_in.le.Qin) Then \n"];

If[DEFINITION[UseNonStandardYukwas]=!=True,
WriteString[sphenoCoup,"  If (m_in.le.mz) Then \n"];
If[AddOHDM=!=True,
WriteString[sphenoCoup,"    Call RunSM(mz,deltaM,"<>SPhenoForm[VEVSM2]<>"/"<>SPhenoForm[VEVSM1]<>","<>SPhenoForm[hyperchargeCoupling]<>","<>SPhenoForm[leftCoupling]<>","<>SPhenoForm[strongCoupling]<>","<>SPhenoForm[UpYukawa]<>","<>SPhenoForm[DownYukawa]<>","<>SPhenoForm[ElectronYukawa]<>","<>SPhenoForm[VEVSM1]<>","<>SPhenoForm[VEVSM2]<>") \n"];,
WriteString[sphenoCoup,"Call RunSMohdm(mz,deltaM, "<>SPhenoForm[hyperchargeCoupling]<>","<>SPhenoForm[leftCoupling]<>","<>SPhenoForm[strongCoupling]<>","<>SPhenoForm[UpYukawa]<>","<>SPhenoForm[DownYukawa]<>","<>SPhenoForm[ElectronYukawa]<>","<>SPhenoForm[VEVSM]<>") \n"];
];
WriteString[sphenoCoup,"  Else \n"];
If[AddOHDM=!=True,
WriteString[sphenoCoup,"    Call RunSM(m_in,deltaM,"<>SPhenoForm[VEVSM2]<>"/"<>SPhenoForm[VEVSM1]<>","<>SPhenoForm[hyperchargeCoupling]<>","<>SPhenoForm[leftCoupling]<>","<>SPhenoForm[strongCoupling]<>","<>SPhenoForm[UpYukawa]<>","<>SPhenoForm[DownYukawa]<>","<>SPhenoForm[ElectronYukawa]<>","<>SPhenoForm[VEVSM1]<>","<>SPhenoForm[VEVSM2]<>") \n"];,
WriteString[sphenoCoup,"Call RunSMohdm(m_in,deltaM, "<>SPhenoForm[hyperchargeCoupling]<>","<>SPhenoForm[leftCoupling]<>","<>SPhenoForm[strongCoupling]<>","<>SPhenoForm[UpYukawa]<>","<>SPhenoForm[DownYukawa]<>","<>SPhenoForm[ElectronYukawa]<>","<>SPhenoForm[VEVSM]<>") \n"];
];
WriteString[sphenoCoup,"  End if \n"];
WriteString[sphenoCoup,"End if \n"];,
WriteString[sphenoCoup,"  If (m_in.le.mz) Then \n"];
WriteString[sphenoCoup,"Call RunSMohdm(mz,deltaM, "<>SPhenoForm[hyperchargeCoupling]<>","<>SPhenoForm[leftCoupling]<>","<>SPhenoForm[strongCoupling]<>",Y_u,Y_d,Y_l, vSM) \n"];
WriteString[sphenoCoup,"  Else \n"];
WriteString[sphenoCoup,"Call RunSMohdm(m_in,deltaM, "<>SPhenoForm[hyperchargeCoupling]<>","<>SPhenoForm[leftCoupling]<>","<>SPhenoForm[strongCoupling]<>",Y_u,Y_d,Y_l, vSM) \n"];
WriteString[sphenoCoup,"  End if \n"];
If[AddOHDM=!=True,
WriteString[sphenoCoup,"vd_aux =  vSM/Sqrt(1._dp+"<>SPhenoForm[TanBeta]<>"**2)  \n"];
WriteString[sphenoCoup,"vu_aux =  vd_aux*"<>SPhenoForm[TanBeta]<>"\n"];
WriteString[sphenoCoup,"Y_u=Y_u*vSM/vu_aux\n"];
WriteString[sphenoCoup,"Y_d=Y_d*vSM/vd_aux\n"];
WriteString[sphenoCoup,"Y_l=Y_l*vSM/vd_aux\n"];
];
For[i=1,i<=Length[DEFINITION[MoreEWvevs]],
WriteString[sphenoCoup,StringReplace[DEFINITION[MoreEWvevs][[i]],{"vev2"->"vSM**2"}] <>"\n"];
i++;];
For[i=1,i<=Length[DEFINITION[NonStandardYukawasRelations]],
WriteString[sphenoCoup,StringReplace[DEFINITION[NonStandardYukawasRelations][[i]],{"vd"->"vd_aux","vu"->"vu_aux"}] <>"\n"];
i++;];
WriteString[sphenoCoup,"End if \n"];
];
];
]; 

If[(particle===HiggsBoson || particle===PseudoScalar) &&  SupersymmetricModel===False,
WriteString[sphenoCoup,"! Run always SM gauge couplings if present \n"];
WriteString[sphenoCoup,"  Qin=sqrt(getRenormalizationScale()) \n"];
WriteString[sphenoCoup,"  Call RunSMohdm(m_in,deltaM,g1SM,g2SM,g3SM,YuSM,YdSM,YeSM,vSM) \n"];
WriteString[sphenoCoup,"   ! SM pole masses needed for diphoton/digluon rate \n"];
WriteString[sphenoCoup,"   ! But only top and W play a role. \n"];
WriteString[sphenoCoup,"   vSM=1/Sqrt((G_F*Sqrt(2._dp))) ! On-Shell VEV needed for loop \n"];
WriteString[sphenoCoup,"   YuSM(3,3)=sqrt(2._dp)*mf_u(3)/vSM  ! On-Shell top needed in loop \n"];
WriteString[sphenoCoup,"   ! Other running values kept to get H->ff correct \n"];

SetMatchingConditions[sphenoCoup];

(*
For[i=1,i\[LessEqual]Length[BoundaryLowScaleInput],
If[Select[{vSM,YdSM,YeSM,YuSM,g1SM,g2SM,g3SM},FreeQ[BoundaryLowScaleInput[[i,2]],#]\[Equal]False&]=!={},
WriteString[sphenoCoup,SPhenoForm[BoundaryLowScaleInput[[i,1]]]<>"="<>SPhenoForm[BoundaryLowScaleInput[[i,2]]]<>"\n"];
];
i++;];
*)
];


If[(particle===HiggsBoson || particle===PseudoScalar) && FreeQ[parameters,hyperchargeCoupling] ==False && FreeQ[parameters,strongCoupling] ==False&& FreeQ[parameters,leftCoupling] ==False,
WriteString[sphenoCoup,"! Run always SM gauge couplings if present \n"];
WriteString[sphenoCoup,"! alphaS(mH/2) for NLO corrections to diphoton rate \n"];
WriteString[sphenoCoup,"Call RunSMgauge(m_in/2._dp,deltaM, "<>SPhenoForm[hyperchargeCoupling]<>","<>SPhenoForm[leftCoupling]<>","<>SPhenoForm[strongCoupling]<>") \n"];
];
If[(particle===HiggsBoson || particle===PseudoScalar),
WriteString[sphenoCoup,"AlphaSQhlf="<>SPhenoForm[strongCoupling]<>"**2/(4._dp*Pi) \n"];
];
If[(particle===HiggsBoson || particle===PseudoScalar) && FreeQ[parameters,hyperchargeCoupling] ==False && FreeQ[parameters,strongCoupling] ==False&& FreeQ[parameters,leftCoupling] ==False,
WriteString[sphenoCoup,"! alphaS(mH) for digluon rate \n"];
WriteString[sphenoCoup,"Call RunSMgauge(m_in,deltaM, "<>SPhenoForm[hyperchargeCoupling]<>","<>SPhenoForm[leftCoupling]<>","<>SPhenoForm[strongCoupling]<>") \n"];
];
If[(particle===HiggsBoson || particle===PseudoScalar),
WriteString[sphenoCoup,"AlphaSQ="<>SPhenoForm[strongCoupling]<>"**2/(4._dp*Pi) \n"];
];

WriteTadpoleSolution[sphenoCoup];

(* Check if Higgs boson to calculate the effective couplings *)


WriteString[sphenoCoup,"! --- Calculate running tree-level masses for loop induced couplings and Quark mixing matrices --- \n"];


MakeCall["TreeMasses",Join[NewMassParameters,Join[listVEVs,listAllParameters]],{},{".True.","kont"},sphenoCoup];

(*
If[FreeQ[ParameterDefinitions,"Scalar-Mixing-Matrix"]\[Equal]False,
WriteString[sphenoCoup,SPhenoForm[HiggsMixingMatrix] <>" = "<> SPhenoForm[HiggsMixingMatrix]<>"input \n"];
];
If[FreeQ[ParameterDefinitions,"Pseudo-Scalar-Mixing-Matrix"]\[Equal]False,
WriteString[sphenoCoup,SPhenoForm[PseudoScalarMixingMatrix] <>" = "<> SPhenoForm[PseudoScalarMixingMatrix]<>"input \n"];
];
*)

WriteString[sphenoCoup,"If (ExternalZfactors) Then \n"];
WriteString[sphenoCoup,"! --- Use the 1-loop mixing matrices calculated at M_SUSY in the vertices --- \n"];
For[i=1,i<=Length[NewMassParameters],
If[Length[getDimSPheno[NewMassParameters[[i]]]]==2 && FreeQ[{ElectronMatrixL, ElectronMatrixR, UpMatrixR, UpMatrixL, DownMatrixR,DownMatrixL},NewMassParameters[[i]]],
WriteString[sphenoCoup,SPhenoForm[NewMassParameters[[i]]] <>" = "<> SPhenoForm[NewMassParameters[[i]]]<>"input \n"];
];
i++;];
WriteString[sphenoCoup,"End if \n"];




If[(particle===HiggsBoson || particle == PseudoScalar) && suffix ==="2B",
SPhenoCouplings= Select[SPhenoCouplingsAll,(FreeQ[couplings,#[[2,2]]]==False)&];

For[i=1,i<=Length[SPhenoCouplings],
If[Length[SPhenoCouplings[[i,2]]]==2,
WriteString[sphenoCoup, ToString[SPhenoCouplings[[i,2,2]]] <> " = 0._dp \n"];,
WriteString[sphenoCoup, ToString[SPhenoCouplings[[i,2,2]]] <> " = 0._dp \n"];
WriteString[sphenoCoup, ToString[SPhenoCouplings[[i,2,3]]] <> " = 0._dp \n"];
];

OpenDoes[{getIndexRangeSPheno[SPhenoCouplings[[i,2,2]]]},sphenoCoup];

cNames="";
For[i1=2,i1<=Length[SPhenoCouplings[[i,2]]],
cNames = cNames <> ToString[SPhenoCouplings[[i,2,i1]]] <> AddDimNames2[SPhenoCouplings[[i,2,i1]]]<>","; 
i1++;];

cNames = StringDrop[cNames,-1];

MakeCall[SPhenoCouplings[[i,2,1]]<>"T",Join[SPhenoCouplings[[i,3]],SPhenoCouplings[[i,4]]],{},{cNames},sphenoCoup];

CloseDoes[sphenoCoup];

WriteString[sphenoCoup,"\n\n"];

i++;];

Clear[i1,i2,i3,i4];

If[SupersymmetricModel===True,
WriteString[sphenoCoup,"vev = "<>SPhenoForm[2Sqrt[- Vertex[{VectorW,conj[VectorW]}][[2,1]]/leftCoupling^2] /. sum[a_,b_,c_,d_]:>Sum[d,{a,b,c}]] <>"\n"];,
WriteString[sphenoCoup,"vev=1/Sqrt((G_F*Sqrt(2._dp)))\n"];
];


(* couplings have to be weightet with doublet-fraction! *)

If[FreeQ[couplings,cplHiggsWWvirt]==False,WriteString[sphenoCoup, "cplHiggsWWvirt = " <>ToString[getSPhenoCoupling[C[HiggsBoson,VectorW,conj[VectorW]],SPhenoCouplingsAll][[1,1]]] <>"/vev \n"];];

If[FreeQ[couplings,cplHiggsZZvirt]==False, 
If[FreeQ[ParameterDefinitions,"Weinberg-Angle"]==False ,
WriteString[sphenoCoup, "cplHiggsZZvirt = " <>ToString[getSPhenoCoupling[C[HiggsBoson,VectorZ,VectorZ],SPhenoCouplingsAll][[1,1]]] <>"*Sqrt(7._dp/12._dp-10._dp/9._dp*Sin("<>SPhenoForm[Weinberg]<>")**2+40._dp/27._dp*Sin("<>SPhenoForm[Weinberg]<>")**4)/vev \n \n\n"];,
WriteString[sphenoCoup, "cplHiggsZZvirt = " <>ToString[getSPhenoCoupling[C[HiggsBoson,VectorZ,VectorZ],SPhenoCouplingsAll][[1,1]]] <>"*Sqrt(7._dp/12._dp-10._dp/9._dp*0.22290_dp+40._dp/27._dp*(0.22290_dp)**2)/vev \n \n\n"];

];
];
];

If[( particle===PseudoScalar),
WriteHiggsBoundsRatiosPseudoScalar[sphenoCoup, SA`CurrentStates, Table[SPhenoCouplingsAll[[i,1,1]],{i,1,Length[SPhenoCouplingsAll]}]];
];

If[(particle===HiggsBoson),
WriteHiggsBoundsRatiosScalar[sphenoCoup, SA`CurrentStates, Table[SPhenoCouplingsAll[[i,1,1]],{i,1,Length[SPhenoCouplingsAll]}]];
];


WriteString[sphenoCoup,"If (PoleMassesInLoops) Then \n"];
WriteString[sphenoCoup,"! --- Use the pole masses --- \n"];
For[i=1,i<=Length[NewMassParameters],
If[Length[getDimSPheno[NewMassParameters[[i]]]]==1,
WriteString[sphenoCoup,SPhenoForm[NewMassParameters[[i]]] <>" = "<> SPhenoForm[NewMassParameters[[i]]]<>"input \n"];
];
i++;];
WriteString[sphenoCoup,"End if \n"];

If[particle===HiggsBoson && suffix ==="2B",
WriteScalarHiggsCouplingsRatio[sphenoCoup, SA`CurrentStates, Table[SPhenoCouplingsAll[[i,1,1]],{i,1,Length[SPhenoCouplingsAll]}]];
WriteString[sphenoCoup,"If (HigherOrderDiboson) Then \n"];
WriteString[sphenoCoup, "  gNLO = Sqrt(AlphaSQhlf*4._dp*Pi) \n"];
WriteString[sphenoCoup,"Else  \n"];
WriteString[sphenoCoup, "  gNLO = -1._dp \n"];
WriteString[sphenoCoup,"End if \n"];

MakeCall["CoupHiggsToPhoton",Flatten[{NeededRatiosLoopCouplingsPhoton,NeededMassesLoopPhoton}],{"m_in","i1"},{"gNLO","coup"},sphenoCoup];
If[getGenSPheno[HiggsBoson]>1,addgen="(i1)";,addgen="";];
WriteString[sphenoCoup,"cplHiggsPP"<>addgen<>" = coup*Alpha \n"]; 
WriteString[sphenoCoup,"CoupHPP"<>addgen<>" = coup \n"];
MakeCall["CoupHiggsToPhotonSM",Flatten[{NeededMassesLoopPhoton}],{"m_in"},{"gNLO","coup"},sphenoCoup];
WriteString[sphenoCoup,"ratioPP"<>addgen<>" = Abs(cplHiggsPP"<>addgen<>"/(coup*Alpha)) \n"];

WriteString[sphenoCoup, "  gNLO = -1._dp \n"];
MakeCall["CoupHiggsToGluon",Flatten[{NeededRatiosLoopCouplingsGluon,NeededMassesLoopGluon}],{"m_in","i1"},{"gNLO","coup"},sphenoCoup];
WriteString[sphenoCoup,"cplHiggsGG"<>addgen<>" = coup*AlphaSQ \n"]; 
WriteString[sphenoCoup,"CoupHGG"<>addgen<>" = coup \n"];
MakeCall["CoupHiggsToGluonSM",Flatten[{NeededMassesLoopGluon}],{"m_in"},{"gNLO","coup"},sphenoCoup];

WriteString[sphenoCoup,"If (HigherOrderDiboson) Then \n"];
WriteString[sphenoCoup,"  NLOqcd = 12._dp*oo48pi2*(95._dp/4._dp - 7._dp/6._dp*NFlav(m_in))*"<>SPhenoForm[strongCoupling]<>"**2 \n"];
WriteString[sphenoCoup,"  NNLOqcd = 0.0005785973353112832_dp*(410.52103034222284_dp - 52.326413200014684_dp*NFlav(m_in)+NFlav(m_in)**2 & \n & +(2.6337085360233763_dp +0.7392866066030529_dp *NFlav(m_in))*Log(m_in**2/mf_u(3)**2))*"<>SPhenoForm[strongCoupling]<>"**4 \n"];
WriteString[sphenoCoup,"  NNNLOqcd = 0.00017781840290519607_dp*(42.74607514668917_dp + 11.191050460173795_dp*Log(m_in**2/mf_u(3)**2) + Log(m_in**2/mf_u(3)**2)**2)*"<>SPhenoForm[strongCoupling]<>"**6 \n"];
WriteString[sphenoCoup,"Else \n"];
WriteString[sphenoCoup,"  NLOqcd = 0._dp \n"];
WriteString[sphenoCoup,"  NNLOqcd = 0._dp \n"];
WriteString[sphenoCoup,"  NNNLOqcd = 0._dp \n"];
WriteString[sphenoCoup,"End if \n"];

WriteString[sphenoCoup,"coup = coup*Sqrt(1._dp + NLOqcd+NNLOqcd+NNNLOqcd) \n"];
WriteString[sphenoCoup,"cplHiggsGG"<>addgen<>" = cplHiggsGG"<>addgen<>"*Sqrt(1._dp + NLOqcd+NNLOqcd+NNNLOqcd) \n"]; 


WriteString[sphenoCoup,"CoupHGG"<>addgen<>"=cplHiggsGG"<>addgen<>" \n"];
WriteString[sphenoCoup,"ratioGG"<>addgen<>" = Abs(cplHiggsGG"<>addgen<>"/(coup*AlphaSQ)) \n"];





WriteString[sphenoCoup,"If (i1.eq.1) Then \n"];
If[FreeQ[namesAll,SPhenoCoupling[CS[HiggsBoson,PseudoScalar,VectorZ]]]==False && (getGenSPhenoStart[PseudoScalar]<=getGenSPheno[PseudoScalar]),
WriteString[sphenoCoup,"CPL_A_H_Z = Abs(Transpose("<>ToString[SPhenoCoupling[CS[HiggsBoson,PseudoScalar,VectorZ]]]<>")**2/("<>ToString[leftCoupling]<>"**2/(cos("<>SPhenoForm[Weinberg]<>")**2*4._dp)))\n"];,
If[FreeQ[namesAll,SPhenoCoupling[CS[PseudoScalar,HiggsBoson,VectorZ]]]==False && getGen[PseudoScalar]>1 && (getGenSPhenoStart[PseudoScalar]<=getGenSPheno[PseudoScalar]),
WriteString[sphenoCoup,"CPL_A_H_Z = Abs("<>ToString[SPhenoCoupling[CS[PseudoScalar,HiggsBoson,VectorZ]]]<>"**2/("<>ToString[leftCoupling]<>"**2/(cos("<>SPhenoForm[Weinberg]<>")**2*4._dp)))\n"];,
If[FreeQ[ParticleDefinitions[SPheno`Eigenstates],"Higgs"]===False && FreeQ[ParticleDefinitions[SPheno`Eigenstates],"Pseudo-Scalar Higgs"]===False,
WriteString[sphenoCoup,"CPL_A_H_Z = 0 \n"];
];
];
];

If[FreeQ[namesAll,SPhenoCoupling[CS[HiggsBoson,HiggsBoson,VectorZ]]]==False,
WriteString[sphenoCoup,"CPL_H_H_Z = Abs("<>ToString[SPhenoCoupling[CS[HiggsBoson,HiggsBoson,VectorZ]]]<>"**2/("<>ToString[leftCoupling]<>"**2/(cos("<>SPhenoForm[Weinberg]<>")*4._dp)))\n"];,
If[FreeQ[ParticleDefinitions[SPheno`Eigenstates],"Higgs"]===False,
WriteString[sphenoCoup,"CPL_H_H_Z = 0._dp \n"];
];
];
WriteString[sphenoCoup,"End if \n"];
];


If[particle===PseudoScalar && suffix ==="2B",
WritePseudoScalarCouplingsRatio[sphenoCoup,SA`CurrentStates, Table[SPhenoCouplingsAll[[i,1,1]],{i,1,Length[SPhenoCouplingsAll]}]];
If[getGenSPheno[PseudoScalar]>1,addgen="(i1)";,addgen="";];
WriteString[sphenoCoup,"If (HigherOrderDiboson) Then \n"];
WriteString[sphenoCoup, "  gNLO = g3 \n"];
WriteString[sphenoCoup,"Else  \n"];
WriteString[sphenoCoup, "  gNLO = -1._dp \n"];
WriteString[sphenoCoup,"End if \n"];






MakeCall["CoupPseudoHiggsToPhoton",Flatten[{NeededRatiosLoopCouplingsPhotonPseudo,NeededMassesLoopPhoton}],{"m_in","i1"},{"gNLO","coup"},sphenoCoup];
WriteString[sphenoCoup,"cplPseudoHiggsPP"<>addgen<>" = 2._dp*coup*Alpha \n"]; 
WriteString[sphenoCoup,"CoupAPP"<>addgen<>" = 2._dp*coup \n"];
(* MakeCall["CoupPseudoHiggsToPhotonSM",Flatten[{NeededMassesLoopPhoton}],{"m_in"},{"gNLO","coup"},sphenoCoup]; 
WriteString[sphenoCoup,"ratioPPP"<>addgen<>" = Abs(cplPseudoHiggsPP"<>addgen<>"/(2._dp*coup*oo4pi*(1._dp-mW2/mZ2)*"<>SPhenoForm[leftCoupling]<>"**2))**2 \n"]; *)
MakeCall["CoupHiggsToPhotonSM",Flatten[{NeededMassesLoopPhoton}],{"m_in"},{"gNLO","coup"},sphenoCoup]; 
WriteString[sphenoCoup,"ratioPPP"<>addgen<>" = Abs(cplPseudoHiggsPP"<>addgen<>"/(coup*oo4pi*(1._dp-mW2/mZ2)*"<>SPhenoForm[leftCoupling]<>"**2)) \n"];

WriteString[sphenoCoup, "  gNLO = -1._dp \n"];
MakeCall["CoupPseudoHiggsToGluon",Flatten[{NeededRatiosLoopCouplingsGluonPseudo,NeededMassesLoopGluon}],{"m_in","i1"},{"gNLO","coup"},sphenoCoup];


WriteString[sphenoCoup,"If (HigherOrderDiboson) Then \n"];
WriteString[sphenoCoup,"  NLOqcd = 12._dp*oo48pi2*(97._dp/4._dp - 7._dp/6._dp*NFlav(m_in))*"<>SPhenoForm[strongCoupling]<>"**2 \n"];
WriteString[sphenoCoup,"  NNLOqcd = (171.544_dp +  5._dp*Log(m_in**2/mf_u(3)**2))*"<>SPhenoForm[strongCoupling]<>"**4/(4._dp*Pi**2)**2 \n"];
WriteString[sphenoCoup,"  NNNLOqcd = 0._dp \n"];
WriteString[sphenoCoup,"Else \n"];
WriteString[sphenoCoup,"  NLOqcd = 0._dp \n"];
WriteString[sphenoCoup,"  NNLOqcd = 0._dp \n"];
WriteString[sphenoCoup,"  NNNLOqcd = 0._dp \n"];
WriteString[sphenoCoup,"End if \n"];

WriteString[sphenoCoup,"cplPseudoHiggsGG"<>addgen<>" = 2._dp*coup*AlphaSQ*Sqrt(1._dp + NLOqcd+NNLOqcd+NNNLOqcd) \n"]; 
WriteString[sphenoCoup,"CoupAGG"<>addgen<>" = 2._dp*coup*AlphaSQ*Sqrt(1._dp + NLOqcd+NNLOqcd+NNNLOqcd) \n"];

(* MakeCall["CoupPseudoHiggsToGluonSM",Flatten[{NeededMassesLoopGluon}],{"m_in"},{"gNLO","coup"},sphenoCoup];
WriteString[sphenoCoup,"coup = coup*Sqrt(1._dp + NLOqcd+NNLOqcd+NNNLOqcd) \n"];
WriteString[sphenoCoup,"ratioPGG"<>addgen<>" = Abs(cplPseudoHiggsGG"<>addgen<>"/(2._dp*coup*AlphaSQ))**2 \n"]; *)
MakeCall["CoupHiggsToGluonSM",Flatten[{NeededMassesLoopGluon}],{"m_in"},{"gNLO","coup"},sphenoCoup];
WriteString[sphenoCoup,"coup = coup*Sqrt(1._dp + NLOqcd+NNLOqcd+NNNLOqcd) \n"];
WriteString[sphenoCoup,"ratioPGG"<>addgen<>" = Abs(cplPseudoHiggsGG"<>addgen<>"/(coup*AlphaSQ)) \n"]; 

WriteString[sphenoCoup, "\n"];





WriteString[sphenoCoup, "If (i1.eq."<>ToString[getGenSPhenoStart[PseudoScalar]]<>") Then \n"];
If[FreeQ[namesAll,SPhenoCoupling[CS[PseudoScalar,PseudoScalar,VectorZ]]]==False,
(* CHANGED 03.05.15 *)
WriteString[(*sphenoBR,*)sphenoCoup,"CPL_A_A_Z = Abs("<>ToString[SPhenoCoupling[CS[PseudoScalar,PseudoScalar,VectorZ]]]<>"**2/("<>ToString[leftCoupling]<>"**2/(cos("<>SPhenoForm[Weinberg]<>")**2*4._dp)))\n"];,
If[FreeQ[ParticleDefinitions[SPheno`Eigenstates],"Pseudo-Scalar Higgs"]===False,
WriteString[(*sphenoBR,*)sphenoCoup,"CPL_A_A_Z = 0._dp \n"];
];
];
WriteString[sphenoCoup, "End if \n"];

];


(* WriteString[sphenoCoup,"! --- Use the 1-loop mixing matrices calculated at M_SUSY in the vertices --- \n"];
For[i=1,i\[LessEqual]Length[NewMassParameters],
If[Length[getDimSPheno[NewMassParameters[[i]]]]\[Equal]2 && FreeQ[{ElectronMatrixL, ElectronMatrixR, UpMatrixR, UpMatrixL, DownMatrixR,DownMatrixL,HiggsMixingMatrix},NewMassParameters[[i]]],
WriteString[sphenoCoup,SPhenoForm[NewMassParameters[[i]]] <>" = "<> SPhenoForm[NewMassParameters[[i]]]<>"input \n"];
];
i++;]; *)



SPhenoCouplings= Select[SPhenoCouplingsAll,(FreeQ[couplings,#[[2,2]]]==False)&];

For[i=1,i<=Length[SPhenoCouplings],
If[Length[SPhenoCouplings[[i,2]]]==2,
WriteString[sphenoCoup, ToString[SPhenoCouplings[[i,2,2]]] <> " = 0._dp \n"];,
WriteString[sphenoCoup, ToString[SPhenoCouplings[[i,2,2]]] <> " = 0._dp \n"];
WriteString[sphenoCoup, ToString[SPhenoCouplings[[i,2,3]]] <> " = 0._dp \n"];
];

OpenDoes[{getIndexRangeSPheno[SPhenoCouplings[[i,2,2]]]},sphenoCoup];

cNames="";
For[i1=2,i1<=Length[SPhenoCouplings[[i,2]]],
cNames = cNames <> ToString[SPhenoCouplings[[i,2,i1]]] <> AddDimNames2[SPhenoCouplings[[i,2,i1]]]<>","; 
i1++;];

cNames = StringDrop[cNames,-1];

MakeCall[SPhenoCouplings[[i,2,1]]<>"T",Join[SPhenoCouplings[[i,3]],SPhenoCouplings[[i,4]]],{},{cNames},sphenoCoup];

CloseDoes[sphenoCoup];

WriteString[sphenoCoup,"\n\n"];

i++;];


WriteString[sphenoCoup,"Iname = Iname - 1 \n \n"];
WriteString[sphenoCoup,"End subroutine CouplingsFor_"<>SPhenoForm[particle]<>"_decays_"<>suffix<>"\n \n"];
];
