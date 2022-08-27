function janeczko_problem4a

%JANECZKO_PROBLEM4A
%   A modified version of temple_abm_population_migrate_mate_and_age.m.
%   Agents (representing an animal species) move in a 2d
%   box. In each step an agent moves with a fixed speed
%   in its direction and slightly changes its direction.
%   Moreover, agents age and die when reaching their
%   maximum age. Whenever an integer cell is occupied by
%   exactly two agents, a new agent is born in the center
%   of that cell.
%
% 02/2016 by Benjamin Seibold, modified by Katrina Janeczko 02/2022

% Parameters
N = 500; % initial number of agents
ns = 5000; % number of steps
q = 0.20; % chance for agents in adequately filled squares to reproduce
         % note that for part (a) we set this to .25 but changed it to .20 in part (b)
f = [7,10]; % upper and lower bounds for an adequately filled square, inclusive
ax = [0 10 0 10]; % problem domain
v = .02; % speed of agents (distance traveled per step)
max_age = 100; % each agents lives 100 steps

% Initialization
cx = ax(1):ax(2); cy = ax(3):ax(4); % cell boundaries
X = [ax(1)+(ax(2)-ax(1))/2*rand(N,1),... % initial positions
    ax(3)+(ax(4)-ax(3))*rand(N,1)]; % of agents (left side of domain)
D = rand(N,1)*2*pi; % initial angles of direction of agent
A = randi(max_age,N,1); % age of agents

for j = 1:ns % loop over steps
    % Update positions and directions
    X(:,1) = X(:,1)+v*cos(D); X(:,2) = X(:,2)+v*sin(D); % move agents
    D = D+0.1*randn(size(D)); % change direction of motion
    A = A+1; % increase age of each agent by 1
    
    % Let agents bounce of walls
    ind = (X(:,1)<ax(1)&cos(D)<0)|... % who is hitting a wall
        (X(:,1)>ax(2)&cos(D)>0); % horizontally
    D(ind) = pi-D(ind); % reverse x-direction
    ind = (X(:,2)<ax(3)&sin(D)<0)|... % who is hitting a wall
        (X(:,2)>ax(4)&sin(D)>0); % vertically
    D(ind) = -D(ind); % reverse y-direction
    X(:,1) = min(max(X(:,1),ax(1)),ax(2)); % move agents outside of
    X(:,2) = min(max(X(:,2),ax(3)),ax(4)); % domain back onto boundary
    
    % Mating: if more than/equal to f(1) and fewer than/equal to f(2) agents in same cell, q% chance to create new agent
    [occupied_cells,~,agents_in_cell] = unique(floor(X),'rows');
    cells_with_multiple_agents = occupied_cells(...
        (accumarray(agents_in_cell,1)>=f(1) & accumarray(agents_in_cell,1)<=f(2)),:); % define cells with adequate agents

    N_new = 0;
    if ~isempty(cells_with_multiple_agents)
        for k = 1:size(cells_with_multiple_agents,1) % for every cell with adequate agents
            if rand<q % possibly procreate, with a probability of q%
                X = [X;cells_with_multiple_agents(k,:)+.5]; % add another agent in the center of the cell
                N_new = N_new + 1; % increment the count of new agents created
            end
        end
    end
    D = [D;rand(N_new,1)*2*pi]; % random direction
    A = [A;zeros(N_new,1)]; % age of new agents is 0
    
    % Remove agents who are too old
    ind = A<=max_age; % agents who do not die
    X = X(ind,:); D = D(ind); A = A(ind); % keep those
    
    % Plotting
    clf
    plot([1;1]*cx,ax([3,4])'*(cx*0+1),'k-',... % draw boundaries
        ax([1,2])'*(cy*0+1),[1;1]*cy,'k-') % of cells
    hold on
    ind = A<=max_age/3; % young agents
    plot(X(ind,1),X(ind,2),'.','markersize',12,'color',[0 .8 0])
    ind = max_age/3<A&A<=max_age*2/3; % middle aged agents
    plot(X(ind,1),X(ind,2),'.','markersize',12,'color',[.8 .8 0])
    ind = max_age*2/3<A; % old agents
    plot(X(ind,1),X(ind,2),'.','markersize',12,'color',[1 0 0])
    hold off
    axis equal xy, axis(ax)
    xlabel('x'), ylabel('y') % axis labels
    title(sprintf('Migrating, mating, and aging animals (%d agents)',...
        length(A)))
    
    drawnow
    if ~numel(A), break, end % stop of no agents left

end
