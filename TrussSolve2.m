function [Max_ndM, BuckleRatio,Stress,Force,L,A] = TrussSolve2(nodes,conn,nnt,a,b,F)

E = 1.7*10^9;
[I,A] = IA(a,b);
BC = [1,2,2*nnt+1]; %list of fixed dofs

[nd,Stress,Strain,Force,~,L] = TrussSolve(nodes,conn,A,E,BC,F,false);

P_crit = pi^2*E.*I./(L).^2;

P_compression = Force;
P_compression(P_compression>0) = 0;
P_compression = abs(P_compression);
P_tension = Force;
P_tension(P_tension<0) = 0;
P_tension = 0.25*abs(P_tension);
P_compression = max(P_compression,P_tension);

BuckleRatio = P_crit./P_compression; % P_crit/P

willBuckle = min(BuckleRatio)<1;
if willBuckle
    disp("Will buckle!!")
end

ndM = sqrt(nd(:,1).^2+nd(:,2).^2);
Max_ndM = max(ndM);
if (Max_ndM>0.003)
    disp("Nodal diflection over limit = " + num2str(Max_ndM))
end

end