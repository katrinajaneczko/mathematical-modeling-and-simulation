% Katrina Janeczko
function janeczko_problem2c

%JANECZKO_PROBLEM2C
  % Random walker in one space dimension. In each time step,
  %   each walker steps either up or down with probability 50%, 
  %   and the step size is 1 with probability 95%, and 21 with probability 5%.
  %
  % OUTPUT: histogram of walker's position after 10, 40, 60 steps
  %
  % 01/2022 by Rujeko Chinomona @ Temple University, modified by Katrina Janecko 1/2022
  %

  % Parameters
  N = 100000; % number of trials for monte carlo simulation
  ns = [10 40 160]; % number of steps per trial
  step1 = [-1 1]; % define step size to be either 1 or 21
  step21 = [-21 21];
  lastpos=zeros; % storage for last positions

  % Loop over N trials
  for k = 1:N
    x=0; % walker starts at zero
    % Execute random walk
    for j = 1:ns
      x = x + step(randperm(2,1)); % move up or down one step
    end
    lastpos(k) = x; % store last position of walker
  end

  clf
  histogram(lastpos)
  title(['Steps=',num2str(ns)]);
  print(['randomwalk1d_',num2str(N),'steps_',num2str(ns)],'-dpng'); % save figure
  disp(std(lastpos))
  disp(var(lastpos))
  disp(mean(lastpos))
end
