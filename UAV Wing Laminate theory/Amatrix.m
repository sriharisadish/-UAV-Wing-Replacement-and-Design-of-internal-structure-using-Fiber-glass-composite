function y = Amatrix(Qbar1,Qbar2,Qbar3,h0,h1,h2,h3)
A1= Qbar1*(h1-h0);
A2=Qbar60*(h2-h1);
A3=Qbar60n*(h3-h2);
 %A4=Qbar45*(h4-h3);
y =(A1+A2+A3);