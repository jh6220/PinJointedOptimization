function [nodes] = dof_opt2nodes(dof_opt,nnt,nn)
dof = zeros(2*nn,1);
i_fix = [1,nnt+1,nn,nn+1];
i_opt = 1:(2*nn);
i_opt = i_opt(~ismember(i_opt,i_fix));
dof(i_opt) = dof_opt;
dof(i_fix) = [0;0;0.2;0];
nodes = reshape(dof,[nn,2]);
end