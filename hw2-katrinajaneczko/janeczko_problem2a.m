function janeczko_problem2a

%JANECZKO_PROBLEM2A
%   Random walkers in one space dimension. In each time step,
%   each walker steps either one step up or one step down
%   (i.e., its position is increased or decreased by 1).
%   In addition, any update step that would cause walkers to
%   collide or cross paths is rejected. Hence the paths of the
%   walkers are not independent.
%   Plotted is a histogram of the probability distribution of the bottom
%   walker after 100 steps and 10,000 trials.
%
% 01/2016 by Benjamin Seibold, modified 01/2022 Katrina Janeczko

% Parameters
N = 10000; % number of trials for monte carlo simulation
n = 3; % number of walkers
ns = 100; % number of steps
p = 1; % particle choice for probability distribution, choices being 1 through n

% Initialization
endpos = zeros(N,n); % Nxn matrix storing walker end positions after n steps

% Computation
for i = 1:N
    x = (0:n-1)*5; % initial positions of walkers [0,5,10]
    for j = 1:ns % time loop
        x0 = x; % create copy of old state
        while 1 % start loop
            x = x0+(randi(2,1,n)*2-3); % add random step to all walkers
            if all(diff(x)>0) % if no walker collision or crossing,
                break % terminate loop
            end
        end
    end
    endpos(i,:) = endpos(i,:) + x; % save new state into matrix
end
% Plot probability distribution of bottom walker after 100 steps
clf
histogram(endpos(:, p))
title(['Probability Distribution for ',num2str(ns),' steps']);
ylabel(['trials out of ', num2str(N)])
xlabel(['position of walker ',num2str(p)])
print('janeczko_problem2a', '-dpng');
