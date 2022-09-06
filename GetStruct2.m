function [nodes, conn, nnt,inside_elements] = GetStruct2(k)
%defining the structure
L_set = 1;
L = L_set - 0.01112;
L_motor = L_set;
heightC = 0.2; %heigth centre
heightM = 0.05; %height motor stand
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
nn = nnb+nnt; % number of nodes (without the motor node)

nodes = [x_t,y_t;x_b,y_b;L_motor,0];

inside_elements = [];

i=1;
ne = nnt+nnb-2 + nnt+nnb-1+2; % number of elements (trusses)
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

%motor mount node
conn(end-1,:) = [nnt,nn+1];
conn(end,:) = [nn,nn+1];

inside_elements = inside_elements(2:end);

end