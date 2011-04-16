# SUSY Les Houches Accord 2.beta - MSSM spectrum + Decays
# SPheno v3beta36
# created by SARAH
# SPheno: 
# W. Porod, Comput. Phys. Commun. 153 (2003) 275-315, hep-ph/0301101
# in case of problems send email to porod@physik.uni-wuerzburg.de
# SARAH: 
# F. Staub, Comput. Phys. Commun. ??? (2010) ???, 0806.0538
# Created: 08.11.2010,  10:43
Block SPINFO         # Program information
     1   SPheno      # spectrum calculator
     2   v3beta36    # version number
Block MINPAR  # Input parameters
    1    7.00000000E+01  # m0
    2    2.50000000E+02  # m12
    3    1.00000000E+01  # TanBeta
    4    1.00000000E+00  # SignumMue
    5   -3.00000000E+02  # Azero
Block gauge Q=  2.19572794E+16  # (GUT scale)
   1    7.19926697E-01  # g1(Q)^DRbar
   1    7.19926697E-01  # g2(Q)^DRbar
   1    7.08144974E-01  # g3(Q)^DRbar
Block SMINPUTS  # SM parameters
         1     1.27932379E+02  # alpha_em^-1(MZ)^MSbar
         2     1.16639000E-05  # G_mu [GeV^-2]
         3     1.17200000E-01  # alpha_s(MZ)^MSbar
         4     9.11876000E+01  # m_Z(pole)
         5     4.21400000E+00  # m_b(m_b), MSbar
         6     1.71400000E+02  # m_t(pole)
         7     1.77700000E+00  # m_tau(pole)
Block gauge Q=  1.00000000E+03  # (SUSY scale)
   1    3.63686843E-01  # g1
   2    6.47426767E-01  # g2
   3    1.07825195E+00  # g3
Block Hmix Q=  1.00000000E+03  # (SUSY scale)
   1    3.90159424E+02  # \[Mu]
   2    1.35877552E+04  # B[\[Mu]]
   3    2.41000000E+02  # vev
Block MSOFT Q=  1.00000000E+03  # (SUSY scale)
   1    1.03615964E+02  # MassB
   2    1.93549172E+02  # MassWB
   3    5.67392442E+02  # MassG
   21   2.53731850E+04  # mHd2
   22  -1.40010763E+05  # mHu2
Block Yu Q=  1.00000000E+03  # (SUSY Scale)
  1  1     8.62106037E-06   # Real(Yu(1,1),dp)
  1  2     0.00000000E+00   # Real(Yu(1,2),dp)
  1  3     0.00000000E+00   # Real(Yu(1,3),dp)
  2  1     0.00000000E+00   # Real(Yu(2,1),dp)
  2  2     3.44842478E-03   # Real(Yu(2,2),dp)
  2  3     0.00000000E+00   # Real(Yu(2,3),dp)
  3  1     0.00000000E+00   # Real(Yu(3,1),dp)
  3  2     0.00000000E+00   # Real(Yu(3,2),dp)
  3  3     8.63025544E-01   # Real(Yu(3,3),dp)
Block Yd Q=  1.00000000E+03  # (SUSY Scale)
  1  1     1.61174091E-04   # Real(Yd(1,1),dp)
  1  2     0.00000000E+00   # Real(Yd(1,2),dp)
  1  3     0.00000000E+00   # Real(Yd(1,3),dp)
  2  1     0.00000000E+00   # Real(Yd(2,1),dp)
  2  2     2.82054703E-03   # Real(Yd(2,2),dp)
  2  3     0.00000000E+00   # Real(Yd(2,3),dp)
  3  1     0.00000000E+00   # Real(Yd(3,1),dp)
  3  2     0.00000000E+00   # Real(Yd(3,2),dp)
  3  3     1.36921964E-01   # Real(Yd(3,3),dp)
Block Ye Q=  1.00000000E+03  # (SUSY Scale)
  1  1     2.97551444E-05   # Real(Ye(1,1),dp)
  1  2     0.00000000E+00   # Real(Ye(1,2),dp)
  1  3     0.00000000E+00   # Real(Ye(1,3),dp)
  2  1     0.00000000E+00   # Real(Ye(2,1),dp)
  2  2     6.15239728E-03   # Real(Ye(2,2),dp)
  2  3     0.00000000E+00   # Real(Ye(2,3),dp)
  3  1     0.00000000E+00   # Real(Ye(3,1),dp)
  3  2     0.00000000E+00   # Real(Ye(3,2),dp)
  3  3     1.03461599E-01   # Real(Ye(3,3),dp)
