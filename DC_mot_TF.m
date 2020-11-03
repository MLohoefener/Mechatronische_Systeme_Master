% DC_mot_ZR.m – tested with MATLAB + CST and GNU Octave + Control
% Manfred Lohöfener, HS Merseburg, 25.10.2016

% Parameters
V_nom = 30;      % V
T_nom = 0.0972;  % N.m 
K_m   = 0.0389;  % N.m/A
K_b   = 0.0388;  % V.s
K_f   = 6.33e-6; % N.m.s
R     = 1.2;     % Ohm
L     = 0.34e-3; % H
J     = 6.81e-6; % N.m.s²
T_max = 0.05;    % s

% Transfer Functions
s = tf('s');
G_ui =    1 / (R + L*s);
G_wi = -K_b / (R + L*s);
G_iw =  K_m / (K_f + J*s);
G_Tw =   -1 / (K_f + J*s);

G_uw  = minreal (G_iw*G_ui / (1 - G_iw*G_wi))
Gs_Tw = minreal  (    G_Tw / (1 - G_iw*G_wi))
Gs_ui = minreal  (    G_ui / (1 - G_iw*G_wi))
G_Ti  = minreal (G_wi*G_Tw / (1 - G_iw*G_wi))

step (G_uw*V_nom, Gs_ui*V_nom, Gs_Tw*T_nom, G_Ti*T_nom, T_max);

title ('DC Motor')
xlabel ('Time [s]')
ylabel ('w(t) [rad/s]')
legend ('w(t) V_{nom}', 'i(t) V_{nom}', 'w(t) T_{nom}', 'i(t) T_{nom}')
grid ('on')
