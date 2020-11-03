% Controlled DC motor RE 35 from Maxon, DC_contr_ZN.m
% with Ziegler-Nichols
% M. Lohöfener, 21.06.2017, Merseburg

  clear, close all
  format short eng

% Parameters
  V_nom = 30;      % V
  T_nom = 0.0972;  % N.m 
  K_m   = 0.0389;  % N.m/A
  K_b   = 0.0388;  % V.s EMF 
  K_f   = 6.33e-6; % N.m.s
  R     = 1.2;     % Ohm
  L     = 0.34e-3; % H
  J     = 6.81e-6; % N.m.s²

  T_max = 0.05;     % s
  T_E = 0.08;       % [s] Simulationsdauer 80 ms
  D_t = 0.0001;     % [s] Schrittweite 0,1 ms
  t_x = 0:D_t:T_E;  % [s] Zeitachse
  tic
  Res = zeros (1001, 7);  % Vorbelegung
  
% Transfer functions
  s = tf('s');      % Laplace Op
  G_ui =    1 / (R + L*s);
  G_wi = -K_b / (R + L*s);
  G_iw =  K_m / (K_f + J*s);
  G_Tw =   -1 / (K_f + J*s);
  
  G_uw  = minreal (G_iw*G_ui / (1 - G_iw*G_wi));
  Gs_Tw = minreal  (    G_Tw / (1 - G_iw*G_wi));
  Gs_ui = minreal  (    G_ui / (1 - G_iw*G_wi));
  G_Ti  = minreal (G_wi*G_Tw / (1 - G_iw*G_wi));
  
% Tracking behaviour for angle phi(t)
  G_C = 138;          % controller gain k_crit = 138, T_crit = 7.8 ms
  G_S = G_uw/s;       % input u(t), output phi(t)
  G_track = feedback (G_C*G_S, 1);
  
  figure ('Name', 'Maxon Motor', 'NumberTitle', 'off', 'Position', [0 100 1200 480]);
    subplot (1, 2, 1)
      set (gca, 'FontSize', 15); hold on
      step (G_uw*V_nom, Gs_ui*V_nom, Gs_Tw*T_nom, G_Ti*T_nom, t_x);
      set (findobj (gcf, 'type', 'line'), 'LineWidth', 1);
      title ('Maxon Motor')
      xlabel ('Time t [s]')
      ylabel ('w(t) [rad/s]')
      legend ('w(t) V_{nom}', 'i(t) V_{nom}', 'w(t) T_{nom}', 'i(t) T_{nom}')
      legend boxoff
      line ([0, 0],get (gca, 'ylim'), 'LineWidth', 1)
      line (get (gca, 'xlim'), [0,0], 'LineWidth', 1)
      grid on
      grid minor
    subplot (1, 2, 2)
      set (gca, 'FontSize', 15); hold on
      step (G_track, t_x);
      set (findobj (gcf, 'type', 'line'), 'LineWidth', 1);
      title ('Stability Limit')
      xlabel ('Time t [s]')
      ylabel ('phi(t) [rad]')
      legend ('phi(t) with K_P=138')
      legend boxoff
      line ([0, 0],get (gca, 'ylim'), 'LineWidth', 1)
      line (get (gca, 'xlim'), [0,0], 'LineWidth', 1)
      grid on
      grid minor

% Ziegler-Nichols
  K_crit = 138;
  T_crit = 0.0078;  % [s]  
  K_P = 0.6 * K_crit;
  T_I = T_crit / 2; % [s]  
  T_D = T_crit / 8; % [s]  
  disp ('K_crit, T_crit, K_P, T_I, T_D')
  disp ([K_crit T_crit K_P T_I T_D])
  disp (' ')

  G_C = pidstd (K_P, T_I, T_D, 100);
  G_trackZN = feedback (G_C*G_S, 1); % w -> x
  [x_w, t_w] = step (G_trackZN, t_x);
  e_w = 1-x_w;                  % Regelabweichung
  L_1w = sum (abs (e_w))*D_t;   % ITAE-Kriterium L_1w
  L_2w = e_w'*e_w*D_t;          % Quadratische Regelfläche L_2w

  G_C = pidstd (K_P, T_I, T_D, 100);  % T1 wegen Nennergradproblem
  G_dist = feedback (G_S, G_C);   % z -> phi
  [x_z, t_z] = step (G_dist, t_x);
  e_z = x_z;                    % Regelabweichung
  L_1z = sum (abs (e_z))*D_t;   % ITAE-Kriterium L_1w
  L_2z = e_z'*e_z*D_t;          % Quadratische Regelfläche L_2w
  G_C = pidstd (K_P, T_I, T_D, 100); % mit T1
  G_distZN = feedback (G_S, G_C); % z -> x
  Res = [K_P T_I T_D L_1w L_2w L_1z L_2z];  % Z-N Original

