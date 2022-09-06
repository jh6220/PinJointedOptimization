function [col] = double2color(val)

col = zeros(length(val),3);

col(:,2) = 0;
col(:,1) = val;
col(:,3) = 1-val;

end