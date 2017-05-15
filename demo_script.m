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
loadDataset(list{6});

if verLessThan('MATLAB','9.1')
   warning(['You are running an older version of  MATLAB. '...
       'Some features requires MATLAB R2016b. '...
       'Those features have been disabled.']);
end

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
close all
disp ('Running Isomap')

options = [];
options.method_name       = 'Isomap';
options.nbDimensions      = 3;      % Number of Eigenvectors to compute.
options.neighbors         = 20;    % Number of neighbors for Adjacency Graph
options.labels            = data.labels;
options.name              = data.name;
options.title             = [data.name, ' : Original data'];

[proj_ISO_X, mappingISO] = OurIsomap(data.dataset, options);

scatter(proj_ISO_X(:,1),proj_ISO_X(:,2),[],options.labels,'filled');
title('Isomap projection', 'Interpreter', 'Latex')

h = figure(1);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print('output/isomap-swissroll', '-dpdf','-r0')
fprintf('Figure saved to file isomap-swissroll.pdf!\n')

%% Show neighbors graph
close all

k = 5;  % number of neighbors

[D,ni] =  find_nn(data.dataset, k);
G = graph(tril(D) + tril(D)');  % force symmetry and create graph
if verLessThan('MATLAB','9.1')  % 3D plot only available in matlab R2016b
   warning('3D plot only available in Matlab R2016b');
   plot(G, 'XData', data.dataset(:,1), 'YData', data.dataset(:,3), ...
       'NodeCData', data.labels, 'MarkerSize', 5)
else
    plot(G, 'XData', data.dataset(:,1), 'YData', data.dataset(:,2), ...
        'ZData', data.dataset(:,3), 'NodeCData', data.labels, 'MarkerSize', 5)
    view(-24,12)
end

title('Adjacency graph', 'Interpreter', 'Latex')
xlabel('x', 'Interpreter', 'Latex')
ylabel('y', 'Interpreter', 'Latex')
zlabel('z', 'Interpreter', 'Latex')
save2pdf(figure(1),'isomap-adjacency-graph-k-5')

%% Complexity analysis
yn = 'Y';
if exist('output/timing-isomap.mat', 'file')
    yn = input(['A file "timing-isomap.dat" already esists in the '...
    'output directory. Do you want to reuse previously generated '...
    'data (Y/n)? '], 's');
end
if yn == 'n'
    fprintf('Generating data...\n');
    Ns = linspace(500,5000,ns);
    ntries = 5;
    times = zeros(ns,ntries);
    for i=1:ns
        for j=1:ntries
            [X, ~] = swissroll2(Ns(i), 'ShowFigures', false);
            tic
            Isomap(X');
            times(i,j) = toc;
        end
    end
    save('output/timing-isomap', 'times', 'Ns')
    fprintf('Done! Data saved to file output/timing-isomap.dat\n');
else
    fprintf('Loading previously generated data from file output/timing-isomap.dat...\n');
    load('output/timing-isomap')
    fprintf('Done! Data loaded from file output/timing-isomap.dat\n');
end
boxplot(times', Ns)
xlabel('N','Interpreter','latex')
ylabel('time (s)','Interpreter','latex')
title('Isomap timing','Interpreter','latex')
h = figure(1);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print('output/timing-isomap', '-dpdf','-r0')
fprintf('Figure saved to file timing-isomap.pdf!\n')