(*******************************************************************
This file was generated automatically by the Mathematica front end.
It contains Initialization cells from a Notebook file, which
typically will have the same name as this file except ending in
".nb" instead of ".m".

This file is intended to be loaded into the Mathematica kernel using
the package loading commands Get or Needs.  Doing so is equivalent
to using the Evaluate Initialization Cells menu command in the front
end.

DO NOT EDIT THIS FILE.  This entire file is regenerated
automatically each time the parent Notebook file is saved in the
Mathematica front end.  Any changes you make to this file will be
overwritten.
***********************************************************************)

GenerateSPhenoCouplingList:=Block[{i,currentRegime,readRegime},
      Print["--------------------------------------"];
      Print["Writing Couplings-File for SPheno "];
      Print["--------------------------------------"];
      
      $sarahCurrentSPhenoDir=ToFileName[{$sarahCurrentOutputDir,"SPheno"}];
      (* CreateDirectory[$sarahCurrentSPhenoDir]; *)
      
      sphenoCoup=
        OpenWrite[
          ToFileName[$sarahCurrentSPhenoDir,
            "Couplings_"<>ModelName<>".f90"]];
      
      SubNonAbelianNonSelf={};
      SubNonAbelianSelf={};
      
       For[i=1,i\[LessEqual]Length[Gauge],
        If[Gauge[[i,2]]=!=U[1] && FreeQ[BrokenSymmetries,i],
          
          SubNonAbelianNonSelf=
            Join[SubNonAbelianNonSelf,{Gauge[[i,4]]\[Rule]0}];
          
          SubNonAbelianSelf=
            Join[SubNonAbelianSelf,{Gauge[[i,4]]\[Rule]Sqrt[4/3]}];
          ];
        i++;]; 
      
      If[IntermediateScale =!=True,
        WriteCouplingHeader;
        
        
        Print["Writing Subroutine for All Coupling"];
        
        AllRelevant=getAllRelevantCouplings[VertexListNonCC];
        temp=SPhenoCouplingList[AllRelevant];
        SPhenoCouplingsAll=temp[[1]];
        parametersAll=temp[[2]];
        namesAll=temp[[3]];
        
        WriteSPhenoAllCouplings[SPhenoCouplingsAll,parametersAll,namesAll,
          "AllCouplings"]; 
        WriteSPhenoCouplings[SPhenoCouplingsAll,False]; 
        ];
      
      Print["Writing Couplings for Loop Calculations"];
      
      
      sum[a_,b_,c_,d_]:=Block[{res,j},
            deltas=Cases[d,x:(Delta[a+s_,y_]),10];
            res=d*ThetaStep[a,c];
            summand = Cases[deltas,x_?NumberQ,3][[1]];
            
            res =res /. 
                Flatten[
                  Table[{deltas[[j,2]]-summand\[Rule]
                        deltas[[j,1]]-summand},{j,1,Length[deltas]}]];
            Return[res];
            ] /; (FreeQ[d,Delta[a+s_,_]]\[Equal]False && 
              FreeQ[d,StillCalcSum]\[Equal]True);
      
      
      temp=SPhenoCouplingList[VerticesGaugeMassES];
      SPhenoCouplingsLoop=temp[[1]];
      parametersLoop=temp[[2]];
      namesLoop=temp[[3]];
      If[IntermediateScale ===True,
        WriteSPhenoAllCouplings[SPhenoCouplingsLoop,parametersLoop,namesLoop,
            "CouplingsForLoopMassesRegime"<>ToString[RegimeNr]];,
        WriteSPhenoAllCouplings[SPhenoCouplingsLoop,parametersLoop,namesLoop,
            "CouplingsForLoopMasses"]; 
        ];
       
      WriteSPhenoCouplings[SPhenoCouplingsLoop,True];
      
      If[IntermediateScale =!=True,
        
        (*
          Print["Writing Couplings for Higgs"];
          
          temp = SPhenoCouplingList[Cases[VertexListNonCC,x_?FreeQHB]]; 
          SPhenoCouplingsHB=temp[[1]];
          parametersHB=temp[[2]];
          namesHB=temp[[3]];
          
          WriteSPhenoAllCouplings[SPhenoCouplingsHB,parametersHB,namesHB,
            "CouplingsForHiggsBounds"]; 
          *)
        
        
        Print["Writing Couplings Loop Corrections of W and Z"];
        
        
        temp = SPhenoCouplingList[Cases[VerticesGaugeMassES,x_?FreeQZW]]; 
        SPhenoCouplingsZW=temp[[1]];
        parametersZW=temp[[2]];
        namesZW=temp[[3]];
        WriteSPhenoAllCouplings[SPhenoCouplingsZW,parametersZW,namesZW,
          "CouplingsForVectorBosons"]; 
        
        
        Print["Writing Couplings for Loop Corrections of SM Fermions"];
        
        
        temp = SPhenoCouplingList[Cases[VerticesGaugeMassES,x_?FreeQebt]]; 
        SPhenoCouplingsEBT=temp[[1]];
        parametersEBT=temp[[2]];
        namesEBT=temp[[3]];
        WriteSPhenoAllCouplings[SPhenoCouplingsEBT,parametersEBT,namesEBT,
          "CouplingsForSMfermions"]; 
        
        Print["Writing Couplings for effective Higgs Interactions"];
        
        
        temp =SPhenoCouplingList[Cases[VerticesGaugeMassES,x_?FreeQUHiggs]];
        SPhenoCouplingsTadpoles=temp[[1]];
        parametersTadpoles=temp[[2]];
        namesTadpoles=temp[[3]];
        WriteSPhenoAllCouplings[SPhenoCouplingsTadpoles,parametersTadpoles,
          namesTadpoles,"CouplingsForTadpoles"];  
        
        
        WriteThetaDelta;
        
        ];
      
      If[IntermediateScale =!= True,
        WriteString[sphenoCoup,"End Module Couplings_"<>ModelName<>" \n"];
        ];
      
      Close[sphenoCoup];
      ];