Block Tu Q=  1.00000000E+03  # (SUSY Scale)
  1  1    -6.82204390E-03   # Real(TYu(1,1),dp)
  1  2     0.00000000E+00   # Real(TYu(1,2),dp)
  1  3     0.00000000E+00   # Real(TYu(1,3),dp)
  2  1     0.00000000E+00   # Real(TYu(2,1),dp)
  2  2    -2.72880262E+00   # Real(TYu(2,2),dp)
  2  3     0.00000000E+00   # Real(TYu(2,3),dp)
  3  1     0.00000000E+00   # Real(TYu(3,1),dp)
  3  2     0.00000000E+00   # Real(TYu(3,2),dp)
  3  3    -4.85344321E+02   # Real(TYu(3,3),dp)
Block Td Q=  1.00000000E+03  # (SUSY Scale)
  1  1    -1.63735181E-01   # Real(TYd(1,1),dp)
  1  2     0.00000000E+00   # Real(TYd(1,2),dp)
  1  3     0.00000000E+00   # Real(TYd(1,3),dp)
  2  1     0.00000000E+00   # Real(TYd(2,1),dp)
  2  2    -2.86535568E+00   # Real(TYd(2,2),dp)
  2  3     0.00000000E+00   # Real(TYd(2,3),dp)
  3  1     0.00000000E+00   # Real(TYd(3,1),dp)
  3  2     0.00000000E+00   # Real(TYd(3,2),dp)
  3  3    -1.28052106E+02   # Real(TYd(3,3),dp)
Block Te Q=  1.00000000E+03  # (SUSY Scale)
  1  1    -1.33340844E-02   # Real(TYe(1,1),dp)
  1  2     0.00000000E+00   # Real(TYe(1,2),dp)
  1  3     0.00000000E+00   # Real(TYe(1,3),dp)
  2  1     0.00000000E+00   # Real(TYe(2,1),dp)
  2  2    -2.75697758E+00   # Real(TYe(2,2),dp)
  2  3     0.00000000E+00   # Real(TYe(2,3),dp)
  3  1     0.00000000E+00   # Real(TYe(3,1),dp)
  3  2     0.00000000E+00   # Real(TYe(3,2),dp)
  3  3    -4.59934145E+01   # Real(TYe(3,3),dp)
Block mq2 Q=  1.00000000E+03  # (SUSY Scale)
  1  1     2.71705786E+05   # Real(mq2(1,1),dp)
  1  2     0.00000000E+00   # Real(mq2(1,2),dp)
  1  3     0.00000000E+00   # Real(mq2(1,3),dp)
  2  1     0.00000000E+00   # Real(mq2(2,1),dp)
  2  2     2.71703718E+05   # Real(mq2(2,2),dp)
  2  3     0.00000000E+00   # Real(mq2(2,3),dp)
  3  1     0.00000000E+00   # Real(mq2(3,1),dp)
  3  2     0.00000000E+00   # Real(mq2(3,2),dp)
  3  3     2.18291227E+05   # Real(mq2(3,3),dp)
Block ml2 Q=  1.00000000E+03  # (SUSY Scale)
  1  1     3.26977050E+04   # Real(ml2(1,1),dp)
  1  2     0.00000000E+00   # Real(ml2(1,2),dp)
  1  3     0.00000000E+00   # Real(ml2(1,3),dp)
  2  1     0.00000000E+00   # Real(ml2(2,1),dp)
  2  2     3.26954538E+04   # Real(ml2(2,2),dp)
  2  3     0.00000000E+00   # Real(ml2(2,3),dp)
  3  1     0.00000000E+00   # Real(ml2(3,1),dp)
  3  2     0.00000000E+00   # Real(ml2(3,2),dp)
  3  3     3.20655530E+04   # Real(ml2(3,3),dp)
Block md2 Q=  1.00000000E+03  # (SUSY Scale)
  1  1     2.50318626E+05   # Real(md2(1,1),dp)
  1  2     0.00000000E+00   # Real(md2(1,2),dp)
  1  3     0.00000000E+00   # Real(md2(1,3),dp)
  2  1     0.00000000E+00   # Real(md2(2,1),dp)
  2  2     2.50316700E+05   # Real(md2(2,2),dp)
  2  3     0.00000000E+00   # Real(md2(2,3),dp)
  3  1     0.00000000E+00   # Real(md2(3,1),dp)
  3  2     0.00000000E+00   # Real(md2(3,2),dp)
  3  3     2.46113999E+05   # Real(md2(3,3),dp)
