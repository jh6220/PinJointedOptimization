function [div_V,V] = Divergence2(nodes, conn, nnt,out_n,in_e)

ds = 0.0002;
div_V = zeros(size(nodes));
[V,~,~,~] = StructEval3(nodes, conn, nnt,out_n,in_e,false);

for i = 2:(size(nodes,1))
    for j = 1:size(nodes,2)
        if ~((i == nnt+1 && j==1) || (i == size(nodes,1) && j==1))
            nodes_dash = nodes;
            nodes_dash(i,j) = nodes_dash(i,j)+ds;
            [V_dash,~,~,~] = StructEval3(nodes_dash, conn, nnt,out_n,in_e,false);
            div_V(i,j) = (V_dash-V)/ds;
        end
    end
end

end