FreeQZW[x_]:=Block[{i,temp},
      If[FreeQ[x,VectorZ]\[Equal]False || FreeQ[x,VectorW]\[Equal]False,
          temp=True;
          For[i=1,i\[LessEqual]Length[GaugeMassES],
            If[FreeQ[x,GaugeMassES[[i]]]\[Equal]False,
              temp=False;
              ];
            i++;];
          Return[temp];,
          Return[False]];
      ];


FreeQHB[x_]:=Block[{i,temp},
      If[FreeQ[x,VectorZ]\[Equal]False && FreeQ[x,HiggsBoson]\[Equal]False && 
            FreeQ[x,PseudoScalar]\[Equal]False,
          Return[True];,
          Return[False]];
      ];

FreeQebt[x_]:=Block[{i,temp},
      If[FreeQ[x,UElectron]\[Equal]False || FreeQ[x,UTop]\[Equal]False || 
            FreeQ[x,UBottom]\[Equal]False,
          Return[True];,
          Return[False]];
      ];

FreeQUHiggs[x_]:=Block[{i,temp},
      If[FreeQ[x,UnmixedHiggs]\[Equal]False,
          Return[True];,
          Return[False]];
      ];



getAllRelevantCouplings[list_]:=Block[{i,temp},
      temp={};
      For[i=1,i\[LessEqual]Length[list],
        If[
          list[[i,2]]===SSS || list[[i,2]]===SSV || list[[i,2]]===SVV || 
            list[[i,2]]===FFS || list[[i,2]]===FFV,
          temp = Join[temp,{list[[i]]}];
          ];
        i++;];
      Return[temp];
      ];