Block mu2 Q=  1.00000000E+03  # (SUSY Scale)
  1  1     2.52535519E+05   # Real(mu2(1,1),dp)
  1  2     0.00000000E+00   # Real(mu2(1,2),dp)
  1  3     0.00000000E+00   # Real(mu2(1,3),dp)
  2  1     0.00000000E+00   # Real(mu2(2,1),dp)
  2  2     2.52533260E+05   # Real(mu2(2,2),dp)
  2  3     0.00000000E+00   # Real(mu2(2,3),dp)
  3  1     0.00000000E+00   # Real(mu2(3,1),dp)
  3  2     0.00000000E+00   # Real(mu2(3,2),dp)
  3  3     1.47240540E+05   # Real(mu2(3,3),dp)
Block me2 Q=  1.00000000E+03  # (SUSY Scale)
  1  1     1.33715717E+04   # Real(me2(1,1),dp)
  1  2     0.00000000E+00   # Real(me2(1,2),dp)
  1  3     0.00000000E+00   # Real(me2(1,3),dp)
  2  1     0.00000000E+00   # Real(me2(2,1),dp)
  2  2     1.33670093E+04   # Real(me2(2,2),dp)
  2  3     0.00000000E+00   # Real(me2(2,3),dp)
  3  1     0.00000000E+00   # Real(me2(3,1),dp)
  3  2     0.00000000E+00   # Real(me2(3,2),dp)
  3  3     1.20901069E+04   # Real(me2(3,3),dp)
Block MASS  # Mass spectrum
#   PDG code      mass          particle
   1000001     5.01288493E+02  # Sd_1
   2000001     5.40387871E+02  # Sd_2
   1000003     5.41641455E+02  # Sd_3
   2000003     5.41645943E+02  # Sd_4
   1000005     5.65068604E+02  # Sd_5
   2000005     5.65068615E+02  # Sd_6
   1000002     3.61651930E+02  # Su_1
   2000002     5.41900889E+02  # Su_2
   1000004     5.41917576E+02  # Su_3
   2000004     5.59582899E+02  # Su_4
   1000006     5.59595132E+02  # Su_5
   2000006     5.80436182E+02  # Su_6
   1000011     1.08277521E+02  # Se_1
   2000011     1.25341304E+02  # Se_2
   1000013     1.25403967E+02  # Se_3
   2000013     1.89622459E+02  # Se_4
   1000015     1.89644159E+02  # Se_5
   2000015     1.94564666E+02  # Se_6
   1000012     1.70232916E+02  # Sv_1
   1000014     1.72264699E+02  # Sv_2
   1000016     1.72271910E+02  # Sv_3
        25     1.07061046E+02  # hh_1
        35     4.18967427E+02  # hh_2
        36     4.18779314E+02  # Ah_2
        37     4.26793528E+02  # Hpm_2
        23     9.11876000E+01  # VZ
       -24     8.03207584E+01  # VWm
         1     6.00000000E-03  # Fd_1
         3     1.05000000E-01  # Fd_2
         5     4.21400000E+00  # Fd_3
         2     3.00000000E-03  # Fu_1
         4     1.20000000E+00  # Fu_2
         6     1.71400000E+02  # Fu_3
        11     5.10998910E-04  # Fe_1
        13     1.05658000E-01  # Fe_2
        15     1.77700000E+00  # Fe_3
   1000021     6.12640547E+02  # Glu
   1000022     9.79699269E+01  # Chi_1
   1000023     1.83728800E+02  # Chi_2
   1000025     3.94669482E+02  # Chi_3
   1000035     4.08678083E+02  # Chi_4
   1000024     1.83486663E+02  # Cha_1
   1000037     4.10164868E+02  # Cha_2
Block LSP  # LSP and NLSP
  1 1000022     9.79699269E+01   # LSP 
  2 1000011     1.08277521E+02   # NLSP 
