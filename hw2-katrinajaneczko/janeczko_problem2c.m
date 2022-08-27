function janeczko_problem2c

%JANECZKO_PROBLEM2C
  % Random walker in one space dimension. In each time step,
  %   each walker steps either up or down with probability 50%, 
  %   and the step size is 1 with probability 95%, and 21 with probability 5%.
  %
  % OUTPUT: histogram of walker's position after 10, 40, 160 steps
  %
  % 01/2022 by Rujeko Chinomona @ Temple University, modified by Katrina Janeczko 1/2022
  %

  % Parameters
  N = 100000; % number of trials for monte carlo simulation
  nsteps = [10 40 160]; % number of steps per trial
  step1 = [-1 1]; 
  step21 = [-21 21]; % define step size to be either 1 or 21
    
  for ns=nsteps
      lastpos=zeros; % storage for last positions
      % Loop over N trials
      for k = 1:N
        x=0; % walker starts at zero
        % Execute random walk
        for j = 1:ns % num steps
            if rand < .95
                x = x + step1(randperm(2,1)); % move up or down one step
            else
                x = x + step21(randperm(2,1)); % move up or down one 21 steps
            end
        end
        lastpos(k) = x; % store last position of walker
      end
      
      clf
      histogram(lastpos)
      title(['Probability Distribution for ',num2str(ns),' steps']);
      ylabel(['trials out of ', num2str(N)])
      xlabel('position of walker')
      print('janeczko_problem2c','-dpng'); % save histograms
      pause
  end

  