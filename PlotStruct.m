function [] = PlotStruct(nodes,conn,color)
    figure(1)
    hold on
    scatter(nodes(:,1),nodes(:,2))
    ne = length(conn);
    for ie = 1:ne
        plot(nodes(conn(ie,:),1),nodes(conn(ie,:),2),color)
    end
    axis equal

end