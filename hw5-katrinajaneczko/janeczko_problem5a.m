function janeczko_problem5a
%JANECZKO_PROBLEM5A
% Plots the spread of disease according to the SIR model by applying Heun’s 
% Method (also known as explicit trapezoidal rule) to the model to construct 
% equations. Plots on one figure the lines for susceptible, infected, and 
% recovered fractions of the population versus change in time. 
% s'(t) = -b*s(t)*i(t)          is the susceptible fraction of total population
% i'(t) = b*s(t)*i(t) - k*i(t)  is the infected fraction of total population 
% r'(t) = k*i(t)                is the recovered fraction of total population
% b                             is the rate of infection
% k                             is the rate of recovery
% dt                            is the time step size
%
% Katrina Janeczko 03/2022


% Model Parameters
b = 1/2; % rate of infection
k = 1/3; % rate of recovery

% Time Variables
dt = 1; % time step size
tf = 150; % final time
t = 0:dt:tf; % array of each step to record
n = length(t); % length of the array holding time steps

% Initialize Arrays
s = zeros(n,1); % susceptible population array
i = zeros(n,1); % infected population array
r = zeros(n,1); % recovered population array

% Initial Conditions (sum is approx 0)
s(1) = 1; % initial susceptible population amount
i(1) = 1.27e-6; % initial infected population amount
r(1) = 0; % initial recovered population amount

% Time loop for steps
for j = 2:n
    % Trap method: 
    %   s1 = f(x(j-1))
    %   s2 = f(x(j-1) + dt*s1)
    %   x(j) = x(j-1) + dt*(s1+s2)/2 

    % Calculate first slopes 
    sslope1 = -b * s(j-1) * i(j-1); % first slope for s 
    islope1 = b * s(j-1) * i(j-1) - k * i(j-1);  % first slope for i
    rslope1 = k * i(j-1);  % first slope for r

    % Trapezoidal rule for s equation
    sslope2 = -b * (s(j-1) + dt*sslope1) * (i(j-1) + dt*islope1); % second slope for s
    s(j) = s(j-1) + dt*(sslope1+sslope2)/2; % step with avg slope for s

    % Trapezoidal rule for i equation
    islope2 = b * (s(j-1) + dt*sslope1) * (i(j-1) + dt*islope1) - k * (i(j-1) + dt*islope1); % second slope for i
    i(j) = i(j-1) + dt*(islope1+islope2)/2; % step with avg slope  for i
    
    % Trapezoidal rule for r equation
    rslope2 = k * (i(j-1) + dt*islope1); % second slope for r
    r(j) = r(j-1) + dt*(rslope1+rslope2)/2; % step with avg slope for r

end

% Plotting
clf
plot(t,s,'k-',t,i,'b-',t,r,'g-');
legend('s(t)', 'i(t)', 'r(t)')
xlabel('time'), ylabel('fraction of population') % axis labels
title(sprintf('Spread of Disease with SIR Model Implementing Trapezoidal Method (dt = %d)',dt));
hold on


