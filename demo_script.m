clear all
close all
clc

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

% subplot(2,2,2)
% plot(graph(G), 'XData', X(:, 1), 'YData', X(:, 2), 'ZData', X(:, 3));
% title('graph')

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

%% add path to matlab path
path=pwd;
addpath(genpath([path,'/..']));


%% load dataset
clear all
close all 
clc

% 'swissroll', 'iris', 'breast', 'madelon', 'parkinsons'
dataset_to_load = 'parkinsons';
switch dataset_to_load
    case 'breast'
        breast = load('datasets/breast-cancer-wisconsin.dat');
        data = breast(:,2:10);
        labels = breast(:,11);
        [M,dim]=size(data);
        clear breast
    case 'iris'
        iris = csvread('datasets/iris.csv');
        data = iris(51:150,1:4);    
        labels = iris(51:150,5);
        [M,dim]=size(data);
        clear iris
    case 'swissroll'
        data=load('datasets/swissroll.dat');
        labels=load('datasets/swissroll_labels.dat');
        [M,dim]=size(data);
    case 'madelon'
        data=load('datasets/madelon.dat');
        labels=load('datasets/madelon_labels.dat');
        [M,dim]=size(data);
    case 'parkinsons'
        parkinsons=load('datasets/parkinsons.csv');
        data=parkinsons(:,1:22);
        labels=parkinsons(:,23);
        clear parkinsons
        [M,dim]=size(data);
    otherwise
        data=load('datasets/swissroll.dat');
        labels=load('datasets/swissroll_labels.dat');
        [M,dim]=size(data);
end

disp('dataset loaded')

%% 

% method name

method = 'Isomap';      % for isomap
% method = 'Laplacian';   % for laplacian eigenmap
       
data=swissroll.data;
nDim=3;

% parameters 
% Isomap:         - <int> k -> default = 12
% Laplacian:      - <int> k -> default = 12
%                 - <double> sigma -> default = 1.0
%                 - <char[]> eig_impl -> {['Matlab'], 'JDQR'}
parameters = 6;

[mapped_data, mapping] = compute_mapping(data, method, nDim, parameters);
clc;
disp('algo done')

scatter3(mapped_data(:,1),mapped_data(:,2),mapped_data(:,2),5,swissroll.labels);


