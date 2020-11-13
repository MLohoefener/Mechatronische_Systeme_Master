function K_f = Kf
% Calculation of K_f.m
% of Maxon motor RE 35
% 11.11.2020, M. Lohöfener, HoMe
    i_0   = 0.124;          % A
    w_0   = 7270;           % rpm
    K_m   = 0.0389;         % N.m/A
    scale = 2*pi/60;        % rpm to rad/s
    w_0   = w_0 * scale;    % rad/s
% 2nd diff. equation: torque balance
% dw(t) = i(t)*K_m/J - T(t)/J - w(t)*K_f/J  with dw(t)=0 and T(t)=0
% 0 = i_0*K_m - 0 - w_0*K_f                 in steady state
    K_f = i_0 * K_m / w_0;  % N.m.s
end