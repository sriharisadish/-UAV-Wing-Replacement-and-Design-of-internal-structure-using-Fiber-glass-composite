function y = Dmatrix(Qbar0,Qbar60,Qbar60n,h0,h1,h2,h3)
D1= 0.33*Qbar0*((h1^3)-(h0^3));
D2= 0.33*Qbar60*((h2^3)-(h1^3));
D3= 0.33*Qbar60n*((h3^3)-(h2^3));
%D4= 0.33*Qbar45*((h4^3)-(h3^3));
y = D1+D2+D3;