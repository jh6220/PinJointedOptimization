function [a,b] = opt_a_b(A_opt,I_min,out_e, in_e)

ne = size(A_opt,1);
a = zeros(ne,1);
b = zeros(ne,1);
b_min = 0.001;

%Loop over inner elements
for e = in_e
    if (A_opt(e).^2/12 > I_min(e))
        %the b is defined to satisfy the I_min
        b_buckling = (12*I_min(e)/A_opt(e))^0.5;
        b(e) = max(b_min,b_buckling);
        a(e) = A_opt(e)/b(e);
    else
        %case if to satisfy I_min area needs to be increased
        b(e) = (12*I_min(e))^0.25;
        a(e) = b(e);
    end
    if (a(e)==0)
        disp("a: " + num2str(e))
    end
    if (b(e)==0)
        disp("b: " + num2str(e))
    end
end

%Loop over outer elements
for e = out_e
    a(e) = 0.01;
    b_stress = A_opt(e)./a(e);
    b_buckling = (12*I_min(e)/a(e))^(1/3);
    b(e) = max([b_stress,b_buckling,b_min]);
    if (a(e)==0)
        disp("a: " + num2str(e))
    end
    if (b(e)==0)
        disp("b: " + num2str(e))
    end
end

end