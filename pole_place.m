function contr_param = pole_place (sys, domp)
% Tomas Brezina
% 2017, Brno, BUT, FME
% Only applicable to systems of 3rd order with cascade controller

nx_plant = order(sys);

% Has the sense to design the controller?
assert(rank(ctrb(sys.A,sys.B)) == nx_plant, 'System not controllable.');

%% Control law as state equation(s) using Symbolic Math Toolbox

syms Ki Kp Kd Kii       % controller parameters to found
syms x1 x2 x3 x4 real   % model quantities

%A_p = sys.A;            % DC motor state matrix A
%B_pu = sys.B(:,1);      % DC motor input matrix B for unloaded DC motor
A_p = sym (sys.A, 'f');            % DC motor state matrix A
B_pu = sym (sys.B(:,1), 'f');      % DC motor input matrix B for unloaded DC motor

% Symbolic DC motor state equation definition
x_p = [x1; x2; x3];       % symbolic DC motor state vector
dx_p = A_p*x_p + B_pu*x4; % symbolic model of unloaded DC motor

% Control law adds one new state x4
x = [x_p; x4];
dx4 = -(Ki*x_p(1) + Kp*dx_p(1) + Kd*dx_p(2) + Kii*dx_p(3)); % (see eq 1.6)
dx = [dx_p; dx4];
nx = nx_plant + 1;

% New matrix A creation (by eq 1.9)
A = sym(zeros(nx));
for i = 1:nx
    [c, T] = coeffs(dx(i), x);
%    if checkrel > 5 idx = ismember(x, T); % for MATLAB
    if checkrel > 5 idx = ifmember(x, T); % for MATLAB
      else idx = ifmember(x, T);  % for Octave
    end
    A(i, idx) = c;
end

%% Pole placement method application

% X - Y*Z form, (see eq 1.10), X Y are numeric matrices
X = A; X(nx,:) = zeros(1,nx); X = double(X);
Y = [zeros(nx-1,1); -1];
Z = A(nx,:);

% check 1
% assert(all(all(X - Y*Z == A)), 'Internal error#1: Wrong assemblage of matrices X, Y, Z.');

% Has the sense to design the controller using its prescribed structure?
assert(rank(ctrb(X,Y)) == nx, 'System not controllable by prescribed controller structure.');

% Finding the eigenvalues (poles) of the plant (for orientation)
% eig(sys)

% Taking them into account the design of the state-feedback system asked poles

maxp = 2*domp;                % e.g. domp = -150;
kp = (maxp/domp)^(1/(nx-1));
dp = [domp, zeros(1,nx-1)];
% nx poles generation
for ii = 1:nx-1, dp(ii+1) = kp*dp(ii); end;

% Computation of state-feedback gain vector Z_.
Zval = place(X, Y, dp);
%eq_Z  = vpa (Z - Zval); % !!!!!
eq_Z  = vpa (Z - sym(Zval, 'f')); % !!!!!
%eq_Z  = double(Z - Zval); % !!!!!

% Obtainment of the controller parameters (Ki Kp Kd Kii)
sol = solve(eq_Z,   Ki, Kp, Kd, Kii);

% check 2
%assert( ...
%    all(abs(double(subs(Z, [Ki, Kp, Kd, Kii], [sol.Ki, sol.Kp, sol.Kd, sol.Kii])) - Zval) < 1e-3), ...
%    'Internal error#2: poor accuracy of controller parameters.');

Ki = double(sol.Ki);
Kp = double(sol.Kp);
Kd = double(sol.Kd);
Kii = double(sol.Kii);
contr_param = [Ki Kp Kd Kii];
end
