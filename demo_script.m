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
list={'Swissroll', 'Iris', 'Breast', 'Parkinsons', 'FunSwissroll', 'FunSwissroll2'};
loadDataset(list{1});

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
legend off
ax=gca;
ax.Title.FontSize=20;
ax.XLabel.FontSize=16;
ax.YLabel.FontSize=16;
OurEigenmap( data, options)

%% Isomap
clc
disp ('Running Isomap')

options = [];
options.method_name       = 'Isomap';
options.nbDimensions      = 3;      % Number of Eigenvectors to compute.
options.neighbors         = 20;    % Number of k-NN for Adjacency Graph
options.labels            = data.labels;
options.name              = data.name;
options.title             = [data.name, ' : Original data'];

OurIsomap(data.dataset, options)


