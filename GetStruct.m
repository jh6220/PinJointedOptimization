function [nodes, conn, nnt,inside_elements] = GetStruct(k)
%defining the structure
L = 0.2 - 0.01112;
heightC = 0.05; %heigth centre
heightM = 0.01; %height motor stand
delta = (heightM+heightC)/2;
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

inside_elements = [];

i=1;
ne = nnt+nnb-2 + nnt+nnb-1; % number of elements (trusses)
conn = zeros(ne,2); %connectivity matrix
for e=1:nnt
    %this connects top nodes to top nodes
    if (e~=nnt)
        conn(i,:) = [e,e+1];
        i=i+1;
    end
    %this connects top with bottom closer to the centre
    if (e~=1)
        conn(i,:) = [e,e+nnt-1];
        inside_elements(end+1) = i;
        i=i+1;
    end
    %connects top with bottom further to the centre
    if ~(nnt>nnb && e==nnt)
        conn(i,:) = [e,e+nnt];
        inside_elements(end+1) = i;
        i=i+1;
    end

end

%bottom to bottom
for e=(nnt+1):(nnt+nnb-1)
    conn(i,:) = [e,e+1];
    i=i+1;
end

inside_elements = inside_elements(2:end-1);

end