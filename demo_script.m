%% setup
clear all
close all
clc

% add path to matlab path
path=pwd;
addpath(genpath([path,'/..']));

% set the seed for rand geneator to ensure repeatability
rng(555);

disp('setup done')

%%
clc

disp ('Running Laplacian Eigenmap')
list={'swissroll', 'iris', 'breast', 'parkinsons', 'FunSwissroll'};
loadDataset(list{5});

options = [];
options.method_name       = 'Laplacian';
options.nbDimensions      = 10;  % Number of Eigenvectors to compute.
options.neighbors         = 30;  % Number of k-NN for Adjacency Graph
options.sigma             = 0.5;   % Sigma for Similarity Matrix

%Eigenmap( data, options)

plot3(data.dataset(data.labels==1,1), data.dataset(data.labels==1,2), data.dataset(data.labels==1,3), '.')
hold on
plot3(data.dataset(data.labels==2,1), data.dataset(data.labels==2,2), data.dataset(data.labels==2,3), '.')
plot3(data.dataset(data.labels==3,1), data.dataset(data.labels==3,2), data.dataset(data.labels==3,3), '.')
plot3(data.dataset(data.labels==4,1), data.dataset(data.labels==4,2), data.dataset(data.labels==4,3), '.')
grid on

Isomap(data)