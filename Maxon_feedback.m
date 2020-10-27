%% Script Maxon_feedback.m
% Use with Maxon_Control_BD.m
% Substitute of PID_RE35.mdl
% 12.11.2018, Manfred Lohöfener HoMe Merseburg

clear
close all
s = tf('s');
load Maxon_Control.mat

% Input:
% contr_param   % [Ki Kp Kd Kii]
% Sys           % ss (A3, B3, C3, D3);
% K_G           % [m] Gear with 1 m/s for nom. speed

% Signals:
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
%step (Total, 0:0.0001:0.1)
%step (Total, 0:0.0001:0.3)
%step (Total, 0:0.0001:1)
step (Total, 0:0.001:1.5)
%step (Total, 0:0.0001:3)

print (gcf, [mfilename '-step' num2str(domp)], '-dsvg');

%if checkrel < 5
%      print (gcf, [mfilename '-step' num2str(domp)], '-depsc2');  % Octave
%      print (gcf, [mfilename '-step' num2str(domp)], '-dsvg');  % Octave
%%      print (gcf, [mfilename '-step' num2str(domp)], '-demf');    % Octave
%  else
%      print (gcf, [mfilename '-step' num2str(domp)], '-dsvg');    % MATLAB
%end
 %% Test
 disp Polstellen
 disp (pole (Total))
 