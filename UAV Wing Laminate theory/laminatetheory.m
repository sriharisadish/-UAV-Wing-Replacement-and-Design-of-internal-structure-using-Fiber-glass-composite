function y = laminatetheory(E1,E2,NU12,G12,theta1,theta2,theta3,h0,h1,h2,h3,h4,h5,h6)
NU21 = NU12*E2/E1;
%Q matrix Calculation
Q = [E1 / (1 - NU12 * NU21), NU12 * E2 / (1 - NU12 * NU21), 0; NU12 * E2 / (1 - NU12 * NU21), E2 / (1 - NU12 * NU21), 0; 0, 0, G12];
display('Q=',Q);
%Qbar for theta1 value
m1 = cos(theta1*pi/180);
n1 = sin(theta1*pi/180);
T1 = [m1*m1 n1*n1 2*m1*n1 ; n1*n1 m1*m1 -2*m1*n1 ; -m1*n1 m1*n1 m1*m1-n1*n1];
Tinv1 = [m1*m1 n1*n1 -2*m1*n1 ; n1*n1 m1*m1 2*m1*n1 ; m1*n1 -m1*n1 m1*m1-n1*n1];
R=[1 0 0; 0 1 0; 0 0 2];
Qbar1 = Tinv1*Q*R*T1*inv(R);
display('Qbar',theta1,'=',Qbar1);
%Qbar for theta2 value
m2 = cos(theta2*pi/180);
n2 = sin(theta2*pi/180);
T2 = [m2*m2 n2*n2 2*m2*n2 ; n2*n2  m2*m2  -2*m2*n2 ; -m2*n2 m2*n2 m2*m2-n2*n2];
Tinv2 = [m2*m2 n2*n2 -2*m2*n2 ; n2*n2 m2*m2 2*m2*n2 ; m2*n2 -m2*n2 m2*m2-n2*n2];
R=[1 0 0; 0 1 0; 0 0 2];
Qbar2 = Tinv2*Q*R*T2*inv(R);
display('Qbar',theta2,'=',Qbar2);
%Qbar for theta3 value
m3 = cos(theta3*pi/180);
n3 = sin(theta3*pi/180);
T3 = [m3*m3 n3*n3 2*m3*n3 ; n3*n3  m3*m3  -2*m3*n3 ; -m3*n3 m3*n3 m3*m3-n3*n3];
Tinv3 = [m3*m3 n3*n3 -2*m3*n3 ; n3*n3 m3*m3 2*m3*n3 ; m3*n3 -m3*n3 m3*m3-n3*n3];
R=[1 0 0; 0 1 0; 0 0 2];
Qbar3 = Tinv3*Q*R*T3*inv(R);
display('Qbar',theta3,'=',Qbar3);
%Now calculate Amatrix for this 3S Laminate
A1= Qbar1*(h1-h0);
A2=Qbar2*(h2-h1);
A3=Qbar3*(h3-h2);
A4=Qbar3*(h4-h3);
A5=Qbar2*(h5-h4);
A6=Qbar1*(h6-h5); 
A =(A1+A2+A3+A4+A5+A6);
display('Amatrix:',A);
%Now lets calculate D matrix:
D1= 0.33*Qbar1*((h1^3)-(h0^3));
D2= 0.33*Qbar2*((h2^3)-(h1^3));
D3= 0.33*Qbar3*((h3^3)-(h2^3));
D4= 0.33*Qbar3*((h4^3)-(h3^3));
D5= 0.33*Qbar2*((h5^3)-(h4^3));
D6= 0.33*Qbar1*((h6^3)-(h5^3));
D = D1+D2+D3+D4+D5+D6;
display('Dmtrix:',D);
%now lets calculate the beast matrix:
B= [0 0 0 ; 0 0 0 ; 0 0 0]; %As the laminate is symmetric it has 0 coupling effect.
ABD= [ A ; B ; B ; D];
ABD= inv(ABD);
display('the beast matrix:',ABD);


