function [a,b,A_act] = opt_a_b_box(A_opt,I_min)

ne = size(A_opt,1);
a = 0.01;
b = zeros(ne,1);
da = 4*0.1/1000;
db = 1*0.4/1000;
b_min = 2*db;

b_stress = (A_opt + 4.*da.*db - 2.*a.*db)./(2*da);

for e = 1:ne

    b_buckling = roots([da/6,(db*(a - 2*da))/2, -db^2*(a - 2*da), (2*db^3*(a - 2*da))/3 - I_min(e)]);
    b_buckling = max(real(b_buckling));
    b(e) = max([b_stress(e),b_buckling,b_min]);
    if (imag(b(e)) ~= 0)
        disp("complex b")
    end
end

a = ones(ne,1)*0.01;
A_act = (a.*b - (a-2*da).*(b-2*db));
end