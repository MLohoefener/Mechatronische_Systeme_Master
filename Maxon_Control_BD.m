%% Script Maxon_Control_BD.m
% Tomáš Březina, Manfred Lohöfener
% 06/11/2017, Brno, BUT, FME

clear

%% Data of Maxon Motor RE 35 ∅35 mm, Graphite Brushes, 90 Watt
% Values at nominal voltage
u_nom = 30;               % [V] Nominal voltage
w_idl_r = 7280;           % [rpm] No load speed
w_idl = w_idl_r*2*pi/60;  % [rad/s]
i_idl = 0.0941;           % [A] No load current
w_nom_r = 6470;           % [rpm] Nominal speed
w_nom = w_nom_r*2*pi/60;  % [rad/s]
T_nom = 0.101;            % [N.m] Nominal torque
i_nom = 2.68;             % [A] Nominal current
T_max = 0.976;            % [N.m] Stall torque
i_max = 25.1;             % [A] Stall current
e_max = 0.87;             % Max. efficiency

% Characteristics
R_T = 1.2;                % [Ω], [Ohm] Terminal resistance
L_T = 0.00034;            % [H] Terminal inductance
K_m = 0.0389;             % [N.m/A] Torque constant
s_c = 246;                % [rpm/V] Speed constant
K_b = 60 / (s_c*2*pi);    % [V.s] Speed constant
w_g = 7.55;               % [rpm/mN.m] Speed/torque gradient
T_m = 0.00537;            % [s] Mechanical time constant
J_R_g = 67.9;             % [g.cm²] Rotor inertia
J_R = J_R_g/10^3/100^2;   % [kg.m²], [N.m.s²] Rotor inertia
K_f = K_m*i_idl/w_idl;    % [N.m.s] Friction
K_G = 1 / w_nom;        %  [m] Gear with 1 m/s for nominal speed

%% State Space Description SS of controlled system
% Assemblage of the state 2nd order model matrices of Maxon motor

% x = (x1, x2)' = [w; i], w – speed,i - current
% u = (u, T)'   = [u; T], u - voltage, T - torque
% y = (w, i)'   = x = [w; i]

A2 = [-K_f/J_R  K_m/J_R
      -K_b/L_T  -R_T/L_T];
B2 = [0     -1/J_R
      1/L_T 0];
C2 = eye (2);
D2 = zeros (2);

% Assemblage of the state 3rd order model with usage of 2nd order model
% Maxon motor and gear

% x = (x1 | x2, x3)' = [y; w; i]
% u = (u, F)'        = [u; F], u - voltage, F - force
% y = (y | w, i)'    = x = [y; w; i]

A3 = [0 K_G  0        % Position dy = K_G * w
      [0 0]' A2];
B3 = [0     0
      0     -K_G/J_R  % Introducing the gear
      1/L_T 0];
C3 = eye (3);
D3 = zeros (3, 2);    % 3 outputs, 2 inputs

sys = ss (A3, B3, C3, D3);

%% Controller Design
domp = -150;                            % to be tuned manually
%domp = -50;                             % to be tuned manually
% domp = -15;                             % to be tuned manually
%domp = -5;                              % to be tuned manually
format short eng
  contr_param = pole_place (sys, domp); % Parameters Ki Kp Kd Kii
  disp 'Parameters'
  disp (contr_param)
format
Ki = contr_param (1);
Kp = contr_param (2);
Kd = contr_param (3);
Kii= contr_param (4);
save Maxon_Control.mat domp Ki Kp Kd Kii A3 B3 C3 D3
% Continue with Block Diagram PID_RE35.mdl / PID_RE35.slx
% or with Maxon_feedback.m
