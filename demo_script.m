%% setup
clear all
close all
clc

% add path to matlab path
path=pwd;
addpath(genpath([path,'/..']));

disp('setup done')

%%
clc

disp ('Running Laplacian Eigenmap')
list={'swissroll', 'iris', 'breast', 'parkinsons'};
loadDataset(list{3});

options = [];
options.method_name       = 'Laplacian';
options.nbDimensions      = 10;  % Number of Eigenvectors to compute.
options.neighbors         = 40;  % Number of k-NN for Adjacency Graph
options.sigma             = 1;   % Sigma for Similarity Matrix

Eigenmap( data, options)