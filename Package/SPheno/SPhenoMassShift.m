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

GenerateSPhenoMassShift[Eigenstates_]:=Block[{i,i1,i2,index},
      Print["--------------------------------------"];
      Print["Writing SPheno Shifts for Parameters "];
      Print["--------------------------------------"];
      
      $sarahCurrentSPhenoDir=ToFileName[{$sarahCurrentOutputDir,"SPheno"}];
      (* CreateDirectory[$sarahCurrentSPhenoDir]; *)
      
      sphenoLoop=
        OpenWrite[
          ToFileName[$sarahCurrentSPhenoDir,"Shifts_"<>ModelName<>".f90"]];
      
      subSolution = {};
      
      
      SoftBreakingParameters = {};
      If[Length[Betam2ij]>0,
        SoftBreakingParameters = 
            Join[SoftBreakingParameters,Transpose[Betam2ij][[1]]];
        ];
      If[Length[BetaBij]>0,
        SoftBreakingParameters = 
            Join[SoftBreakingParameters,Transpose[BetaBij][[1]]];
        ];
      SoftBreakingParameters  = 
        SoftBreakingParameters  /. a_[i1]\[Rule]a /. a_[i1,i2]\[Rule]a;
      
      
      SuperPotentialParameters= {};
      If[Length[BetaYijk]>0,
        SuperPotentialParameters = 
            Join[SuperPotentialParameters,Transpose[BetaYijk][[1]]];
        ];
      If[Length[BetaMuij]>0,
        SuperPotentialParameters = 
            Join[SuperPotentialParameters,Transpose[BetaMuij][[1]]];
        ];
      SuperPotentialParameters  = 
        SuperPotentialParameters /. a_[i1]\[Rule]a /. a_[i1,i2]\[Rule]a;
      
      
      If[Head[HeavyFields]===List,
        WriteCalcShiftMasses;,
        WriteCalcShiftDummy;
        ];
      
      Close[sphenoLoop];
      
      
      ];


MakeShiftsFile:=Block[{i,currentRegime,readRegime},
      $sarahCurrentSPhenoDir=ToFileName[{$sarahCurrentOutputDir,"SPheno"}];
      (* CreateDirectory[$sarahCurrentSPhenoDir]; *)
      
      sphenoLoop=
        OpenWrite[
          ToFileName[$sarahCurrentSPhenoDir,"Shifts_"<>ModelName<>".f90"]];
      
      WriteHeaderShifts;
      
      currentRegime ="Regime-"<>ToString[RegimeNr]; 
      For[i=1,i<RegimeNr,
        readRegime = "Regime-"<>ToString[i];
        AppendSourceCode[
          ToFileName[
            StringReplace[$sarahCurrentSPhenoDir,{currentRegime\[Rule]
                  readRegime,
                ToString[EigenstateName]\[Rule]
                  ToString[ListOfRegimeEigenstates[[i]]]}],"Shifts.f90"],
          sphenoLoop];
        i++;];
      
      WriteString[sphenoLoop,
        "End Module ShiftParameters_"<>ModelName<>" \n"];
      Close[sphenoLoop];
      
      ];