Block DSQMIX # ZD mixing matrix
   1  1     0.00000000E+00   # ZD(1,1)
   1  2     0.00000000E+00   # ZD(1,2)
   1  3     9.52057756E-01   # ZD(1,3)
   1  4     0.00000000E+00   # ZD(1,4)
   1  5     0.00000000E+00   # ZD(1,5)
   1  6     3.05918338E-01   # ZD(1,6)
   2  1     0.00000000E+00   # ZD(2,1)
   2  2     0.00000000E+00   # ZD(2,2)
   2  3    -3.05918338E-01   # ZD(2,3)
   2  4     0.00000000E+00   # ZD(2,4)
   2  5     0.00000000E+00   # ZD(2,5)
   2  6     9.52057756E-01   # ZD(2,6)
   3  1     0.00000000E+00   # ZD(3,1)
   3  2    -1.01703722E-02   # ZD(3,2)
   3  3     0.00000000E+00   # ZD(3,3)
   3  4     0.00000000E+00   # ZD(3,4)
   3  5    -9.99948280E-01   # ZD(3,5)
   3  6     0.00000000E+00   # ZD(3,6)
   4  1    -5.81249649E-04   # ZD(4,1)
   4  2     0.00000000E+00   # ZD(4,2)
   4  3     0.00000000E+00   # ZD(4,3)
   4  4    -9.99999831E-01   # ZD(4,4)
   4  5     0.00000000E+00   # ZD(4,5)
   4  6     0.00000000E+00   # ZD(4,6)
   5  1    -9.99999831E-01   # ZD(5,1)
   5  2     0.00000000E+00   # ZD(5,2)
   5  3     0.00000000E+00   # ZD(5,3)
   5  4     5.81249649E-04   # ZD(5,4)
   5  5     0.00000000E+00   # ZD(5,5)
   5  6     0.00000000E+00   # ZD(5,6)
   6  1     0.00000000E+00   # ZD(6,1)
   6  2    -9.99948280E-01   # ZD(6,2)
   6  3     0.00000000E+00   # ZD(6,3)
   6  4     0.00000000E+00   # ZD(6,4)
   6  5     1.01703722E-02   # ZD(6,5)
   6  6     0.00000000E+00   # ZD(6,6)
Block USQMIX # ZU mixing matrix
   1  1     0.00000000E+00   # ZU(1,1)
   1  2     0.00000000E+00   # ZU(1,2)
   1  3    -5.61185251E-01   # ZU(1,3)
   1  4     0.00000000E+00   # ZU(1,4)
   1  5     0.00000000E+00   # ZU(1,5)
   1  6    -8.27690229E-01   # ZU(1,6)
   2  1     0.00000000E+00   # ZU(2,1)
   2  2     2.91272493E-02   # ZU(2,2)
   2  3     0.00000000E+00   # ZU(2,3)
   2  4     0.00000000E+00   # ZU(2,4)
   2  5     9.99575712E-01   # ZU(2,5)
   2  6     0.00000000E+00   # ZU(2,6)
   3  1    -7.29121863E-05   # ZU(3,1)
   3  2     0.00000000E+00   # ZU(3,2)
   3  3     0.00000000E+00   # ZU(3,3)
   3  4    -9.99999997E-01   # ZU(3,4)
   3  5     0.00000000E+00   # ZU(3,5)
   3  6     0.00000000E+00   # ZU(3,6)
   4  1    -9.99999997E-01   # ZU(4,1)
   4  2     0.00000000E+00   # ZU(4,2)
   4  3     0.00000000E+00   # ZU(4,3)
   4  4     7.29121863E-05   # ZU(4,4)
   4  5     0.00000000E+00   # ZU(4,5)
   4  6     0.00000000E+00   # ZU(4,6)
   5  1     0.00000000E+00   # ZU(5,1)
   5  2     9.99575712E-01   # ZU(5,2)
   5  3     0.00000000E+00   # ZU(5,3)
   5  4     0.00000000E+00   # ZU(5,4)
   5  5    -2.91272493E-02   # ZU(5,5)
   5  6     0.00000000E+00   # ZU(5,6)
   6  1     0.00000000E+00   # ZU(6,1)
   6  2     0.00000000E+00   # ZU(6,2)
   6  3    -8.27690229E-01   # ZU(6,3)
   6  4     0.00000000E+00   # ZU(6,4)
   6  5     0.00000000E+00   # ZU(6,5)
   6  6     5.61185251E-01   # ZU(6,6)