% Variation of controller parameters
  for K = linspace (0.5*K_P, 2*K_P, 10) 
    for I = linspace (0.5*T_I, 2*T_I, 10)
      for D = linspace (0.5*T_D, 2*T_D, 10)
        G_C = pidstd (K, I, D, 100);

        G_track = feedback (G_C*G_S, 1);  % w -> x
        [x_w, t_w] = step (G_track, t_x);
%        plot (t_w, x_w)
        e_w = 1-x_w;                % Regelabweichung
        L_1w = sum (abs (e_w))*D_t; % ITAE-Kriterium L_1w
        L_2w = e_w'*e_w*D_t;        % Quadratische Regelfläche L_2w

        G_dist = feedback (G_S, G_C); % z -> x
        [x_z, t_z] = step (G_dist, t_x);
%        plot (t_z, x_z)
        e_z = x_z;                  % Regelabweichung
        L_1z = sum (abs (e_z))*D_t; % ITAE-Kriterium L_1w
        L_2z = e_z'*e_z*D_t;        % Quadratische Regelfläche L_2w
        Res = [Res                  % Ergebnismatrix
               K I D L_1w L_2w L_1z L_2z];
      end
    end
  end
  [M, I] = min (Res);             % Minima, Index
  Best_Results = [Res(1, :)       % Z-N Original
                  Res(I (4), :)   % L_1w Optimum
                  Res(I (5), :)   % L_2w Optimum
                  Res(I (6), :)   % L_1z Optimum
                  Res(I (7), :)]; % L_2z Optimum
  disp ('Best Results: K_P, T_I, T_D, L_1w, L_2w, L_1z, L_2z')
  disp (Best_Results)

  PID_L_1w = Res (I (4), :);      % L_1w Optimum
  G_C = pidstd (PID_L_1w(1), PID_L_1w(2), PID_L_1w(3), 100); % due to Octave
  G_trackL1 = feedback (G_C*G_S, 1); % w -> x

  PID_L_2w = Res (I (5), :);      % L_2w Optimum
  G_C = pidstd (PID_L_2w(1), PID_L_2w(2), PID_L_2w(3), 100);
  G_trackL2 = feedback (G_C*G_S, 1); % w -> x

  PID_L_1z = Res (I (6), :);      % L_1z Optimum
  G_C = pidstd (PID_L_1z(1), PID_L_1z(2), PID_L_1z(3), 100);
  G_distL1 = feedback (G_S, G_C);   % z -> x

  PID_L_2z = Res (I (7), :);      % L_2z Optimum
  G_C = pidstd (PID_L_2z(1), PID_L_2z(2), PID_L_2z(3), 100);
  G_distL2 = feedback (G_S, G_C);   % z -> x

  figure ('Name', 'PID Control', 'NumberTitle', 'off', 'Position', [100 0 1200 480]);
    subplot (1, 2, 1)
      set (gca, 'FontSize', 15); hold on
      step (G_trackZN, G_trackL1, G_trackL2, t_x); hold off
      set (findobj (gcf, 'type', 'line'), 'LineWidth', 1);
      title ('Setpoint Step – Tracking Behaviour')
      xlabel ('Time t [s]')
      ylabel ('phi(t) [rad]')
      legend ('G_{track} Ziegler-Nichols', 'G_{track} ITAE Criterion L_1', 'G_{track} Error Squares L_2')
      legend boxoff
      line ([0, 0],get (gca, 'ylim'), 'LineWidth', 1)
      line (get (gca, 'xlim'), [0,0], 'LineWidth', 1)
      grid on
      grid minor
    
    subplot (1, 2, 2)
      set (gca, 'FontSize', 15); hold on
      step (G_distZN, G_distL1, G_distL2, t_x); hold off
      set (findobj (gcf, 'type', 'line'), 'LineWidth', 1);
      title ('Disturbance Step – Control Behaviour')
      xlabel ('Time t [s]')
      ylabel ('phi(t) [rad]')
      legend ('G_{dist} Ziegler-Nichols', 'G_{dist} ITAE Criterion L_1', 'G_{dist} Error Squares L_2')
      legend boxoff
      line ([0, 0],get (gca, 'ylim'), 'LineWidth', 1)
      line (get (gca, 'xlim'), [0,0], 'LineWidth', 1)
      grid on
      grid minor
    toc
