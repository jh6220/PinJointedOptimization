function [I,A] = IA(a,b)

da = 4*0.1/1000;
db = 1*0.4/1000;

A = (a.*b - (a-2*da).*(b-2*db));
I = ((b.^3).*a - (b-2.*db).^3.*(a-2.*da))/12;

end