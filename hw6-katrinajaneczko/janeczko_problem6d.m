function janeczko_problem6d
%TEMPLE_ABM_TRAFFIC_CAR_FOLLOWING
%   Model for vehicles driving on a single-lane road.
%   Each vehicle is following its immediate leader, and
%   accelerated and decelerates based on the headway, its
%   own velocity, and its leader's velocity. The vehicles
%   drive on a circular road. In this model, each vehicle
%   has two objectives: a) equilibrating its own velocity
%   to its leader's velocity; and b) having its own
%   velocity approach an optimal velocity, which is based
%   on its headway. Runge-Kutta 4 is used for computation.
%   A parameter study on how the characteristics of the traffic 
%   wave depend on the strength of the optimal velocity term is
%   conducted by varying the coefficient a to see how it affects
%   minumum and maximum velocities.
%
% 03/2016 by Benjamin Seibold, modified by Katrina Janeczko 03/2022

% Parameters
A = 0:0.05:2; % Array holding the coefficient in front of optimal velocity term
n = 22; % number of vehicles
L = 230; % length of road
lv = 4.5; % length of each vehicle
tf = 60*5; % final time
dt = 1e-2; % time step (for integration)
np = 10; % number of time steps between two plotting events
V = @(d) 10*(tanh(d/2-2)+tanh(2))/(1+tanh(2)); % optimal velocity function
f = @(x,a) [x(n+1:2*n);... % ODE right hand side
    20*(x([n+2:2*n,n+1])-x(n+1:2*n))./([x(2:n);x(1)+L]-x(1:n)-lv).^2+...
    a*(V([x(2:n);x(1)+L]-x(1:n)-lv)-x(n+1:2*n))];

% Initialization
q = linspace(0,L,n+1)'; q = q(1:end-1); % initial positions of vehicles
v = (1:n)'; % initial velocities of vehicles
x = [q;v]; % initial state vector

nt = ceil(tf/dt/np)*np; % number of time steps (muliple of np)
dt = tf/nt; % actual time step

UMIN = zeros(n,1); % column vector to store minimum velocity at final time tf
UMAX = zeros(n,1); % column vector to store maximum velocity at final time tf


for s = 1:length(A)
    a = A(s); % Set the coefficient a to be desired value from array A
    
    % Computation
    t = 0; % initial time
    for j = 0:nt/np % time loop
        % Computation
        for i = 1:(np*(j>0)) % Do np compute steps (first time: do nothing)
            k1 = f(x,a); % first slope
            k2 = f(x+dt/2*k1,a); % second slope
            k3 = f(x+dt/2*k2,a); % third slope
            k4 = f(x+dt*k3,a); % fourth slope
            x = x + dt/6*(k1+2*k2+2*k3+k4); % forward Runge-Kutta 4 step
            t = t+dt; % advance time
        end
    end
    
    % Record umin and umax values at final time into respective arrays
    UMIN(s) = min(x(n+1:2*n)); % min velocity in state vector
    UMAX(s) = max(x(n+1:2*n)); % max velocity in state vector

end

% Plotting a values vs UMIN and UMAX
clf
axis([0 L 0 20])
plot(A,UMIN,'b-',A,UMAX,'g-');
legend('umin', 'umax')
title(sprintf('Parameter Study: How Characteristics of Traffic Wave Depend on Strength of Optimal Velocity Term'))
xlabel('Coefficient of velocity term [a]'), ylabel('Vehicle velocity [m/s]')

hold on
