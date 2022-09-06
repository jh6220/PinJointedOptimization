function [V,Max_ndM] = OptimizationFunc(k)

[nodes, conn, nnt, in_e] = GetStruct2(k);

out_e = 1:size(conn,1);
out_e = out_e(~ismember(out_e,in_e));

nodes_old = nodes;
conn_old = conn;
nnt_old = nnt;

step = 1;
n = 20000;
% V_history = zeros(n,1);
% step_hist = zeros(n,1);
% 
% figure(2)
% h = animatedline;
for i=1:n
    [div_V,V_history(i)] = Divergence2(nodes, conn, nnt,out_e,in_e);

    %Modify step size if the volume starts increasing
    if (i~=1 && V_history(i-1)<V_history(i))
        if (step<10^-6)
            break
        end
        step = step/2;
    end

    nodes = nodes - div_V.*step;
%     step_hist(i) = step;
    
%     %Draw the hisoty of the volume
%     if (mod(i,10) == 0)
%         addpoints(h,i,V_history(i));
%         axis([0 i min(V_history(1:i)) V_history(1)])
%         drawnow
%     end
end

[V, ~,a,b] = StructEval3(nodes, conn, nnt,out_e, in_e ,false);

F = zeros(2*size(nodes,1),1);
F(2*size(nodes,1)) = 10;
[Max_ndM, BuckleRatio,Stress,Force] = TrussSolve2(nodes,conn,nnt,a,b,F);

end