getNeededParametersForCouplings[list_]:=Block[{parameters,pos},
      parameters={};
      For[i=1,i\[LessEqual]Length[list],
        pos=Position[SPhenoCouplingsAll,list[[i]]];
        If[pos==={},
          pos=Position[SPhenoCouplingsAll,AntiField/@list[[i]]];
          ];
        parameters=
          Join[parameters,Extract[SPhenoCouplingsAll,pos[[1,1]]][[4]]];
        i++;];
      Return[Intersection[parameters]];
      ];


SPhenoCouplingList[listCouplings_]:=
    Block[{n1,i2,i,SPhenoCouplings, parameterNames,couplingNames, factor},
      
      Print["Building Coupling List"];
      
      coupNr=1;
      
      couplingNames = {};
      parameterNames ={};
      
      subCouplingsSPheno={Lam[a__]\[Rule]2,Sig[a__]\[Rule]2, 
          fSU3[a__]\[Rule]1, fSU2[a__]\[Rule]1};
      
      For[i2=1,i2\[LessEqual]4,
        subCouplingsSPheno=
          Join[subCouplingsSPheno,(subValue[i2,1] /. subIndFinal[i2,i2])];
        i2++;];
      
      
      SPhenoCouplings={};
      For[n1=1,n1\[LessEqual]Length[listCouplings],
        If[Length[listCouplings[[n1,1]]]\[Equal]2,
          If[listCouplings[[n1,2]]===SSSS,
            value=sumOverNonAbelianIndizes[listCouplings[[n1]]];,
            value=listCouplings[[n1,1,2,1]] ;
            ];
          
          If[listCouplings[[n1,2]]===SSV,factor=-1;,factor=1;];
          
          
          SPhenoCouplings= 
            Join[SPhenoCouplings,{{{Apply[C,
                      listCouplings[[n1,1,1]] /. 
                        A_[{a__}]\[Rule] A]},{CouplingName[
                      listCouplings[[n1,1,1]]], 
                    SPhenoCoupling[listCouplings[[n1,1,1]]]},{},{},
                  factor*value /. subCouplingsSPheno,
                  listCouplings[[n1,1,1]]}}];
          
          
          
          couplingNames = 
            Join[couplingNames,{ SPhenoCoupling[listCouplings[[n1,1,1]]]}];,
           
          SPhenoCouplings=
            Join[SPhenoCouplings,{{{Apply[C,
                      listCouplings[[n1,1,1]] /. 
                        A_[{a__}]\[Rule] A]},{CouplingName[
                      listCouplings[[n1,1,1]]],
                    SPhenoCouplingLeft[listCouplings[[n1,1,1]]],
                    SPhenoCouplingRight[listCouplings[[n1,1,1]]]},{},{},
                  listCouplings[[n1,1,2,1]]/.subCouplingsSPheno,
                  listCouplings[[n1,1,3,1]] /. subCouplingsSPheno,
                  listCouplings[[n1,1,1]]}}];
          
          couplingNames = 
            Join[couplingNames,{ SPhenoCouplingLeft[listCouplings[[n1,1,1]]],
                SPhenoCouplingRight[listCouplings[[n1,1,1]]]}];
          ];
        
        
        
        
        NewParameters={};
        NewParametersSplit={};
        For[i2=1,i2\[LessEqual]Length[listCouplings[[n1,1,1]]],
          If[getGenSPheno[listCouplings[[n1,1,1,i2]]]\[Equal]1,
            indRange={};,
            
            indRange = {{generation,
                        getGenSPheno[listCouplings[[n1,1,1,i2]]]}} /. 
                    subGC[i2] /. subIndFinal[i2,i2];
            ];
          If[indRange =!={},
            
            SPhenoCouplings[[coupNr,3]]=
                Join[SPhenoCouplings[[coupNr,3]],Transpose[indRange][[1]]];
            ];
          NewParameters = Join[NewParameters,indRange];
          NewParametersSplit = Join[NewParametersSplit,indRange];
          i2++;];
        
        
        
        
        If[NewParameters==={},
          NewP1 = {};
          NewP2 ={};,
          NewP1 =Transpose[NewParameters][[1]];
          NewP2 =Transpose[NewParameters][[2]];
          ];
        
        
        
        
        If[Length[listCouplings[[n1,1]]]\[Equal]2,
          
          SPhenoParameters = 
              Join[SPhenoParameters,{{SPhenoCoupling[listCouplings[[n1,1,1]]],
                    NewP1,NewP2,NewParametersSplit }}];,
          
          SPhenoParameters = 
            Join[SPhenoParameters,{{SPhenoCouplingLeft[
                    listCouplings[[n1,1,1]]],NewP1,NewP2,
                  NewParametersSplit }}];
          SPhenoParameters = 
            Join[SPhenoParameters,{{SPhenoCouplingRight[
                    listCouplings[[n1,1,1]]],NewP1,NewP2,
                  NewParametersSplit }}];
          ];
        
        
        
        
        For[i2=1,i2\[LessEqual]Length[parameters],
          
          If[FreeQ[listCouplings[[n1]],parameters[[i2,1]]]\[Equal]False && 
              FreeQ[UnfixedCharges,parameters[[i2,1]]]\[Equal]True,
            
            SPhenoCouplings[[coupNr,4]]=
              Join[SPhenoCouplings[[coupNr,4]],{parameters[[i2,1]]}];
            
            If[FreeQ[parameterNames,parameters[[i2,1]]]\[Equal]True && 
                FreeQ[UnfixedCharges,parameters[[i2,1]]]\[Equal]True,
              parameterNames = Join[parameterNames,{parameters[[i2,1]]}]];
            ];
          i2++;];
        coupNr++;
        
        
        n1++;];
      
      
      Return[{SPhenoCouplings,parameterNames,couplingNames}];
      
      ];