Block SELMIX # ZE mixing matrix
   1  1     0.00000000E+00   # ZE(1,1)
   1  2     0.00000000E+00   # ZE(1,2)
   1  3    -3.15930740E-01   # ZE(1,3)
   1  4     0.00000000E+00   # ZE(1,4)
   1  5     0.00000000E+00   # ZE(1,5)
   1  6    -9.48782255E-01   # ZE(1,6)
   2  1     1.16385463E-17   # ZE(2,1)
   2  2     2.30530089E-02   # ZE(2,2)
   2  3     0.00000000E+00   # ZE(2,3)
   2  4     1.04374295E-13   # ZE(2,4)
   2  5     9.99734244E-01   # ZE(2,5)
   2  6     0.00000000E+00   # ZE(2,6)
   3  1    -1.11595714E-04   # ZE(3,1)
   3  2     2.76882553E-15   # ZE(3,2)
   3  3     0.00000000E+00   # ZE(3,3)
   3  4    -9.99999994E-01   # ZE(3,4)
   3  5     1.04335634E-13   # ZE(3,5)
   3  6     0.00000000E+00   # ZE(3,6)
   4  1    -9.99999994E-01   # ZE(4,1)
   4  2    -1.17403215E-16   # ZE(4,2)
   4  3     0.00000000E+00   # ZE(4,3)
   4  4     1.11595714E-04   # ZE(4,4)
   4  5     2.69829023E-18   # ZE(4,5)
   4  6     0.00000000E+00   # ZE(4,6)
   5  1     1.17392337E-16   # ZE(5,1)
   5  2    -9.99734244E-01   # ZE(5,2)
   5  3     0.00000000E+00   # ZE(5,3)
   5  4    -4.73845263E-16   # ZE(5,4)
   5  5     2.30530089E-02   # ZE(5,5)
   5  6     0.00000000E+00   # ZE(5,6)
   6  1     0.00000000E+00   # ZE(6,1)
   6  2     0.00000000E+00   # ZE(6,2)
   6  3    -9.48782255E-01   # ZE(6,3)
   6  4     0.00000000E+00   # ZE(6,4)
   6  5     0.00000000E+00   # ZE(6,5)
   6  6     3.15930740E-01   # ZE(6,6)
Block scalarmix # ZH mixing matrix
   1  1    -1.09297578E-01   # ZH(1,1)
   1  2    -9.94009074E-01   # ZH(1,2)
   2  1    -9.94009074E-01   # ZH(2,1)
   2  2     1.09297578E-01   # ZH(2,2)
Block pseudoscalarmix # ZA mixing matrix
   1  1     9.94859111E-02   # ZA(1,1)
   1  2    -9.95038971E-01   # ZA(1,2)
   2  1    -9.95038971E-01   # ZA(2,1)
   2  2    -9.94859111E-02   # ZA(2,2)
Block chargemix # ZP mixing matrix
   1  1     9.94894973E-02   # ZP(1,1)
   1  2    -9.95038612E-01   # ZP(1,2)
   2  1    -9.95038612E-01   # ZP(2,1)
   2  2    -9.94894973E-02   # ZP(2,2)
Block Nmix # ZN mixing matrix
   1  1    -9.88662597E-01   # ZN(1,1)
   1  2     4.85471295E-02   # ZN(1,2)
   1  3    -1.34280969E-01   # ZN(1,3)
   1  4     4.64549910E-02   # ZN(1,4)
   2  1    -8.69904133E-02   # ZN(2,1)
   2  2    -9.55239358E-01   # ZN(2,2)
   2  3     2.48385428E-01   # ZN(2,3)
   2  4    -1.35111494E-01   # ZN(2,4)
   3  1     0.00000000E+00   # ZN(3,1)
   3  2     0.00000000E+00   # ZN(3,2)
   3  3     0.00000000E+00   # ZN(3,3)
   3  4     0.00000000E+00   # ZN(3,4)
   4  1    -1.08322606E-01   # ZN(4,1)
   4  2     2.78947068E-01   # ZN(4,2)
   4  3     6.59990553E-01   # ZN(4,3)
   4  4    -6.89106099E-01   # ZN(4,4)
Block IMNmix # ZN mixing matrix
   1  1     0.00000000E+00   # ZN(1,1)
   1  2     0.00000000E+00   # ZN(1,2)
   1  3     0.00000000E+00   # ZN(1,3)
   1  4     0.00000000E+00   # ZN(1,4)
   2  1     0.00000000E+00   # ZN(2,1)
   2  2     0.00000000E+00   # ZN(2,2)
   2  3     0.00000000E+00   # ZN(2,3)
   2  4     0.00000000E+00   # ZN(2,4)
   3  1    -5.69662142E-02   # ZN(3,1)
   3  2     8.57290949E-02   # ZN(3,2)
   3  3     6.96193774E-01   # ZN(3,3)
   3  4     7.10436206E-01   # ZN(3,4)
   4  1     0.00000000E+00   # ZN(4,1)
   4  2     0.00000000E+00   # ZN(4,2)
   4  3     0.00000000E+00   # ZN(4,3)
   4  4     0.00000000E+00   # ZN(4,4)
