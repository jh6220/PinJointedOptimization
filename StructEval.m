function [V, Max_ndM, BuckleRatio,a,b] = StructEval(nodes, conn, nnt,showPlot)
nn = size(nodes,1);
ne = size(conn,1);

% PlotStruct(nodes,conn)

E = 1.7*10^9;
YS = 36*10^6;
Strength = YS/10;
a = 0.01.*ones(ne,1); %possible input
b = 0.003.*ones(ne,1);
b_min = 0.001;
A_min = 0.005*0.001;
A = a.*b;
F = zeros(2*nn,1);
F(2*nnt) = 5;
% F(2*nnt-1) = -1;
F(2*nn) = 5;
% F(2*nn-1) = +1;
BC = [1,2,2*nnt+1]; %list of fixed dofs

[nd,Stress,Strain,Force,V,L] = TrussSolve(nodes,conn,A,E,BC,F,false);

% disp("Max nodal displacement = " +  num2str(max(ndM)*1000) + " mm")
P = abs(Force);

A = P./Strength;
A = max(A,A_min);
b = A./a;
for i = 1:length(b)
    if (b(i)<b_min)
        b(i) = b_min;
        a(i) = A(i)/b_min;
    end
end
I = a.^3.*b./12;
P_crit = pi^2*E.*I./(L).^2;

P_compression = Force;
P_compression(P_compression>0) = 0;
P_compression = abs(P_compression);
BuckleRatio = P_crit./P_compression; % P_crit/P
% disp("Min buckling ratio = " + num2str(min(BuckleRatio)))
willBuckle = min(BuckleRatio)<1;
if willBuckle
    dips("Will buckle!!")
end
[nd,Stress,Strain,Force,V,L] = TrussSolve(nodes,conn,A,E,BC,F,showPlot);
ndM = sqrt(nd(:,1).^2+nd(:,2).^2);
Max_ndM = max(ndM);
if (Max_ndM>0.003)
    Disp("Nodel diflection over limit = " + num2str(Max_ndM))
end
% disp("Max nodal displacement = " +  num2str(max(ndM)*1000) + " mm")
% disp("Volume = " +  num2str(V*100^3) + " cm^3")

end