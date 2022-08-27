function janeczko_problem7c
%JANECZKO_PROBLEM7C
%   Implementation of the popular cellular automaton model
%   game of life by John Conway. A cell remains alive it it
%   has 2 or 3 live neighbors, and a dead cell becomes alive
%   if it has exactly 3 neighbors. Otherwise cells die or
%   remain dead. In this version, initial conditions are
%   read from data files (data format is as in
%   http://www.radicaleye.com/lifepage/glossary.html).
%   The present example needs the files
%   LWSS.txt and barberpole_extended.txt to run. 
%   
%   DESCRIPTION: It shows many copies of a pattern called
%   LWSS in a V-pattern which looks like a flock of birds.
%   They fly toward a wall of a pattern called "barberpole" 
%   (which I have duplicated within its textfile many times
%   in order to create a wall). When the birds begin to land
%   at the wall, the first couple are essentially consumed,
%   and then afterward as they interact with the wall, a variety 
%   of patterns not originally present form, including blinkers 
%   and beehives. A small portion of the wall remains.
%
% 03/2022 by Katrina Janeczko

% Parameters
n = [150,100]; % number of cells per dimension

filename{1} = 'LWSS.txt';
pos{1} = [0,20]; % position of object loaded from file (top corner)
filename{2} = 'LWSS.txt';
pos{2} = [20,30]; % position of object loaded from file (top corner)
filename{3} = 'LWSS.txt';
pos{3} = [40,40]; % position of object loaded from file (top corner)
filename{4} = 'LWSS.txt';
pos{4} = [60,50]; % position of object loaded from file (top corner)
filename{5} = 'LWSS.txt';
pos{5} = [40,60]; % position of object loaded from file (top corner)
filename{6} = 'LWSS.txt';
pos{6} = [20,70]; % position of object loaded from file (top corner)
filename{7} = 'LWSS.txt';
pos{7} = [0,80]; % position of object loaded from file (top corner)
filename{8} = 'barberpole_extended.txt';
pos{8} = [140,0]; % position of object loaded from file (top corner)


% Construct initial configuration
F = zeros(n); % initialize empty array
for j = 1:length(pos) % loop over objects
    S = load_data_file(filename{j}); % road data file
    F(pos{j}(1)+(1:size(S,1)),... % add object
        pos{j}(2)+(1:size(S,2))) = S; % to 2d array
end

% Initialization
n = size(F); % new size of domain (if necessary)
shl1 = [n(1),1:n(1)-1]; shr1 = [2:n(1),1]; % shift index vectors in dim 1
shl2 = [n(2),1:n(2)-1]; shr2 = [2:n(2),1]; % shift index vectors in dim 2

% Computation
clf
for j = 0:3000 % time loop
    % Plotting
    imagesc(~F') % plot array of cells
    axis equal tight, caxis([0,1]), colormap(gray)
    title(sprintf('Game of life after %d steps',j))
    pause(1e-2+(j==0)) % wait a bit (and a bit more initially)
    % Update rule
    neighbors = F(shl1,shl2)+F(shl1,:)+F(shl1,shr2)+... % number
        F(:,shl2)+F(:,shr2)+... % of neighbors
        F(shr1,shl2)+F(shr1,:)+F(shr1,shr2); % for each cell
    F = (F&(neighbors==2|neighbors==3))|... % cell remains alive
        (~F&neighbors==3); % or cell becomes alive
end

%========================================================================

function S = load_data_file(filename)
% Read the data file filename and assign the information in 2d array S.
fid = fopen(filename,'r'); % open data file for reading
data = double(fscanf(fid,'%c',inf)); % read data as single string
fclose(fid); % close file
data = [10,data,10]; % add space in beginning and end of string
ind_data = data==42|data==46; % indices where actual cell data is stored
i_start = find(diff(ind_data)==1); % beginning index of row
i_end = find(diff(ind_data)==-1); % beginning index of row
row_length = i_end(1)-i_start(1); % length of each row in data
data = data(ind_data); % remove non-cell information
data = data==42; % make data logical for cell states
S = reshape(data,row_length,[]); % object stored as 2d array