Block Vmix # UM mixing matrix
   1  1     9.32536432E-01   # UM(1,1)
   1  2    -3.61075897E-01   # UM(1,2)
   2  1     3.61075897E-01   # UM(2,1)
   2  2     9.32536432E-01   # UM(2,2)
Block Umix # UP mixing matrix
   1  1     9.80268172E-01   # UP(1,1)
   1  2    -1.97672231E-01   # UP(1,2)
   2  1     1.97672231E-01   # UP(2,1)
   2  2     9.80268172E-01   # UP(2,2)
Block UELMIX # ZEL mixing matrix
   1  1     1.00000000E+00   # ZEL(1,1)
   1  2     0.00000000E+00   # ZEL(1,2)
   1  3     0.00000000E+00   # ZEL(1,3)
   2  1     0.00000000E+00   # ZEL(2,1)
   2  2     1.00000000E+00   # ZEL(2,2)
   2  3     0.00000000E+00   # ZEL(2,3)
   3  1     0.00000000E+00   # ZEL(3,1)
   3  2     0.00000000E+00   # ZEL(3,2)
   3  3     1.00000000E+00   # ZEL(3,3)
Block UERMIX # ZER mixing matrix
   1  1     1.00000000E+00   # ZER(1,1)
   1  2     0.00000000E+00   # ZER(1,2)
   1  3     0.00000000E+00   # ZER(1,3)
   2  1     0.00000000E+00   # ZER(2,1)
   2  2     1.00000000E+00   # ZER(2,2)
   2  3     0.00000000E+00   # ZER(2,3)
   3  1     0.00000000E+00   # ZER(3,1)
   3  2     0.00000000E+00   # ZER(3,2)
   3  3     1.00000000E+00   # ZER(3,3)
Block UDMIXL # ZDL mixing matrix
   1  1     1.00000000E+00   # ZDL(1,1)
   1  2     0.00000000E+00   # ZDL(1,2)
   1  3     0.00000000E+00   # ZDL(1,3)
   2  1     0.00000000E+00   # ZDL(2,1)
   2  2     1.00000000E+00   # ZDL(2,2)
   2  3     0.00000000E+00   # ZDL(2,3)
   3  1     0.00000000E+00   # ZDL(3,1)
   3  2     0.00000000E+00   # ZDL(3,2)
   3  3     1.00000000E+00   # ZDL(3,3)
Block UDRMIX # ZDR mixing matrix
   1  1     1.00000000E+00   # ZDR(1,1)
   1  2     0.00000000E+00   # ZDR(1,2)
   1  3     0.00000000E+00   # ZDR(1,3)
   2  1     0.00000000E+00   # ZDR(2,1)
   2  2     1.00000000E+00   # ZDR(2,2)
   2  3     0.00000000E+00   # ZDR(2,3)
   3  1     0.00000000E+00   # ZDR(3,1)
   3  2     0.00000000E+00   # ZDR(3,2)
   3  3     1.00000000E+00   # ZDR(3,3)
Block UULMIX # ZUL mixing matrix
   1  1     1.00000000E+00   # ZUL(1,1)
   1  2     0.00000000E+00   # ZUL(1,2)
   1  3     0.00000000E+00   # ZUL(1,3)
   2  1     0.00000000E+00   # ZUL(2,1)
   2  2     1.00000000E+00   # ZUL(2,2)
   2  3     0.00000000E+00   # ZUL(2,3)
   3  1     0.00000000E+00   # ZUL(3,1)
   3  2     0.00000000E+00   # ZUL(3,2)
   3  3     1.00000000E+00   # ZUL(3,3)
Block UURMIX # ZUR mixing matrix
   1  1     1.00000000E+00   # ZUR(1,1)
   1  2     0.00000000E+00   # ZUR(1,2)
   1  3     0.00000000E+00   # ZUR(1,3)
   2  1     0.00000000E+00   # ZUR(2,1)
   2  2     1.00000000E+00   # ZUR(2,2)
   2  3     0.00000000E+00   # ZUR(2,3)
   3  1     0.00000000E+00   # ZUR(3,1)
   3  2     0.00000000E+00   # ZUR(3,2)
   3  3     1.00000000E+00   # ZUR(3,3)
Block ANGLE #
   1	    0.1000000 #
   2	    0.1000000 #

