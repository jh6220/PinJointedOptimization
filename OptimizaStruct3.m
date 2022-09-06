clc
clear

k = 0.5;
[nodes, conn, nnt, in_e] = GetStruct2(k);

out_e = 1:size(conn,1);
out_e = out_e(~ismember(out_e,in_e));

nodes_old = nodes;
conn_old = conn;
nnt_old = nnt;

step = 0.1;
n = 100000;
V_history = zeros(n,1);
step_hist = zeros(n,1);

figure(2)
h = animatedline;
for i=1:n
    [div_V,V_history(i)] = Divergence3(nodes, conn, nnt,out_e,in_e);

    %Modify step size if the volume starts increasing
    if (i~=1 && V_history(i-1)<V_history(i))
        if (step<10^-3)
            break
        end
        step = step/2;
    end

    nodes = nodes - div_V.*step;
    step_hist(i) = step;
    
    %Draw the hisoty of the volume
    if (mod(i,10) == 0)
        addpoints(h,i,V_history(i));
        axis([0 i min(V_history(1:i)) min(V_history(1:2))])
        drawnow
    end
end

[V, Max_ndM,a,b] = StructEval4(nodes, conn, nnt,out_e, in_e ,true);


% plot(V_history);

% PlotStruct(nodes_old,conn_old,'k')
% PlotStruct(nodes,conn,'b')

F = zeros(2*size(nodes,1),1);
F(2*size(nodes,1)) = 10;
[~, BuckleRatio,~,Force,L] = TrussSolve2(nodes,conn,nnt,a,b,F);


[I,A] = IA(a,b);
V = sum(A.*L);

disp("Min buckling ratio = " + num2str(min(BuckleRatio)))
disp("Max nodal displacement = " +  num2str(Max_ndM*1000) + " mm")
disp("Volume = " +  num2str(V*100^3) + " cm^3")



%%

csvwrite('nodes3.csv',nodes)
csvwrite('connectivity3.csv',conn)
csvwrite('height3.csv',a)
csvwrite('width3.csv',b)

%%
nodes = readtable('nodes3.csv');
conn = readtable('connectivity3.csv');
a = readtable('height3.csv');
b = readtable('width3.csv');

nodes = table2array(nodes);
conn = table2array(conn);
a = table2array(a);
b = table2array(b);