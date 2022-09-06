clc

k = 1;
[nodes, conn, nnt, in_e] = GetStruct(k);

out_e = 1:size(conn,1);
out_e = out_e(~ismember(out_e,in_e));

nodes_old = nodes;
conn_old = conn;
nnt_old = nnt;

step = 1;
n = 2000;
V_history = zeros(n,1);

for i=1:n
    [div_V,V_history(i)] = Divergence(nodes, conn, nnt,out_e,in_e);
    nodes = nodes - div_V.*step;
end

[V, Max_ndM,a,b] = StructEval2(nodes, conn, nnt,out_e, in_e ,true);

% plot(V_history);

% PlotStruct(nodes_old,conn_old,'k')
% PlotStruct(nodes,conn,'b')


disp("Min buckling ratio = " + num2str(min(BuckleRatio)))
disp("Max nodal displacement = " +  num2str(Max_ndM*1000) + " mm")
disp("Volume = " +  num2str(V*100^3) + " cm^3")

%%

csvwrite('nodes.csv',nodes)
csvwrite('connectivity.csv',conn)
csvwrite('height.csv',a)
csvwrite('width.csv',b)

