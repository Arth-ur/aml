%% Load swissroll dataset
load 'datasets/swissroll.dat';
load 'datasets/swissroll_labels.dat'

X = swissroll;
labels = swissroll_labels;

%% Distance computation between all points and neighborhood graph
dx = distancex(X);
G = neighbors(dx, 'radius', 6);

% And now we project
Y = project(G);


%% Visualization
close all

subplot(2,2,1)
scatter3(X(:,1), X(:,2), X(:,3), 36, labels, '.');
title('swissroll')

subplot(2,2,2)
plot(graph(G), 'XData', X(:, 1), 'YData', X(:, 2), 'ZData', X(:, 3));
title('graph')

subplot(2,2,3)
scatter(Y(:,1), Y(:,2), 36, labels, '.');
title('Projection on first 2 eigenvectors')

subplot(2,2,4)
plot(graph(G), 'XData', Y(:, 1), 'YData', Y(:, 2), 'NodeCData', labels);
title('graph')

colormap jet

%% Same with iris
iris = csvread('datasets/iris.csv');
% we only keep the 2 classes that are not lineearily separable
X = iris(51:150,1:4);
labels = iris(51:150,5);
dx = distancex(X);
G = neighbors(dx, 'count', 12);

Y = project(G);
plot(graph(G), 'NodeCData', labels, 'XData', Y(:,1), 'YData', Y(:,2));
title('projection');
colormap winter

%% load dataset
clear all

swissroll.data=load('datasets/swissroll.dat');           % swissroll
[swissroll.M,swissroll.dim] =size(swissroll.data);
swissroll.labels=load('datasets/swissroll_labels.dat');  % swissroll_labels


%%

% method name

method = 'Isomap';  % 'Laplacian'   for laplacian eigenmap
                    % 'Isomap'      for isomap
               
data=swissroll.data;
nDim=2;

% parameters 
% Isomap:         - <int> k -> default = 12
% Laplacian:      - <int> k -> default = 12
%                 - <double> sigma -> default = 1.0
%                 - <char[]> eig_impl -> {['Matlab'], 'JDQR'}
parameters = 8;

[mapped_data, mapping] = compute_mapping(data, method, nDim, parameters);
disp('algo done')
scatter(mapped_data(:,1),mapped_data(:,2));


