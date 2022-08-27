function janeczko_problem2b

%JANECZKO_PROBLEM2B
%   Random walkers in one space dimension. In each time step,
%   each walker steps either one step up or one step down
%   (i.e., its position is increased or decreased by 1).
%   In addition, any update step that would cause walkers to
%   collide or cross paths is rejected. Hence the paths of the
%   walkers are not independent. The bottom agent and the top agent 
%   go up or down with probabilities 0.5. The middle agent does the 
%   same if it is exactly in between the other two agents. Otherwise, 
%   it walks with probability 0.6 towards the nearer of the other two agents.
%   Plotted is a histogram of the probability distribution of the middle
%   walker after 100 steps and 10,000 trials.
%
% 01/2016 by Benjamin Seibold, modified 01/2022 Katrina Janeczko

% Parameters
N = 10000; % number of trials for monte carlo simulation
n = 3; % number of walkers
ns = 100; % number of steps
m = round(n/2); % define middle particle
p = m; % particle choice for probability distribution, choices being 1 through n
% Initialization
endpos = zeros(N,n); % Nxn matrix storing walker end positions after ns steps
% Computation
for i = 1:N
    x = (-1:n-2)*5; % initial positions of walkers [-5,0,5]
    for j = 1:ns % time loop
        x0 = x; % create copy of old state
        while 1 % start loop
            if abs(x0(n)-x0(m))==abs(x0(m)-x0(1)) % if middle is exactly between top & bottom
                x = x0+(randi(2,1,n)*2-3); % update all particles with probability 50%
            else 
                for k=1:n
                    if k~=m % if not the middle particle, 
                        x(k) = x0(k)+(randi(2)*2-3); % add random step to walker with probability 50% (either 1 or 2 chosen)
                    else % if it is the middle particle
                        r = rand; % generate random number
                        if (abs(x0(n)-x0(k))<abs(x0(k)-x0(1)) && r<=.6) || (abs(x0(n)-x0(k))>abs(x0(k)-x0(1)) && r>.6) % if closer to top and r<=.60, or if closer to bottom and r>.60
                            x(k) = x0(k)+1; % step toward top
                        else % closer to bottom and r<=.60, or closer to top and r>.60
                            x(k) = x0(k)-1; % step toward bottom
                        end
                    end
                end
            end
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
print('janeczko_problem2b', '-dpng');
