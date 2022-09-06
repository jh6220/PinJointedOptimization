function [V] = FuncGA(dof_opt,nnt,nn,conn,out_e,in_e)
dof = zeros(2*nn,1);
i_fix = [1,nnt+1,nn,nn+1];
i_opt = 1:(2*nn);
i_opt = i_opt(~ismember(i_opt,i_fix));
dof(i_opt) = dof_opt;
dof(i_fix) = [0;0;0.2;0];
nodes = reshape(dof,[nn,2]);
[V, Max_ndM,~,~] = StructEval3(nodes, conn, nnt,out_e, in_e ,false);
end