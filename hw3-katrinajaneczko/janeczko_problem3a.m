function janeczko_problem3a
%JANECZKO_PROBLEM3A
%   This code plots the paths of 1000
%   butterflies, conduct hill-topping, one after another.
%   In each step of their random walk, the butterfly executes one 
%   of two possible actions: with probability q, it move to the 
%   adjacent cell with the highest elevation; otherwise (with 
%   probability 1-q), it moves to a randomly selected adjacent cell.
%   Moreover, each butterfly continuously lowers the ground below its 
%   position. Their paths end when they reach a hill top or after 1000 steps,
%   whichever comes first. The paths are plotted one butterfly walk at a
%   time.
%
%   01/2016 by Benjamin Seibold, modified by Katrina Janeczko 02/2022


% Parameters
N = 500; % number of butterflies
ns = 1000; % number of random walk steps
q = 0.4; % probability to move to neighbor cell with highest elevation
reduc = 0.1; % reduction coefficient
f = @(x,y) max(100-sqrt((x-30).^2+(y-30).^2),... % elevation function,
    50-sqrt((x-120).^2+(y-100).^2)); % consisting of two conical humps
ax = [0 150 0 150]; % domain for plotting
x0 = [85,95]; % initial position of butterfly

% Initialization
px = ax(1):ax(2); % x-vector for plotting of elevation
py = ax(3):ax(4); % y-vector for plotting of elevation
[PX,PY] = meshgrid(px,py); % generate 2d data for plotting
F = f(PX,PY); % elevation data
xf = zeros(N,2); % array for final positions of butterflies
rx = [-1;-1;-1;0;0;1;1;1]; % x-coordinate of neighbor cells of origin
ry = [-1;0;1;-1;1;-1;0;1]; % y-coordinate of neighbor cells of origin

% Plotting
clf
background = imagesc(px,py,F); % set background to color representation of elevation field
background.CData = F; % plot background
hold on
axis equal xy, axis(ax)
xlabel('x'), ylabel('y') % axis labels

for i = 1:N % loop over number of butterflies
    title(sprintf('Random walk over elevation map (With ground lowering) (butterfly %d/%d)',i,N))
    X = x0; % set initial position

    plot(x0(1),x0(2),'ro') % plot starting position
    plot(xf(:,1),xf(:,2),'m*') % plot final position
    
    for j = 1:ns % loop over steps

        % Random walk step influenced by ground lowering
        nf = interp2(px,py,F,X(end,1)+rx,X(end,2)+ry); % evaluate field on butterfly
        [val,ind] = max(nf); % val is maximum value, ind is index of maximum value
    
        if val<interp2(px,py,F,X(end,1),X(end,2)) % If the butterfly's current position is higher than
            break % any neighboring cell, it's a hill top, so stop random walk
        end

        if rand<1-q % If probability 1-q,
            ind = randi(8); % choose random index for neighbor cell instead of logical choice
        end
        
        % Dig the ground below
        L = reduc*exp(-.05*((PX-X(end,1)).^2+(PY-X(end,2)).^2)); % local influence of this butterfly
        F = max(F-L,0); % reduce elevation by local influence

        step = [rx(ind),ry(ind)]; % step to neighbor cell
        X(end+1,:) = X(end,:)+step; % take step and append matrix
        
        % plot(X(end-1:end,1),X(end-1:end,2),'w-') %animate every frame
        % drawnow
    end
    plot(X(1:end,1),X(1:end,2),'w-') % show every butterfly
    drawnow

    background.CData = F; % plot background
    xf(i,:) = X(end,:); % record endpoints in xf array

end
hold off