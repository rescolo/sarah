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


BeginPackage["Susyno`LieGroups`"]
EndPackage[]
BeginPackage["Susyno`SusyRGEs`"]
EndPackage[]

BeginPackage["SARAH`",{"Global`","Susyno`LieGroups`","Susyno`SusyRGEs`"}]

$sarahDir=SetDirectory[DirectoryName[System`Private`FindFile[$Input]]]

 ResetDirectory[]

$sarahPackageDir=ToFileName[{$sarahDir,"Package"}]
$sarahSPhenoPackageDir=ToFileName[{$sarahPackageDir,"SPheno"}]
$sarahModelDir=ToFileName[{$sarahDir,"Models"}]
$sarahFeynDir=ToFileName[{$sarahDir,"FeynArts"}]
$sarahRGEsDir=ToFileName[{$sarahDir,"RGEs"}]
$sarahOutputDir=ToFileName[{$sarahDir,"Output"}]
$sarahInputDir=ToFileName[{$sarahDir,"Input"}]



Off[CreateDirectory::ioerr];

Print["SARAH 3.0.beta5b"]
Print["by Florian Staub, 2010"]
Print[""]
Print["Begin evaluation of Model with:       Start[\"Name of Model\"]"];
Print["e.g. Start[\"MSSM\"] or Start[\"NMSSM\",\"CKM\"]"];


Block[{$Path={$sarahPackageDir}},
    <<variables`;
    <<mathFunctions`;
    <<mathSumMatrizes`;
    <<mathParticleProp`;
    <<init`;
    <<error`; 
    <<lagrange`; 
    <<inputLag`; 
    <<mixings`; 
    <<vertex`;
    <<output`;
    <<numerik`;
    <<more`;
    <<feynarts`;
    <<calchep`;
    <<tex`;
    <<deriveModel`;
    <<ghosts`; 
    <<loopCorrections`; 
    
    <<mathRGEs`;
    <<genericRGEs`;
    <<wilson`;
    
    Get[ToFileName[$sarahSPhenoPackageDir,"SPheno.m"]];
    <<processes`;
    <<whizard`;
    
    <<linkSusyno`; 
    
    ];

Start[model_,sub___]:=Block[{},
      
      If[SARAH`Private===True,
        $sarahModelDirInput=ToFileName[{$sarahDir,"Private-Models"}];,
        $sarahModelDirInput=ToFileName[{$sarahDir,"Models"}]
        ];
      
      
      Modelname = model;
      
      InitArrays;
      
      
      If[Head[model]=!=String,
        
        Print[""];
        Print["Name of Model must be a String!"];
        Print["Evaluation aborted"];,
        
        If[ValueQ[sub]=!=ValueQ[],
          $sarahCurrentModelDir=
            ToFileName[ToFileName[{$sarahModelDirInput,model}],sub];
          $sarahCurrentOutputMainDir=
            ToFileName[{$sarahOutputDir,model<>"-"<>sub}];
          
          ModelFile=
            ToFileName[{$sarahCurrentModelDir},model<>"-"<>sub<>".m"];
          modDir = model <>"/" <> sub;,
          $sarahCurrentModelDir=ToFileName[{$sarahModelDirInput,model}];
          $sarahCurrentOutputMainDir=ToFileName[{$sarahOutputDir,model}];
          ModelFile=ToFileName[{$sarahCurrentModelDir},model<>".m"];
          modDir = model;
          ];
        
        
        
        ParameterFile=ToFileName[{$sarahCurrentModelDir},"parameters.m"];
        ParticleFile=ToFileName[{$sarahCurrentModelDir},"particles.m"];
        
        AbortStart=False;
        
        Print[""];
        Off[FileByteCount::nffil];
        
        If[FileByteCount[ModelFile]===$Failed,
          Message[ModelFile::MissingModel];
          AbortStart=True;,
          Get[ModelFile];
          ];
        
        If[FileByteCount[ParameterFile]===$Failed,
          Message[ModelFile::MissingParticle];
          AbortStart=True;,
          Get[ParameterFile];
          ];
        
        If[FileByteCount[ParticleFile]===$Failed,
          Message[ModelFile::MissingParameter];
          AbortStart=True;,
          Get[ParticleFile];
          ];
        
        Get[ToFileName[{$sarahModelDir},"parameters.m"]];
        Get[ToFileName[{$sarahModelDir},"particles.m"]];
        
        
        If[AbortStart\[Equal]False,
          
          
          If[FileExistsQ[$sarahOutputDir]=!=True,
            CreateDirectory[$sarahOutputDir];];
          
          If[FileExistsQ[$sarahCurrentOutputMainDir]=!=True,
            CreateDirectory[$sarahCurrentOutputMainDir];];
          
          SetOptions[MakeSPheno,Eigenstates\[Rule]Last[NameOfStates]];
          
          
          InitFields;
          InitParameters;
          If[Lenght[NonSUNindices]\[Equal]0,
            CheckAnomalies;
            ];
          
          GetSuperpotential;
          CalcSuperpotential;
          
          CalcFTerms;
          CalcMatter;
          
          CalcSoftBreaking;
          CalcKinetic;
          CalcDTerms;
          CalcGaugino;
          
          GenerateSusyNoInvariants;
          
          CalcGaugeTransformations;
          CalcLagrangian;
          CalcMixedLagrangian; 
          
          Print[""];
          Print["All Done... ",model," is ready!"];,
          
          Print[""];
          Message[ModelFile::Aborted];
          
          ];
        ];
      
      ];


EndPackage[]
