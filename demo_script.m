%% setup
clear all
close all
clc

% add path to matlab path
path=pwd;
addpath(genpath([path,'/..']));

% set the seed for rand geneator to ensure repeatability
rng(555);

% choose dataset
list={'swissroll', 'iris', 'breast', 'parkinsons', 'FunSwissroll'};
loadDataset(list{5});

disp('setup done')

%% Eigenmap
clc

disp ('Running Laplacian Eigenmap')

options = [];
options.method_name       = 'Laplacian';
options.nbDimensions      = 10;  % Number of Eigenvectors to compute.
options.neighbors         = 30;  % Number of k-NN for Adjacency Graph
options.sigma             = 0.5;   % Sigma for Similarity Matrix
options.labels            = data.labels;
options.title             = [data.name, ' : Original data'];
ml_plot_data(data.dataset, options);
OurEigenmap( data, options)

%% Isomap
clc
disp ('Running Isomap')

options = [];
options.method_name       = 'Isomap';
options.nbDimensions      = 3;      % Number of Eigenvectors to compute.
options.neighbors         = 200;    % Number of k-NN for Adjacency Graph
options.labels            = data.labels;
options.title             = [data.name, ' : Original data'];


ml_plot_data(data.dataset, options);
OurIsomap(data.dataset, options)

