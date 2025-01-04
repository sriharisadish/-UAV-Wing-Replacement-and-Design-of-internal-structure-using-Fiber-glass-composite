function y = LoadN(Alpha0,Alpha60,Alpha60n,Qbar0,Qbar60,Qbar60n,h0,h1,h2,h3)
A1= Qbar0*Alpha0*(h1-h0);
A2=Qbar60*Alpha60*(h2-h1);
A3=Qbar60n*Alpha60n*(h3-h2);
 %A4=Qbar45*(h4-h3);
y = A1+A2+A3;