%defining the structure
L = 0.2 - 0.01112;
heightC = 0.05; %heigth centre
heightM = 0.01; %height motor stand
delta = (heightM+heightC)/2;
k = 0.5;
nn = ceil(2*k*L/delta);
x = transpose(linspace(0,L,nn));
x = x(2:end-1);
x_t = [0;x(1:2:end);L];
nnt = length(x_t);
x_b = [0;x(2:2:end);L]; %x coordinates bottom nodes
nnb = length(x_b); %number of nodes bottom
y_t = zeros(length(x_t),1);
y_b = -heightC + (heightC-heightM).*x_b./L;
nn = nnb+nnt; % number of nodes

nodes = [x_t,y_t;x_b,y_b];

i=1;
ne = nnt+nnb-2 + nnt+nnb-1; % number of elements (trusses)
conn = zeros(ne,2); %connectivity matrix
for e=1:nnt
    %this connects top nodes to top nodes
    if (e~=nnt)
        conn(i,:) = [e,e+1];
        i=i+1;
    end

    if (e~=1)
        conn(i,:) = [e,e+nnt-1];
        i=i+1;
    end

    if ~(nnt>nnb && e==nnt)
        conn(i,:) = [e,e+nnt];
        i=i+1;
    end
end

%bottom to bottom
for e=(nnt+1):(nnt+nnb-1)
    conn(i,:) = [e,e+1];
    i=i+1;
end


% PlotStruct(nodes,conn)

E = 1.7*10^9;
YS = 36*10^6;
Strength = YS/10;
a = 0.01.*ones(ne,1); %possible input
b = 0.003.*ones(ne,1);
b_min = 0.001;
A_min = 0.005*0.001;
A = a.*b;
I = a.^3.*b./12;
F = zeros(2*nn,1);
F(2*nnt) = 5;
% F(2*nnt-1) = -1;
F(2*nn) = 5;
% F(2*nn-1) = +1;
isol = [3:2*nnt,(2*nnt+2):2*nn];
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
disp("Min buckling ratio = " + num2str(min(BuckleRatio)))
willBuckle = min(BuckleRatio)<1;
if willBuckle
    dips("Will buckle!!")
end
[nd,Stress,Strain,Force,V,L] = TrussSolve(nodes,conn,A,E,BC,F,true);
ndM = sqrt(nd(:,1).^2+nd(:,2).^2);
disp("Max nodal displacement = " +  num2str(max(ndM)*1000) + " mm")
disp("Volume = " +  num2str(V*100^3) + " cm^3")



% csvwrite('nodes.csv',nodes)
% csvwrite('connectivity.csv',conn)
% csvwrite('height.csv',a)
% csvwrite('width.csv',b)