WriteCalcShiftMasses:=Block[{i},
      
      Print["Subroutine for Shifts up and dowm"];
      
      MakeSubroutineTitle["CalcShiftDownMassesRegime"<>ToString[RegimeNr],
        listAllParametersAndVEVs,{"ThresholdScale"},{"kont"},sphenoLoop];
      
      WriteString[sphenoLoop, "Implicit None \n"];
      MakeVariableList[listAllParametersAndVEVs,",Intent(inout)",sphenoLoop];
      MakeVariableList[NewMassParameters,"",sphenoLoop];
      If[Length[NewNumericalDependences]>0,
        MakeVariableList[Transpose[NewNumericalDependences ][[1]],"",
            sphenoLoop];
        ];
      MakeVariableList[NewParametersFromTadpoles,"",sphenoLoop];
      
      
      WriteString[sphenoLoop, "Integer , Intent(inout):: kont \n"];
      WriteString[sphenoLoop, "Real(dp) , Intent(in):: ThresholdScale \n"];
      WriteString[sphenoLoop, 
        "Integer :: i1,i2,i3,i4,j1, j2, j3, j4, il, i_count, ierr \n"];
      
      
      If[Length[TEqu]>0,
        WriteString[sphenoLoop, 
            "Complex(dp) :: Tad1Loop("<>ToString[Length[TEqu]]<>") \n"];
        ];
      
      
      For[i=1,i\[LessEqual]Length[ListTree],
        If[
          FreeQ[HeavyFields,ListMassES[[i,1]]] &&  
            ListTree[[i,4]] ==ScalarMass,
          
          WriteString[sphenoLoop, 
              "Complex(dp) :: "<>ToString[ListTree[[i,1]]]<>"matrix" <>"("<>
                ToString[Dimensions[ListTree[[i,3]]][[1]]]<>","<>
                ToString[Dimensions[ListTree[[i,3]]][[1]]]<>") \n"];
          ];
        i++;];
      
       For[i=1,i\[LessEqual]Length[listNotMixedMasses],
        If[
          listNotMixedMasses[[i,4]]=!=0 && 
            FreeQ[HeavyFields,listNotMixedMasses[[i,1]]] && 
            listNotMixedMasses[[i,6]] ===ScalarMass,
          nameCurrent=listNotMixedMasses[[i,2]];
          
          WriteString[sphenoLoop, 
            "Real(dp) :: "<>ToString[nameCurrent]<>"matrix  \n"];
          ];
        i++;];
      
      
      WriteString[sphenoLoop, "Iname = Iname + 1 \n"];
      WriteString[sphenoLoop, "NameOfUnit(Iname) = 'OneLoopMasses' \n \n"];
      
      WriteString[sphenoLoop,"kont = 0 \n \n"];
      
      WriteTadpoleSolution[sphenoLoop];
      
      For[i=1,i\[LessEqual]Length[NewNumericalDependences],
        WriteString[sphenoLoop, 
          SPhenoForm[NewNumericalDependences[[i,1]]] <> " = " <> 
            SPhenoForm[NewNumericalDependences[[i,2]]] <> "\n"];
        i++;];
      
      MakeCall["TreeMassesRegime"<>ToString[RegimeNr],
        Join[NewMassParameters,Join[listVEVs,listAllParameters]],{},{"GenerationMixing",
          "kont"},sphenoLoop];
      
      WriteString[sphenoLoop," \n \n"];
      
      If[FiniteScalarShifts===True,
        
        For[i=1,i\[LessEqual]Length[ListTree],
          If[FreeQ[HeavyFields,ListMassES[[i,1]]],
            Switch[ListTree[[i,4]],
                ScalarMass,
                
                If[FreeQ[ListTree[[i,3]] /. subSolution,
                      Tad1Loop]\[Equal]True,
                  
                  MakeCall["Shift"<>ToString[ListMassES[[i,1]]],
                      Flatten[{ListTree[[i,5]],NeededMassesLoop[[i]],
                          NeededCouplingsLoop[[i]]}],{},{"0.000001_dp",
                        ToString[ListTree[[i,1]]]<>"matrix","kont"},
                      sphenoLoop];,
                  
                  MakeCall["Shift"<>ToString[ListMassES[[i,1]]],
                      Flatten[{ListTree[[i,5]],NeededMassesLoop[[i]],
                          NeededCouplingsLoop[[i]]}],{},{"Tadpole_1L","0.000001_dp",
                        ToString[ListTree[[i,1]]]<>"matrix","kont"},
                      sphenoLoop];
                  ];
                
                WriteShiftOfParameters[ListTree[[i,3]],
                  ToString[ListTree[[i,1]]]<>"matrix"];
                ];
            ];
          i++;];
        
        
         For[i=1,i\[LessEqual]Length[listNotMixedMasses],
          
          If[listNotMixedMasses[[i,4]]=!=0 && 
              FreeQ[HeavyFields,listNotMixedMasses[[i,1]]],
            nameCurrent=listNotMixedMasses[[i,2]];
            particleCurrent=ToString[listNotMixedMasses[[i,1]]];
            parametersCurrent=listNotMixedMasses[[i,3]];
            treeMassCurrent=listNotMixedMasses[[i,5]]/. subSolution;
            mixing1="None1";
            mixing2="None2";
            
            If[FreeQ[HeavyFields,listNotMixedMasses[[i,1]]],
              Switch[listNotMixedMasses[[i,6]],
                  ScalarMass,
                  
                  MakeCall["Shift"<>particleCurrent,
                    Flatten[{parametersCurrent,NeededMassesUnmixed[[i]],
                        NeededCouplingsUnmixed[[i]]}],{},{"0.000001_dp",
                      nameCurrent<>"matrix","kont"},sphenoLoop]; 
                  
                  WriteShiftOfParameters[listNotMixedMasses[[i,4]],
                    nameCurrent<>"matrix"];
                  ];
              ];
            ];
          i++;]; 
        
        ];
      
      
      For[i=1,i\[LessEqual]Length[HeavyFields],
        WriteString[sphenoLoop,
          SPhenoForm[SPhenoMass[HeavyFields[[i]]]] <> "save = "<> 
            SPhenoForm[SPhenoMass[HeavyFields[[i]]]] <>"\n "];
        i++;];
      
      WriteString[sphenoLoop,"Iname = Iname -1 \n"];
      
      WriteString[sphenoLoop,
        "End Subroutine CalcShiftDownMassesRegime"<>ToString[RegimeNr]<>
          " \n \n"];
      
      
      ];


