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


ModelFile::undefinedSF="Superfield `` in Superpotential not defined.";

TeXOutput::NoRGEs ="\n RGEs not calculated so far. Skipping this parts.\n
    Use CalcRGEs[] to calculated RGEs and start MakeTeX again to include them in the output.";\


TeXOutput::NoLoops ="\n Loop corrections not calculated so far. Skipping this parts.\n
    Use CalcLoopCorrections[States] to calculated RGEs and start MakeTeX again to include them in the output.";\


ModelFile::NoVertices="\n No Vertices calculated so far!\n
    Use first ModelOutput[Eigenstates] or MakeVertexList[Eigenstates] to calculate vertices.\n
    No output produced.";

ModelFile::badvectorboson="Name for Vector-Boson `` must start with V.";

ModelFile::MissingDefParticle="No particle properties defined for eigenstates ``.";\


ModelFile::UnknownKeywordParameter ="Unknown keyword `` in parameter file.";
ModelFile::UnknownKeywordParticle ="Unknown keyword `` in particle file.";

FeynArts::NumberDefinedTwiceF \
="Particle number `` defined twice for Fermions";
FeynArts::NumberDefinedTwiceS \
="Particle number `` defined twice for Scalars";
FeynArts::NumberDefinedTwiceG ="Particle number `` defined twice for Ghosts";
FeynArts::NumberDefinedTwiceV \
="Particle number `` defined twice for Vectors";

CHName::VariableTooLong="Name of variable `` is too long. The maximal allowed length is `` ";\


PDG::DoubleCheck="PDG number `` is used twice!";

ModelFile::MissingModel="Model File does not exist!";
ModelFile::MissingParticle="Particle File does not exist!";
ModelFile::MissingParameter="Parameter File does not exist!";
ModelFile::Aborted="Evaluation aborted";

ModelFile::BadModelName = \
"A name for the model has to be defined (as string) in the model file using the variable ModelName";\


ModelFile::UnknownParticleRotations="Unknown particle `` in definitions of field rotations.";\


Parameter::FalseDimension="Dimension of `` does not fit to defined dependence";\

Parameter::NoLesHouches="No Les Houches name defined for ``";

SARAH::UnknownGaugeGroup="Gauge group `` is not known by SARAH. You can load Susyno to extend the supported gauge groups.";\

SARAH::DimensionNotUnique="Dimension `` of `` is not unique. Please provide the Dynkin labels.";\



CalcRGEs::NonOrthogonalU1="The model contains U(1) gauge groups which are not diagonal. The calculation might not be not valid in this case! See arXiv:hep-ph/9311340 section III for more information.";\


SPheno::Tadpoles = "No solution found for tadpole equations";
SPheno::noPDG="No PDG defined for `` .";

SPheno::UndefinedParticle="Particle `` is not defined. This might cause problems in the generation of the source code.";\

SPheno::UndefinedParameter="Parameter `` is not defined. This might cause problems in the generation of the source code.";\


SPheno::NoConditionForParameter="No boundary condition defined for ``. This might cause numerical problems.";\


(* SPheno::NoBoundaryGUT=
      "Boundary condition at GUT scale needed for ``. This might cause numerical problems. Note, this parameter is not evaluated from the SUSY to the GUT scale. Hence, a possible solution from the tadpoles might be unknown at the GUT scale. ";\
 *)

SPheno::NoBoundaryGUT="No boundary condition at GUT scale for ``. This might cause numerical problems. ";\




Vertices::UnknownParticle="Particle `` does not exit in model.";


ModelFile::badlengthSF ="Definition for `` does not have the needed Length";

Particle::unknown ="Unknown particle ``";

CHep::NoName="No output Name defined for ``. Automatic produced name is used.";\

CHep::NoNumber="No PDG defined for ``. Automatic produced number is used.";
CHep::NoLatex="No LaTeX name defined for ``. Automatic produced number is used.";\


CHep::ParticleNameLength="Output name of particle `` is too long for CalcHep. Just using a part of the name. That might cause problem: please check it!";\

FeynArts::NoNumber="No FeynArts number defined for ``. Automatic produced number is used.";\



Vertex::undefinedParticle=
    "Particle `` not defined";

ModelFile::NoGaugeFixingParameter=
    "Missing Gauge Fixing Parameter in ``";



Start::usage="Start[\"ModelName\"] starts the calculation for a given Model.";\

ModelOutput::usage="ModelOutput[Eigenstates,Options] produces for the given Eigenstates the specified Output. This can be a LaTeX, FeynArts or CalcHep file.";\

Vertex::usage="Vertex[List,Options] calculates for the given list of particles the interaction vertex. As options can the considered eigenstates given.";\


MassMatrices::usage="MassMatrices<>Eigenstates is list of all calculated mass matrices for given eigenstates";\
 
MassMatricesFull::usage="MassMatricesFull<>Eigenstates is list of all calculated mass matrices for given eigenstates with inserted generations indices";\
 
TadpoleEquations::usage="TadpoleEquations<>Breaking gives the tadpole equations for a broken gauge symmetry";\
 

MakeFeynArts::usage="Writes a FeynArts Model file";
MakeTeX::usage="Writes a LaTeX file"
MakeCalcHep::usage="Writes a CalcHep Model file"

NumericalValue::usage="Calculates the numerical values for a given parameter";\

