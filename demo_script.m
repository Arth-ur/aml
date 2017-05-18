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
list={'Swissroll',... 1
    'Iris',... 2
    'Breast',... 3
    'Parkinsons',... 4
    'FunSwissroll',... 5
    'FunSwissroll2',... 6
    'wdbc'... 7
    };
loadDataset(list{7});

if verLessThan('MATLAB','9.1')
   warning(['You are running an older version of  MATLAB. '...
       'Some features requires MATLAB R2016b. '...
       'Those features have been disabled.']);
end

disp('setup done')

%% Eigenmap
clc
close all

disp ('Running Laplacian Eigenmap')

options = [];
options.method_name       = 'Laplacian';
options.nbDimensions      = 3;  % Number of Eigenvectors to compute.
options.neighbors         = 10;  % Number of k-NN for Adjacency Graph
options.sigma             = 10;   % Sigma for Similarity Matrix
options.labels            = data.labels;
options.title             = [data.name, ' : Original data'];
ml_plot_data(data.dataset, options);
legend off
ax=gca;
ax.Title.FontSize=20;
ax.XLabel.FontSize=16;
ax.YLabel.FontSize=16;
OurEigenmap( data, options)

%% Complexity analysis
yn = 'n';
if exist('functions/output/timing-eigenmap.mat', 'file')
    yn = input(['A file "timing-eigenmap.dat" already esists in the '...
    'output directory. Do you want to reuse previously generated '...
    'data (Y/n)? '], 's');
end
if yn == 'n'
    ns = 5;
    fprintf('Generating data...\n');
    Ns = linspace(500,5000,ns);
    ntries = 10;
    times = zeros(ns,ntries);
    for i=1:ns
        for j=1:ntries
            [X, labels] = swissroll2(Ns(i), 'ShowFigures', false);
            tic
            [proj_LAP_X, mappingLAP]  = ml_projection(X,options);
            times(i,j) = toc;
        end
    end
    save('functions/output/timing-eigenmap', 'times', 'Ns')
    fprintf('Done! Data saved to file output/timing-eigenmap.dat\n');
else
    fprintf('Loading previously generated data from file output/timing-eigenmap.dat...\n');
    load('functions/output/timing-eigenmap')
    fprintf('Done! Data loaded from file output/timing-eigenmap.dat\n');
end

boxplot(times', Ns)
xlabel('N','Interpreter','latex')
ylabel('time (s)','Interpreter','latex')
title('Eigenmap timing','Interpreter','latex')
hold on

n=Ns;
t=2*n.*log(n)*10^-5-0.05;

plot(1:5,t);

axis([-Inf Inf -Inf Inf])
title('Eigenmap timing','Interpreter', 'Latex','fontsize',20)
xlabel('N','Interpreter','latex')
ylabel('Time [s]','Interpreter','latex')
grid on
set(gca,'TickLabelInterpreter', 'latex', 'fontsize',16)

h = figure(1);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print('functions/output/timing-eigenmap', '-dpdf','-r0')
fprintf('Figure saved to file timing-eigenmap.pdf!\n')


%% Isomap
% clc
close all
disp ('Running Isomap')

options = [];
options.method_name       = 'Isomap';
options.nbDimensions      = 3;      % Number of Eigenvectors to compute.
options.neighbors         = 35;    % Number of neighbors for Adjacency Graph
options.labels            = data.labels;
options.name              = data.name;
options.title             = [data.name, ' : Original data'];

[proj_ISO_X, mappingISO] = OurIsomap(data.dataset, options);
if length(proj_ISO_X)==length(data.dataset)
    [D,~] =  find_nn(data.dataset, options.neighbors);
    G = graph(tril(D) + tril(D)');  % force symmetry and create graph
       plot(G, 'XData', proj_ISO_X(:,1), 'YData', proj_ISO_X(:,2), ...
           'NodeCData', data.labels, 'MarkerSize', 5)
else
    scatter(proj_ISO_X(:,1),proj_ISO_X(:,2),[],...
    options.labels(1:size(proj_ISO_X,1)),'filled');
end

title(sprintf('Isomap projection $k=%d$', options.neighbors),...
    'Interpreter', 'Latex', 'fontsize',20)
xlabel('Y1','Interpreter','latex')
ylabel('Y2','Interpreter','latex')
grid on
set(gca,'TickLabelInterpreter', 'latex', 'fontsize',16)

save2pdf(figure(1), sprintf('isomap-%s-k-%d', data.name, options.neighbors));


%% Show neighbors graph
close all

k = 5;  % number of neighbors

[D,~] =  find_nn(data.dataset, k);
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

title(sprintf('Adjacency graph $k=%d$', k), 'Interpreter', 'Latex')
xlabel('x', 'Interpreter', 'Latex')
ylabel('y', 'Interpreter', 'Latex')
zlabel('z', 'Interpreter', 'Latex')
save2pdf(figure(1),sprintf('isomap-adjacency-graph-k-%d', k))

%% Complexity analysis
yn = 'n';
ns=7;
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
            [proj_ISO_X, mappingISO]  = ml_projection(X,options);
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
ylabel('Time [s]','Interpreter','latex')
title('Isomap timing','Interpreter','latex')
h = figure(1);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print('output/timing-isomap', '-dpdf','-r0')
fprintf('Figure saved to file timing-isomap.pdf!\n')