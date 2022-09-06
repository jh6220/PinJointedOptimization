clc
n=10;
k_arr = linspace(0.3,1.5,n);

V_history = zeros(n,1);
Max_ndM_history = zeros(n,1);

for i = 1:n
    disp("index: " + num2str(i) + "/" + num2str(n) + "; k = " + num2str(k_arr(i)))
    [V_history(i),Max_ndM_history(i)] = OptimizationFunc(k_arr(i));
    disp("V = " + num2str(V_history(i)) + "; Max_ndM = " + num2str(Max_ndM_history(i)))
end