WriteSPhenoCouplings[SPhenoCouplings_, Check_]:=Block[{i,i2,InvPart},
      
      Print["   Write Routine for each Coupling"];
      
      For[i=1,i\[LessEqual]Length[SPhenoCouplings],
        
        If[Check\[Equal]True,
          If[FreeQ[SPhenoCouplingsAll,SPhenoCouplings[[i,2,1]]]\[Equal]False,
              WriteCouplings=False;,
              WriteCouplings=True;
              ];,
          WriteCouplings=True;
          ];
        
        
        If[WriteCouplings\[Equal]True,
          
          If[Length[SPhenoCouplings[[i,2]]]\[Equal]2,
            
            MakeSubroutineTitle[SPhenoCouplings[[i,2,1]], 
                Join[SPhenoCouplings[[i,3]],
                  SPhenoCouplings[[i,4]]],{},{"res"},sphenoCoup];,
            
            MakeSubroutineTitle[SPhenoCouplings[[i,2,1]], 
                Join[SPhenoCouplings[[i,3]],SPhenoCouplings[[i,4]]],{},{"resL",
                  "resR"},sphenoCoup]; 
            ];
          
          WriteString[sphenoCoup, "Implicit None \n\n"];
          
          If[Length[SPhenoCouplings[[i,3]]]>0,
            WriteString[sphenoCoup,"Integer, Intent(in) :: "];
            For[i2=1,i2\[LessEqual] Length[SPhenoCouplings[[i,3]]],
              WriteString[sphenoCoup,ToString[SPhenoCouplings[[i,3,i2]]]];
              If[i2\[NotEqual] Length[SPhenoCouplings[[i,3]]],
                WriteString[sphenoCoup,","];,
                WriteString[sphenoCoup,"\n"];
                ];
              i2++;];
            ];
          
          
          MakeVariableList[SPhenoCouplings[[i,4]],", Intent(in)",sphenoCoup];
          
          If[Length[SPhenoCouplings[[i,2]]]\[Equal]2,
            
            WriteString[sphenoCoup, 
                "Complex(dp), Intent(out) :: res \n \n"];,
            
            WriteString[sphenoCoup, 
                "Complex(dp), Intent(out) :: resL, resR \n \n"];
            ];
          WriteString[sphenoCoup,"Integer :: j1,j2,j3,j4,j5,j6 \n"];
          
          
          WriteString[sphenoCoup, "Iname = Iname +1 \n"];
          WriteString[sphenoCoup, 
            "NameOfUnit(Iname) = '"<>SPhenoCouplings[[i,2,1]] <>"' \n \n"];
          
          InvPart = Last[SPhenoCouplings[[i]]];
          
          
           For[i2 =1, i2\[LessEqual] Length[InvPart],
            gens=getGenSPheno[InvPart[[i2]]];
            If[gens>1,
              
              WriteString[sphenoCoup, 
                "If (("<>ToString[
                    generation /. subGC[i2]/. subIndFinal[i2,i2]] <>".Lt.1).Or.("<>
                  ToString[generation /. subGC[i2]/. subIndFinal[i2,i2]]<>".Gt."<>
                  ToString[gens] <>")) Then \n"];
              
              WriteString[sphenoCoup, 
                "  Write (ErrCan,*) 'Problem in Subroutine ',NameOfUnit(Iname) \n"]\
;
              
              WriteString[sphenoCoup, 
                "  Write (ErrCan,*) 'index "<> ToString[
                    generation /. subGC[i2]/. subIndFinal[i2,i2]] <>" out of range', "<> 
                  ToString[generation /. subGC[i2]/. subIndFinal[i2,i2]]<>
                  " \n"];
              WriteString[sphenoCoup, "  Call TerminateProgram \n"];
              WriteString[sphenoCoup, "End If \n\n"];
              ];
            i2++;]; 
          
          
          
          If[Length[SPhenoCouplings[[i,2]]]\[Equal]2,
            If[FreeQ[SPhenoCouplings[[i,5]],Complex]\[Equal]False, 
              valueCurrent=SPhenoCouplings[[i,5]]/\[ImaginaryI];
              complexVertex=True;,
              valueCurrent=SPhenoCouplings[[i,5]];
              complexVertex=False;
              ];
            MakeSPhenoCoupling[valueCurrent,"res",sphenoCoup];
            If[complexVertex\[Equal]False,
              WriteString[sphenoCoup,"res = (0.,1.)*res \n \n"];
              ];,
            
            If[FreeQ[SPhenoCouplings[[i,5]],Complex]\[Equal]False || 
                FreeQ[SPhenoCouplings[[i,6]],Complex]\[Equal]False, 
              valueCurrentA=SPhenoCouplings[[i,5]]/\[ImaginaryI];
              valueCurrentB=SPhenoCouplings[[i,6]]/\[ImaginaryI];
              complexVertex=True;,
              valueCurrentA=SPhenoCouplings[[i,5]];
              valueCurrentB=SPhenoCouplings[[i,6]];
              complexVertex=False;
              ];
            MakeSPhenoCoupling[valueCurrentA,"resL",sphenoCoup];
            MakeSPhenoCoupling[valueCurrentB,"resR",sphenoCoup];
            If[complexVertex\[Equal]False,
              WriteString[sphenoCoup,"resL = -(0.,1.)*resL \n \n"];
              WriteString[sphenoCoup,"resR = -(0.,1.)*resR \n \n"];
              ];
            ];
          
          WriteString[sphenoCoup,"\n\n"];
          
          WriteString[sphenoCoup, "Iname = Iname - 1 \n \n"];
          
          WriteString[sphenoCoup, 
            "End Subroutine "<>SPhenoCouplings[[i,2,1]] <>"\n \n \n"];
          
          ];
        
        i++;];
      ];



