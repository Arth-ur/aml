% File: swissroll.m
% Author: Arthur Gay
%
% Generate a non-linear 3d "swiss roll" dataset with four classes to be
% used by isomap and eigenmap algorithm.
%

% setup
close all

% parameters
seed = 550; % repeatability
N = 500; % number of points in each class
sx = 2;  % standard deviation on x
sy = 3;  % standard deviation on y
centers = [5 5;15 15;15 5;5 15]; % centers of classes
rng(seed);

% generate gaussian distributions
X = [normrnd(centers(1,1),sx,1,N)...
    normrnd(centers(2,1),sx,1,N)...
    normrnd(centers(3,1),sx,1,N)...
    normrnd(centers(4,1),sx,1,N)];

Y = [normrnd(centers(1,2),sy,1,N)...
    normrnd(centers(2,2),sy,1,N)...
    normrnd(centers(3,2),sy,1,N)...
    normrnd(centers(4,2),sy,1,N)];

% plot original 2d dataset
figure
plot(X(1:N),Y(1:N), 'r.',...
    X(N:2*N), Y(N:2*N), 'g.',...
    X(2*N:3*N), Y(2*N:3*N), 'm.',...
    X(3*N:4*N), Y(3*N:4*N), 'b.');
legend('Class 1', 'Class 2', 'Class 3', 'Class 4', 'Location', 'Best')
title('2D base dataset')

% compute 3d dataset
X3 = X .* cos(X);
Y3 = Y;
Z3 = X .* sin(X);

% plot 3d dataset
figure
plot3(X3(1:N), Y3(1:N), Z3(1:N), 'r.',...
    X3(N:2*N), Y3(N:2*N), Z3(N:2*N), 'g.',...
    X3(2*N:3*N), Y3(2*N:3*N), Z3(2*N:3*N), 'm.',...
    X3(3*N:4*N), Y3(3*N:4*N), Z3(3*N:4*N), 'b.');
view(-16,14)
legend('Class 1', 'Class 2', 'Class 3', 'Class 4', 'Location', 'Best')
title('3D dataset')

% prepare exported data
data = [X3' Y3' Z3'];
labels = reshape(ones(N,1)*(1:4),[1,N*4])';

% export data and figure to output directory
% check if output directory does exist
if ~exist('output', 'dir')
    mkdir('output')
end
% output figures
h = figure(1);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print('output/swissroll2d', '-dpdf','-r0')
h = figure(2);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print('output/swissroll3d', '-dpdf','-r0')
save('output/swissroll.dat', 'data', '-ascii')
save('output/swissroll_labels.dat', 'labels', '-ascii')
% output parameters to .tex file to be used as variables in latex report
kvffile = 'output/swissroll.kvf';
texfile = 'output/swissroll.tex';
diary(kvffile);
disp(['seed = ' num2str(seed)]);
disp(['N = ' num2str(N)]);
disp(['sx = ' num2str(sx)]);
disp(['sy = ' num2str(sy)]);
diary off;
fclose('all');
kvf2tex(kvffile, texfile, 'swissroll'); % to latex
delete(kvffile);

% Reference: http://people.cs.uchicago.edu/~dinoj/manifold/swissroll.html