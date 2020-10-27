%% Script Maxon_feedback.m
% Use with Maxon_Control_BD.m
% Substitute of PID_RE35.mdl
% 12.11.2018, Manfred Lohöfener HoMe Merseburg

  clear, close all
  s = tf('s');
  load Maxon_Control.mat

%% Input:
% contr_param   % [Ki Kp Kd Kii]
% Sys           % ss (A3, B3, C3, D3);
% K_G           % [m] Gear with 1 m/s for nom. speed

%% Signals:
% r_set(t)  % [m] Setpoint
% y(t)      % [m] Position
% w(t)      % [rad/s] Speed, angle velocity
% i(t)      % [A] Current
% u(t)      % [V] Voltage
% F_z(t)    % [N] Force as disturbance 

%% System
  Sys = ss (A3, B3, C3, D3);
  Sys.InputName  = {'u' 'F_z'};  
  Sys.OutputName = {'y' 'w' 'i'};

%% Controller
  Contr = [Ki/s -Ki/s-Kp -Kd -Kii];
  Contr.InputName  = {'r_set' 'y' 'w' 'i'};
  Contr.OutputName = 'u';

%% Closed loop system
  Total = connect (Sys, Contr, {'r_set' 'F_z'}, {'y' 'w' 'i' 'u'});
  t_end = 1.5;            % Simulationsende
  t_x   = 0:0.001:t_end;  % Zeitachse
  figure 1
    step (Total, t_x)     % Sprungantwort
    print (gcf, [mfilename '-step' num2str(domp)], '-dsvg');
  figure 2
    ramp (Total, t_x)     % Rampen-Anstiegsantwort
    print (gcf, [mfilename '-ramp' num2str(domp)], '-dsvg');

%% Test
  disp Polstellen
  disp (pole (Total))
 