MakeSPhenoCoupling[x_,name_]:=Block[{temp,i,i2},
      temp = Expand[x];
      
      While[FreeQ[temp,sum]\[Equal]False,
        temp = temp /. sum \[Rule] sumSPheno;
        ];
      
      WriteString[sphenoCoup, name <>" = 0._dp \n"];
      
      If[Head[temp]\[Equal]Plus,
        For[i=1,i\[LessEqual]Length[temp],
            openDo=0;
            WriteSPhenoTerm[temp[[i]],name];
            For[i2=1,i2\[LessEqual]openDo,
              WriteString[sphenoCoup,"End Do \n"];
              i2++;];
            i++;];,
        openDo=0;
        WriteSPhenoTerm[temp,name];
        For[i2=1,i2\[LessEqual]openDo,
          WriteString[sphenoCoup,"End Do \n"];
          i2++;];
        ];
      
      
      ];

WriteSPhenoTerm[x_,name_]:=Block[{},
      If[Head[x]===sumSPheno,
          
          WriteString[sphenoCoup,
            "Do " <> ToString[x[[1]]] <> " = " <> ToString[x[[2]]] <>"," <>
              ToString[x[[3]]] <>"\n"];
          openDo++;
          WriteSPhenoTerm[x[[4]],name];,
          
          WriteString[sphenoCoup, 
              name<> " = "<>name <>"+"<> 
                ToString[FortranForm[ToExpression[SPhenoForm[x]]]] <>"\n"];
          ];
      ];


