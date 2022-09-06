function [V, Max_ndM,a,b] = StructEval3(nodes, conn, nnt,out_e, in_e ,showPlot)
nn = size(nodes,1);
ne = size(conn,1);

sf_stress = 5; % safety factor for stress
sf_buckling = 4; %safety factor for buckling

E = 1.7*10^9;
YS = 36*10^6;
Strength = YS/sf_stress;
a = 0.01.*ones(ne,1); %possible input
b = 0.003.*ones(ne,1);
b_min = 0.001;
A_min = 0.001*0.005;
A = a.*b;
F = zeros(2*nn,1);
F(2*nn) = 10;
BC = [1,2,2*nnt+1]; %list of fixed dofs

[nd,Stress,Strain,Force,V,L] = TrussSolve(nodes,conn,A,E,BC,F,false);

P_compression = Force;
P_compression(P_compression>0) = 0;
P_compression = abs(P_compression);

P = abs(Force);
A_opt = P./Strength;
A_opt = max(A_opt,A_min);
I_min = sf_buckling.*P_compression.*(L.^2)/(E*(pi^2));


[a,b] = opt_a_b(A_opt,I_min,out_e, in_e);

A = a.*b;

I = a.*b.^3./12;

[nd,Stress,Strain,Force,V,L] = TrussSolve(nodes,conn,A,E,BC,F,showPlot);
ndM = sqrt(nd(:,1).^2+nd(:,2).^2);
Max_ndM = max(ndM);
if (Max_ndM>0.003)
    disp("Nodel diflection over limit = " + num2str(Max_ndM))
end

V = V + 10^-5*exp(1000*(Max_ndM-0.003));

end