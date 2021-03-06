%% RE_35.m
% Maxon motor RE 35 and Ziegler-Nichols PID
% 06.11.2020, M. Lohöfener, HoMe
    clear, close all
%% Maxon motor RE 35 parameters
    U_nom = 30;         % V
    R     = 1.2;        % Ohm
    L     = 0.34e-3;    % H
    K_b   = 0.0388;     % V.s EMF 
    K_m   = 0.0389;     % N.m/A
    K_f   = Kf;         % N.m.s, see Kf.m
    J     = 6.81e-6;    % N.m.s^2
    T_nom = 0.0972;     % N.m
    phi_set = 2*pi;     % rad
%% Ziegler-Nichols
    k_crit= 138;        % crit. contr. gain
    Kp = k_crit;        % V/rad
    Ki  = 0;             % 1/s    
    Td = 0;             % s
    T_crit= 7.8e-3;     % s
% Optimized by Ziegler-Nichols
    Kp = 0.6*k_crit;    % V/rad
    Ki  = 2/T_crit;      % 1/s
    Td = T_crit/8;      % s
    N  = 10e3;          % by experiment
%     N  = 100;          % default
% PID-Tuner by MATLAB/Simulink
%     Kp = 0.0117;
%     Ki = 0.0155;
%     Td = 0.5100;
%     N = 3;
% Tuning by DC-contr_ZN.m
    Kp = 165.6;         % Danger! Kp > k_crit!!!
    Ki = 1/7.8e-003;
    Td = 1.95e-003;
    N = 10000;
%% Simulation
    T_e = 0.08;         % [s] stop time
    D_t = 0.1e-3;       % [s] step size 0.1 ms
    t_x = 0:D_t:T_e;    % [s] time axis
    plot (sim('RE35.slx', t_x))         % ML 2020a
%     plot (sim('RE35_2019a.slx', t_x)) % ML 2019a
