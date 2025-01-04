function y = MomentM(DelT,Alpha0,Alpha60,Alpha60n,Qbar0,Qbar60,Qbar60n,h0,h1,h2,h3)
B1= Qbar0*Alpha0*((h1^2)-(h0^2))*10e-6;
B2= Qbar60*Alpha60*((h2^2)-(h1^2))*10e-6;
B3= Qbar60n*Alpha60n*((h3^2)-(h2^2))*10e-6;
%B4= 0.5*Qbar45*((h4^2)-(h3^2));
y = 0.5*DelT*(B1+B2+B3);