WriteCalcShiftDummy:=Block[{i},
      
      Print["Subroutine for Shifts up and dowm"];
      
      MakeSubroutineTitle["CalcShiftDownMassesRegime"<>ToString[RegimeNr],
        listAllParametersAndVEVs,{"ThresholdScale"},{"kont"},sphenoLoop];
      
      WriteString[sphenoLoop, "Implicit None \n"];
      MakeVariableList[listAllParametersAndVEVs,",Intent(inout)",sphenoLoop];
      MakeVariableList[NewMassParameters,"",sphenoLoop];
      If[Length[NewNumericalDependences]>0,
        MakeVariableList[Transpose[NewNumericalDependences ][[1]],"",
            sphenoLoop];
        ];
      MakeVariableList[NewParametersFromTadpoles,"",sphenoLoop];
      
      
      WriteString[sphenoLoop, "Integer , Intent(inout):: kont \n"];
      WriteString[sphenoLoop, "Real(dp) , Intent(in):: ThresholdScale \n"];
      WriteString[sphenoLoop, 
        "Integer :: i1,i2,i3,i4,j1, j2, j3, j4, il, i_count, ierr \n"];
      
      
      If[Length[TEqu]>0,
        WriteString[sphenoLoop, 
            "Complex(dp) :: Tad1Loop("<>ToString[Length[TEqu]]<>") \n"];
        ];
      
      
      For[i=1,i\[LessEqual]Length[ListTree],
        If[
          FreeQ[HeavyFields,ListMassES[[i,1]]] &&  
            ListTree[[i,4]] ==ScalarMass,
          
          WriteString[sphenoLoop, 
              "Complex(dp) :: "<>ToString[ListTree[[i,1]]]<>"matrix" <>"("<>
                ToString[Dimensions[ListTree[[i,3]]][[1]]]<>","<>
                ToString[Dimensions[ListTree[[i,3]]][[1]]]<>") \n"];
          ];
        i++;];
      
       For[i=1,i\[LessEqual]Length[listNotMixedMasses],
        If[
          listNotMixedMasses[[i,4]]=!=0 && 
            FreeQ[HeavyFields,listNotMixedMasses[[i,1]]] && 
            listNotMixedMasses[[i,6]] ===ScalarMass,
          nameCurrent=listNotMixedMasses[[i,2]];
          
          WriteString[sphenoLoop, 
            "Real(dp) :: "<>ToString[nameCurrent]<>"matrix  \n"];
          ];
        i++;];
      
      
      WriteString[sphenoLoop, "Iname = Iname + 1 \n"];
      WriteString[sphenoLoop, "NameOfUnit(Iname) = 'OneLoopMasses' \n \n"];
      
      WriteString[sphenoLoop," ! Nothing to do\n \n"];
      
      WriteString[sphenoLoop,"Iname = Iname -1 \n"];
      
      WriteString[sphenoLoop,
        "End Subroutine CalcShiftDownMassesRegime"<>ToString[RegimeNr]<>
          " \n \n"];
      
      
      ];




WriteHeaderShifts:=Block[{i,dim,dim2},
      WriteString[sphenoLoop,"Module ShiftParameters_"<>ModelName<>" \n \n"];
      WriteString[sphenoLoop,"Use Control \n"];
      WriteString[sphenoLoop,"Use Couplings_"<>ModelName<>" \n"];
      WriteString[sphenoLoop,"Use LoopFunctions \n"];
      WriteString[sphenoLoop,"Use Mathematics \n"];
      WriteString[sphenoLoop,"Use MathematicsQP \n"];
      WriteString[sphenoLoop,"Use Model_Data_"<>ModelName<>" \n"];
      WriteString[sphenoLoop,"Use SusyMasses_"<>ModelName<>" \n \n"];
      
      WriteString[sphenoLoop,"Contains \n \n"];
      
      ];