WriteCouplingHeader:=Block[{i},
      
      Print["Writing Module Header"];
      
      WriteString[sphenoCoup,"Module Couplings_"<>ModelName<>"\n \n"];
      WriteString[sphenoCoup, "Use Control \n"];
      WriteString[sphenoCoup, "Use Model_Data_"<>ModelName<>" \n"];
      WriteString[sphenoCoup, 
        "Use Mathematics, Only: CompareMatrices, Adjungate \n \n"];
      
      WriteString[sphenoCoup, "Contains \n \n "];
      
      ];

WriteSPhenoAllCouplings[SPhenoCouplings_,parameterNames_,couplingNames_,
      RoutineName_] :=Block[{i1,i2,i},
      
      Print["   Writing Function for all Couplings"];
      
      MakeSubroutineTitle[RoutineName, 
        Join[parameterNames,couplingNames],{},{},sphenoCoup];
      
      WriteString[sphenoCoup, "Implicit None \n"];
      
      
      MakeVariableList[parameterNames,", Intent(in)",sphenoCoup];
      MakeVariableList[couplingNames,", Intent(out)",sphenoCoup];
      WriteString[sphenoCoup, 
        "Integer :: gt1, gt2, gt3, gt4, ct1, ct2, ct3, ct4"];
      
      WriteString[sphenoCoup, "\n\n"];
      WriteString[sphenoCoup, "Iname = Iname + 1 \n"];
      WriteString[sphenoCoup, 
        "NameOfUnit(Iname) = '"<>RoutineName<>"'\n \n"];
      
      
      For[i=1,i\[LessEqual]Length[SPhenoCouplings],
        If[Length[SPhenoCouplings[[i,2]]]\[Equal]2,
          
          WriteString[sphenoCoup, 
              ToString[SPhenoCouplings[[i,2,2]]] <> " = 0._dp \n"];,
          
          WriteString[sphenoCoup, 
            ToString[SPhenoCouplings[[i,2,2]]] <> " = 0._dp \n"];
          
          WriteString[sphenoCoup, 
            ToString[SPhenoCouplings[[i,2,3]]] <> " = 0._dp \n"];
          ];
        
        OpenDoes[{getIndexRangeSPheno[SPhenoCouplings[[i,2,2]]]},sphenoCoup];
        
        cNames="";
        For[i1=2,i1\[LessEqual]Length[SPhenoCouplings[[i,2]]],
          
          cNames = 
            cNames <> ToString[SPhenoCouplings[[i,2,i1]]] <> 
              AddDimNames2[SPhenoCouplings[[i,2,i1]]]<>","; 
          i1++;];
        
        cNames = StringDrop[cNames,-1];
        
        MakeCall[SPhenoCouplings[[i,2,1]],
          Join[SPhenoCouplings[[i,3]],SPhenoCouplings[[i,4]]],{},{cNames},
          sphenoCoup];
        
        CloseDoes[sphenoCoup];
        
        WriteString[sphenoCoup,"\n\n"];
        
        i++;];
      
      
      WriteString[sphenoCoup,"Iname = Iname - 1 \n"];
      WriteString[sphenoCoup, "End Subroutine "<>RoutineName<>"\n\n"];
      
      ];





