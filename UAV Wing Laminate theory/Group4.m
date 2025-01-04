% Assignment4 by
%Sri Hari Sadish Kumar
%Srivatsan Ranganathan
%Krishna Ganesh Venkata Subramaninian
% Given: [(0)2,(90)3]s of glass fiber epoxy laminate
%From table 2.1 
E1 = 38.6E+09;
E2 = 8.27E+09;
NU12 = 0.26;
G12 = 4.14E+09;
% Now lets calculate the stiffness:
Q = ReducedStiffness(E1,E2,NU12,G12);
%lets calculate stiffness of each lamina(0,90):
Qbar0 = Qbar(Q,0);
Qbar90 = Qbar(Q,90);
% now lets calculate the extentional modulus, Coupling effect, flexural
% stiffness.
h0= -0.625E-03;
h1= -0.500E-03;
h2= -0.375E-03;
h3= -0.250E-03;
h4= -0.125E-03;
h5= 0;
h6= 0.125E-03;
h7= 0.250E-03;
h8= 0.375E-03;
h9= 0.500E-03;
h10= 0.625E-03;

Z= 0.625;

A1=Qbar0*(h1-h0);
A2=Qbar0*(h2-h1);
A3=Qbar90*(h3-h2);
A4=Qbar90*(h4-h3);
A5=Qbar90*(h5-h4);
A6=Qbar90*(h6-h5);
A7=Qbar90*(h7-h6);
A8=Qbar90*(h8-h7);
A9=Qbar0*(h9-h8);
A10=Qbar0*(h10-h9);

A= A1+A2+A3+A4+A5+A6+A7+A8+A9+A10;


B1=0.5*Qbar0*((h1^2)-(h0^2));
B2=0.5*Qbar0*((h2^2)-(h1^2));
B3=0.5*Qbar90*((h3^2)-(h2^2));
B4=0.5*Qbar90*((h4^2)-(h3^2));
B5=0.5*Qbar90*((h5^2)-(h4^2));
B6=0.5*Qbar90*((h6^2)-(h5^2));
B7=0.5*Qbar90*((h7^2)-(h6^2));
B8=0.5*Qbar90*((h8^2)-(h7^2));
B9=0.5*Qbar0*((h9^2)-(h8^2));
B10=0.5*Qbar0*((h10^2)-(h9^2));

B= B1+B2+B3+B4+B5+B6+B7+B8+B9+B10;


D1=0.33*Qbar0*((h1^3)-(h0^3));
D2=0.33*Qbar0*((h2^3)-(h1^3));
D3=0.33*Qbar90*((h3^3)-(h2^3));
D4=0.33*Qbar90*((h4^3)-(h3^3));
D5=0.33*Qbar90*((h5^3)-(h4^3));
D6=0.33*Qbar90*((h6^3)-(h5^3));
D7=0.33*Qbar90*((h7^3)-(h6^3));
D8=0.33*Qbar90*((h8^3)-(h7^3));
D9=0.33*Qbar0*((h9^3)-(h8^3));
D10=0.33*Qbar0*((h10^3)-(h9^3));

D = D1+D2+D3+D4+D5+D6+D7+D8+D9+D10;

% Lets calculate beast matrix
Astar = inv(A);
%Bstar = inv(B);
Dstar = inv(D);

ABD= [A , B ; B , D];
Beast = inv(ABD);

%Now lets apply a small load Nx= 1;
N = [1;0;0];
%We know M is 0
M = [0;0;0];
%Lets calculate midplane strains and curvatures
eplsilon0 = Astar*N;
K = Dstar*M;
%Now lets calculate the global strains
epsilonG = eplsilon0 + Z*K; % epsilonG -> Global strains

% now lets find the local stresses for each ply
%for 0 Degree ply
T0 =  T(0);
epsilonL0 = T0*epsilonG;
StressL0 = Q*epsilonL0;
%for 90 Degree ply
T90 =  T(90);
epsilonL90 = T90*epsilonG;
StressL90 = Q*epsilonL90;
%Now lets find the strenghth ratio
TstrenUlt1 = 1062E+6;
CstrenUlt1= 610E+6;
TstrenUlt2= 31E+6;
CstrenUlt2= 118E+6;
Ultshear= 72E+6;
TstressUlt2 = 31E+6;

% The strength ratio of the 0 degree ply
SR01 = TstrenUlt1/1519.73934713371;
SR02 = TstrenUlt2/58.469914290724;
SR03 = Ultshear /3.74763858033169E-16;
% The strength ratio of the 90 degree ply
SR901 =CstrenUlt1/-38.9799895271497;
SR902 = TstrenUlt2/320.173768577528;
SR903 =Ultshear/-2.17419824412097E-14;