ReadSpectrum::usage="Reads the spectrum from a given Les Houches file";
ExportModelInformation::usage="Write two files with all information about the particles and parameters of a given model";\



CheckModelFile:=Block[{i,j,k,l},
      
      Print["Checking Model Files ..."];
      
      ModelFileOK=True;
      
      If[Head[ModelName]=!=String,
        Message[ModelFile::BadModelName];
        ];
      
      neededLength = 3 + Length[Gauge];
      
      For[i=1,i\[LessEqual]Length[Fields],
        If[Length[Fields[[i]]]\[NotEqual] neededLength,
          Message[ModelFile::badlengthSF,Fields[[i,3]]];
          ModelFileOK=False;
          ];
        i++;];
      
      ListSF=Transpose[Fields][[3]];
      
      For[i=1,i\[LessEqual]Length[SuperPotential],
        For[j=1,j\[LessEqual]Length[SuperPotential[[i,2]]],
          If[FreeQ[ListSF,SuperPotential[[i,2,j]]]\[Equal]True,
            Message[ModelFile::undefinedSF,SuperPotential[[i,2,j]]];
            ModelFileOK=False;
            ];
          j++;];
        i++;];
      
      For[i=1,i\[LessEqual]Length[NameOfStates],
        If[FreeQ[DEFINITION[NameOfStates[[i]]][GaugeFixing],DEFINITION],
          
          For[j=1,j\[LessEqual]Length[
                  DEFINITION[NameOfStates[[i]]][GaugeFixing]],
              
              If[FreeQ[DEFINITION[NameOfStates[[i]]][GaugeFixing][[j,2]],
                    RXi]\[Equal]True,
                
                Message[ModelFile::NoGaugeFixingParameter,
                  DEFINITION[NameOfStates[[i]]][GaugeFixing][[j,2]]];
                ModelFileOK=False;
                ];
              j++;];
          ];
        i++;];
      
      
      For[i=1,i\[LessEqual]Length[NameOfStates],
        If[FreeQ[DEFINITION[NameOfStates[[i]]][GaugeSector],DEFINITION],
          
          For[j=1,j\[LessEqual]Length[
                  DEFINITION[NameOfStates[[i]]][GaugeSector]],
              
              If[StringTake[
                    ToString[
                      DEFINITION[NameOfStates[[i]]][GaugeSector][[j,1]]],1]===
                  "V",
                
                For[k=2,
                    k\[LessEqual]Length[
                        DEFINITION[NameOfStates[[i]]][GaugeSector][[j]]],
                    
                    For[l=2,
                      l\[LessEqual]Length[
                          DEFINITION[NameOfStates[[i]]][GaugeSector][[j,k]]],
                      
                      If[StringTake[
                            ToString[
                              RE[DEFINITION[NameOfStates[[i]]][
                                    GaugeSector][[j,k,l,1]]]],1]=!="V",
                        
                        Message[ModelFile::badvectorboson,
                          DEFINITION[NameOfStates[[i]]][GaugeSector][[j,k,l,
                              1]]];
                        ModelFileOK=False;
                        ];
                      l++;];
                    k++;];
                ];
              j++;];
          ];
        i++;];
      
      If[ModelFileOK\[Equal]True,
        Print["    Model File is okay"];
        ];
      
      ParticleFileOK=True;
      
      For[i=1,i\[LessEqual]Length[NameOfStates],
        If[Head[ParticleDefinitions[NameOfStates[[i]]]]===List,
          CheckParticleDefinitions[ParticleDefinitions[NameOfStates[[i]]]];,
          Message[ModelFile::MissingDefParticle,NameOfStates[[i]]];
          ParticleFileOK=False;
          ];
        i++;];
      
      If[ParticleFileOK\[Equal]True,
        Print["    Particle File is okay"];
        ];
      
      ParameterFileOK=True;
      
      
      CheckParameterDefinitions[ParameterDefinitions];
      
      If[ParameterFileOK\[Equal]True,
        Print["    Parameter File is okay"];
        ];
      
      ];



CheckParameterDefinitions[list_]:=Block[{temp,i},
      KnownEntries={Symmetry,Dependence,DependenceNum,DependenceOptional,
          Description,DependenceSPheno,Form,GUTnormalization,LaTeX,LesHouches,
          OutputName,Real,Value,MatrixProduct};
      temp=
        Intersection[
          Flatten[Transpose[list][[2]]] /. (a_ \[Rule] b_)\[Rule]a];
      temp=Complement[temp,KnownEntries];
      
      If[temp=!={},
        ParameterFileOK = False;
        For[i=1,i\[LessEqual]Length[temp],
          Message[ModelFile::UnknownKeywordParameter,temp[[i]]];
          i++;];
        ];
      ];

CheckParticleDefinitions[list_]:=Block[{temp,i},
      KnownEntries={Description,FeynArtsNr,LaTeX,Mass,OutputName,PDG,RParity,
          Width};
      temp=
        Intersection[
          Flatten[Transpose[list][[2]]] /. (a_ \[Rule] b_)\[Rule]a];
      temp=Complement[temp,KnownEntries];
      
      If[temp=!={},
        ParticleFileOK = False;
        For[i=1,i\[LessEqual]Length[temp],
          Message[ModelFile::UnknownKeywordParticle,temp[[i]]];
          i++;];
        ];
      ];