sumOverNonAbelianIndizes[coup_]:=
    Block[{i, p1, p2, ind, temp, index1, index2, index1b, index2b, p1b, p2b},
      
      posToSum={};
      posNotToSum={};
      ind={};
      
      For[i=1,i\[LessEqual]4,
        If[
          getBlank[getRotatedField[coup[[1,1,i]]]]===getBlank[coup[[1,1,i]]],
          posToSum=Join[posToSum,{i}];,
          posNotToSum=Join[posNotToSum,{i}];
          ];
        i++;];
      
      If[Length[posToSum]\[Equal]2 && Length[posNotToSum]\[Equal]2 ,
        p1=posToSum[[1]];
        p2=posToSum[[2]];
        
        p1b=posNotToSum[[1]];
        p2b=posNotToSum[[2]];
        
        ind=getIndexRange[getBlank[coup[[1,1,posToSum[[1]]]]]];
        
        temp=coup[[1,2,1]];
        
        For[i=1,i\[LessEqual]Length[ind],
          If[ind[[i,1]]=!=generation,
            index1=ind[[i,1]]/.subGC[p1]/.subIndFinal[p1,p1];
            index2=ind[[i,1]]/.subGC[p2]/.subIndFinal[p2,p2];
            index1b=ind[[i,1]]/.subGC[p1b]/.subIndFinal[p1b,p1b];
            index2b=ind[[i,1]]/.subGC[p2b]/.subIndFinal[p2b,p2b];
            
            temp = temp /. index2\[Rule]iter /. 
                    index1\[Rule]iter /. {index1b\[Rule]1, 
                    index2b\[Rule]1}  /. {index1b\[Rule]1, index2b\[Rule]1};
            temp2 = Sum[temp,{iter,1,ind[[i,2]]}];
            temp = temp2;
            ];
          i++;];,
        temp=coup[[1,2,1]];
        ];
      Return[temp];
      
      ];


WriteThetaDelta :=Block[{},
      WriteString[sphenoCoup, 
        "Real(dp) Function Kronecker(t1,t2) Result(d) \n"];
      WriteString[sphenoCoup, "Implicit None \n"];
      WriteString[sphenoCoup, "Integer,Intent(in)::t1,t2 \n"];
      WriteString[sphenoCoup, "If(t1.eq.t2) Then \n"];
      WriteString[sphenoCoup, "d=1. \n"];
      WriteString[sphenoCoup, "Else \n"];
      WriteString[sphenoCoup, "d=0. \n"];
      WriteString[sphenoCoup, "End If \n"];
      WriteString[sphenoCoup, "End Function Kronecker \n\n"];
      
      WriteString[sphenoCoup, 
        "Real(dp) Function ThetaStep(t1,t2) Result(d) \n"];
      WriteString[sphenoCoup, "Implicit None \n"];
      WriteString[sphenoCoup, "Integer,Intent(in)::t1,t2 \n"];
      WriteString[sphenoCoup, "If(t1.le.t2) Then \n"];
      WriteString[sphenoCoup, "d=1. \n"];
      WriteString[sphenoCoup, "Else \n"];
      WriteString[sphenoCoup, "d=0. \n"];
      WriteString[sphenoCoup, "End If \n"];
      WriteString[sphenoCoup, "End Function ThetaStep \n\n"];
      ];