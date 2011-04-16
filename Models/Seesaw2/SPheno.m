MINPAR={m0,m12,TanBeta,SignumMu,Azero};
EXTPAR={{200,Lambda1IN},
        {201,Lambda2IN},
        {210,MTScaleIN}};

RealParameters = {TanBeta};
ParametersToSolveTadpoles = {\[Mu],B[\[Mu]]};

RenormalizationScaleFirstGuess = m0^2 + 4 m12^2;
RenormalizationScale = MSu[1]*MSu[6];

RenameParameters ={
{MZ,MZM},
{MT,MTM},
{MS,MSM},
{mz2,mzSS2}
};


BoundaryHighScale={
{T[Ye], Azero*Ye},
{T[Yd], Azero*Yd},
{T[Yu], Azero*Yu},
{mq2, DIAGONAL m0^2},
{ml2, DIAGONAL m0^2},
{md2, DIAGONAL m0^2},
{mu2, DIAGONAL m0^2},
{me2, DIAGONAL m0^2},
{mHd2, m0^2},
{mHu2, m0^2},
{mt2,m0^2},
{mtb2,m0^2},
{ms2,m0^2},
{msb2,m0^2},
{mz2,m0^2},
{mzb2,m0^2},
{MassB, m12},
{MassWB,m12},
{MassG,m12},
{MT, MTScaleIN},
{MZ,MT},
{MS,MT},
{B[MZ],MT},
{B[MS],MT},
{B[MT],MT},
{Ys,Yt},
{Yz,Yt},
{T[Yt],Azero*Yt},
{T[Ys],Azero*Yt},
{T[Yz],Azero*Yt},
{T[L1], Azero*L1},
{T[L2], Azero*L2},
{\[Mu],0},
{B[\[Mu]],0}
};


Thresholds={
{Abs[MTScaleIN],{s,sb,t,tb,z,zb}}
};


ListDecayParticles = Automatic;
ListDecayParticles3B = Automatic;


(* Boundary conditions at threshold scale: 
input values of seesaw parameters defined at MT *)

BoundaryConditionsUp=Table[{},{Length[Thresholds]}];
BoundaryConditionsDown=Table[{},{Length[Thresholds]}];

BoundaryConditionsUp[[1]] = {
{Yt, LHInput[Yt]},
{L1, Lambda1IN},
{L2, Lambda2IN}
}; 

BoundaryConditionsDown[[1]] = {
{MNuL, -L2 Yt/MT }
}; 


(* not yet included in public version *)

AddLowEnergyConstraint=False;