%so now we know 0 degree ply and 90 degree plies strength ratio 90 degree
%ply has the least value of transverse tensile strength. so 90 degree fails
%first.
%now for fully discounted method lets consider the near 0 value of stifness to 90 degree ply.

Qfail = ReducedStiffness(10^-5,10^-5,NU12,10^-5);
Qbarfail90= Qbar(Qfail,90);
%now lets reaplace the failure loads insted of normal load
%now lets calculate new A B D matrix using Failure and replace 90 degree
%plies with failure lamina values

%lets calculate the A matrix with replaced stiffness matrix of 90 degree
%ply.
A1=Qbar0*(h1-h0);
A2=Qbar0*(h2-h1);
fA3=Qbarfail90*(h3-h2);
fA4=Qbarfail90*(h4-h3);
fA5=Qbarfail90*(h5-h4);
fA6=Qbarfail90*(h6-h5);
fA7=Qbarfail90*(h7-h6);
fA8=Qbarfail90*(h8-h7);
A9=Qbar0*(h9-h8);
A10=Qbar0*(h10-h9);

fA= A1+A2+fA3+fA4+fA5+fA6+fA7+fA8+A9+A10;

%lets calculate the B matrix with replaced stiffness matrix of 90 degree
%ply.
B1=0.5*Qbar0*((h1^2)-(h0^2));
B2=0.5*Qbar0*((h2^2)-(h1^2));
fB3=0.5*Qbarfail90*((h3^2)-(h2^2));
fB4=0.5*Qbarfail90*((h4^2)-(h3^2));
fB5=0.5*Qbarfail90*((h5^2)-(h4^2));
fB6=0.5*Qbarfail90*((h6^2)-(h5^2));
fB7=0.5*Qbarfail90*((h7^2)-(h6^2));
fB8=0.5*Qbarfail90*((h8^2)-(h7^2));
B9=0.5*Qbar0*((h9^2)-(h8^2));
B10=0.5*Qbar0*((h10^2)-(h9^2));

fB= B1+B2+fB3+fB4+fB5+fB6+fB7+fB8+B9+B10;

%lets calculate the D matrix with replaced stiffness matrix of 90 degree
%ply.
D1=0.33*Qbar0*((h1^3)-(h0^3));
D2=0.33*Qbar0*((h2^3)-(h1^3));
fD3=0.33*Qbarfail90*((h3^3)-(h2^3));
fD4=0.33*Qbarfail90*((h4^3)-(h3^3));
fD5=0.33*Qbarfail90*((h5^3)-(h4^3));
fD6=0.33*Qbarfail90*((h6^3)-(h5^3));
fD7=0.33*Qbarfail90*((h7^3)-(h6^3));
fD8=0.33*Qbarfail90*((h8^3)-(h7^3));
D9=0.33*Qbar0*((h9^3)-(h8^3));
D10=0.33*Qbar0*((h10^3)-(h9^3));

fD = D1+D2+fD3+fD4+fD5+fD6+fD7+fD8+D9+D10;

% Now lets calculate the beast matrix

ABD= [fA , fB ; fB , fD];
Beast = inv(ABD);

%lets calculate the Inverse of ABD
fAstar= inv(fA);
%fBstar= inv(fB);
fDstar= inv(fD);

%Now lets replace Nx = 96822.4228291005

fN= [SR902;0;0];
fM= [0;0;0];
eplsilon0f = fAstar*fN; %mid plane strains after ply failure
fK = fDstar*fM;  %midplane curvature after the ply failure
%Now lets calculate the global strains after discounting failue plies.
epsilonGf = eplsilon0f + Z*fK;

% now lets find the local stresses for each ply
%for 0 Degree ply
T0 =  T(0);
epsilonL0f = T0*epsilonGf;
StressL0f = Q*epsilonL0f;
%for 90 Degree ply
T90 =  T(90);
epsilonL90f = T90*epsilonGf;
StressL90f = Q*epsilonL90f;
fSR= TstrenUlt1/193644845.658201;% strength ratio of the 0 degree ply after faliure in 1T transverse direction
% now lets apply the final failure load 
%The global stresses and strain after failure
AEpx= 0.00501670584606738*fSR; % mutiplying the strength ratio value with global strain after failure
ASigx= SR902*fSR/((0.125E-3)*10);
%Now lets calculate the Stress and failure before the failure.
Epx= SR902*3.89776464046145E-08;
Sigx= SR902/((0.125E-3)*10);

%lets calculate the Youngs modulus before and after the ply fails
BEx= Sigx/Epx; %BEx= before failure Youngs modulus
AEx= (Sigx-ASigx)/(Epx- AEpx);
percentage = (AEx/BEx)*100;
%so the Youngs modulus after the ply failure is reduced to 71% so Youngs
%modulus is down by 29%.






















