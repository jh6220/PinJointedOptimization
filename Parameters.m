load('motortest.mat')


m_w = 0.19;

m_cart = 0; % m_cart = 0.150; 
m_motor_prop = 0.101;
m_esc = 0.051;
m_arm = 0.2;
m_0 = m_cart + 2*(m_motor_prop + m_esc + m_arm);

L_wire = 1;
delta_h = 0.44; % height difference between wire ends when h = 0;

mu = 0.17;
x_cg = 0.02;
x_p = 0.015;
delta_y_cart = 0.2104;

g = 9.81;
F_fs = g*0.13;


[throttle, index]=unique(motortest{:,["Throttle"]});
thrust = g*motortest{index,["Thrustkgf"]};
% thrust = smooth(thrust);
