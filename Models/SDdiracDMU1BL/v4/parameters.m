ParameterDefinitions = { 

{g1,        { Description -> "Hypercharge-Coupling"}},

(* NEW *)
{g11p,        {Description -> "Mixed Gauge Coupling 2"}},
{g1p1,        {Description -> "Mixed Gauge Coupling 1"}},
{g1p,       {   Description -> "B-L-Coupling"}},

{MZp,       {   Description -> "Z' mass"}},

{g2,        { Description -> "Left-Coupling"}},
{g3,        { Description -> "Strong-Coupling"}},    
{AlphaS,    {Description -> "Alpha Strong"}},	
{e,         { Description -> "electric charge"}}, 

{Gf,        { Description -> "Fermi's constant"}},
{aEWinv,    { Description -> "inverse weak coupling constant at mZ"}},

{Yu,        { Description -> "Up-Yukawa-Coupling",
			 DependenceNum ->  Sqrt[2]/v* {{Mass[Fu,1],0,0},
             									{0, Mass[Fu,2],0},
             									{0, 0, Mass[Fu,3]}}}}, 
             									
{Yd,        { Description -> "Down-Yukawa-Coupling",
			  DependenceNum ->  Sqrt[2]/v* {{Mass[Fd,1],0,0},
             									{0, Mass[Fd,2],0},
             									{0, 0, Mass[Fd,3]}}}},
             									
{Ye,        { Description -> "Lepton-Yukawa-Coupling",
			  DependenceNum ->  Sqrt[2]/v* {{Mass[Fe,1],0,0},
             									{0, Mass[Fe,2],0},
             									{0, 0, Mass[Fe,3]}}}}, 
                                                                                                                                                                                                                                               
{mu2,         { Description -> "SM Mu Parameter",
                OutputName->m2SM,
                Real -> True }},  
                
{Lambda1,  { Description -> "SM Higgs Selfcouplings",
               DependenceNum -> Mass[hh]^2/(v^2)}},
               
{v,          { Description -> "EW-VEV",
               DependenceNum -> Sqrt[4*Mass[VWp]^2/(g2^2)],
               DependenceSPheno -> None,
               OutputName -> vvSM}},

{ThetaW,    { Description -> "Weinberg-Angle",
              DependenceNum -> ArcSin[Sqrt[1 - Mass[VWp]^2/Mass[VZ]^2]]  }},
(* NEW *)
{ThetaWp,  { Description -> "Theta'", DependenceNum -> None  }},

{ZZ, {Description ->   "Photon-Z-Z' Mixing Matrix"}},

{ZW, {Description -> "W Mixing Matrix",
       Dependence ->   1/Sqrt[2] {{1, 1},
                  {\[ImaginaryI],-\[ImaginaryI]}} }},


{Vu,        {Description ->"Left-Up-Mixing-Matrix"}},
{Vd,        {Description ->"Left-Down-Mixing-Matrix"}},
{Uu,        {Description ->"Right-Up-Mixing-Matrix"}},
{Ud,        {Description ->"Right-Down-Mixing-Matrix"}}, 
{Ve,        {Description ->"Left-Lepton-Mixing-Matrix"}},
{Ue,        {Description ->"Right-Lepton-Mixing-Matrix"}},


(*New parameters*)

{Vv, {Description ->"Neutrino-Mixing-Matrix"}},

{Vvr, {Description ->"right-Neutrino-Mixing-Matrix",
             LaTeX -> "U^{UR}",
             Dependence ->  None, 
             Value -> None, 
             LesHouches -> UVRMIX,
             OutputName-> UVR }},

{XV,        {(*Description ->"x-Left--Mixing-Matrix",*)
             LesHouches -> XV,
             OutputName -> XV }},
             
{XU,        {(*Description ->"x-Right-Lepton-Mixing-Matrix",*)
             LesHouches -> XU,
             OutputName -> XU }},
              
{YRA,       { LaTeX -> "h_a",   
              Real -> True, 
              LesHouches -> YRA,
              OutputName-> YRA }},  
 
              
{YRB,       { LaTeX -> "h_b",   
              Real -> True, 
              LesHouches -> YRB,
              OutputName-> YRB }},      

{YRC,       { LaTeX -> "h_c",   
              Real -> True, 
              LesHouches -> YRC,
              OutputName-> YRC }}, 
     
{YRD,       { LaTeX -> "h_d", 
              Real -> True, 
              LesHouches -> YRD,
              OutputName-> YRD }},               

{MDF,       { LaTeX -> "M_{\\Psi}",
              Real -> True, 
              LesHouches -> MDF,
              OutputName -> MDF }},
              
{MSi2,       { LaTeX -> "msi^{2}",
              Real -> True, 
              (*DependenceNum -> Sqrt[Mass[Ss[1]]^2-v^2*LamS1H]*)
              LesHouches -> MSi2,
              OutputName-> MSi2 }} ,
              
{LamSiH,     { LaTeX -> "\\lambda^{SiH}",
              Real -> True, 
              LesHouches -> LSiH,
              OutputName -> "LSiH" }},

{LI,      { LaTeX -> "\\lambda^{Si}",
              Real -> True, 
              LesHouches -> LI,
              OutputName -> "LI" }},  
              
{LamSH,     { LaTeX -> "\\lambda^{SH}",
              Real -> True, 
              LesHouches -> LSH,
              OutputName -> "LSH" }},                          

{mS2,       { (*Description -> "mS2-parameter",*)
              LaTeX -> "m_{S}^{2}",
              Real -> True, 
              LesHouches -> mS2,
              OutputName-> mS2 }},              
              
{LamS,      { LaTeX -> "\\lambda^{S}",
              Real -> True, 
              (*DependenceNum -> Mass[phiS]^2/(4*vS^2),*)
              LesHouches -> LS,
              OutputName -> "LS" }},      
              
{vS,{ 
     Dependence -> None, 
     DependenceNum -> None, 
     DependenceOptional -> None, 
     DependenceSPheno -> None, 
     Real -> True, 
     LesHouches -> vS, 
     LaTeX -> "v_{\\sigma}", 
     OutputName -> vS}},
        
{ZH,     { Description -> "Scalar-Mixing-Matrix"}},
{\[Alpha],  { Description -> "Scalar mixing angle" }},

{YNU,       { LaTeX -> "y_v",   
              Real -> True, 
              LesHouches -> YNU,
              OutputName-> YNU }},

{VSs,       {   (* Rotation matrix *)
                LaTeX -> "VS",
                Real -> True,                 
                LesHouches ->  VSs,
                OutputName-> VSs }},
                
{ZA,        { Description->"Pseudo-Scalar-Mixing-Matrix", 
                Dependence -> None,
               DependenceOptional -> None,
               DependenceNum -> None   }}
                

 }; 
 

