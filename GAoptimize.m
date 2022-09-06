k = 0.5;
[nodes, conn, nnt, in_e] = GetStruct2(k);

nn = size(nodes,1);
def_init = reshape(nodes,[2*nn,1]);
i_fix = [1,nnt+1,nn,nn+1];
i_opt = 1:(2*nn);
i_opt = i_opt(~ismember(i_opt,i_fix));
def_init = def_init(i_opt);

out_e = 1:size(conn,1);
out_e = out_e(~ismember(out_e,in_e));

f = @(dof_opt) FuncGA(dof_opt,nnt,nn,conn,out_e,in_e);
f(def_init)

x = ga(f,2*nn-4);

nodes = dof_opt2nodes(x,nnt,nn);

[V, Max_ndM,a,b] = StructEval3(nodes, conn, nnt,out_e, in_e ,true);
V
