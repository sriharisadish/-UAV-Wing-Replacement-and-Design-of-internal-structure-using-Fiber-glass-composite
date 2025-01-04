function y = Bmatrix(Qbar0,Qbar60,Qbar60n,h0,h1,h2,h3)
B1= 0.5*Qbar0*((h1^2)-(h0^2));
B2= 0.5*Qbar60*((h2^2)-(h1^2));
B3= 0.5*Qbar60n*((h3^2)-(h2^2));
%B4= 0.5*Qbar45*((h4^2)-(h3^2));
y = B1+B2+B3;