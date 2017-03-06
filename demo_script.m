%% Load swissroll dataset
load 'datasets/swissroll.dat';
load 'datasets/swissroll_labels.dat'

%% Distance computation between all points and neighborhood graph
dx = distancex(swissroll);
G = neighbors(dx, 'radius', 6);

%% And now we project
Y = project(G);


%% Visualization
close all

subplot(1,3,1)
scatter3(swissroll(:,1), swissroll(:,2), swissroll(:,3), 36, swissroll_labels, '.');
title('swissroll')

subplot(1,3,2)
plot(graph(G), 'XData', swissroll(:, 1), 'YData', swissroll(:, 2), 'ZData', swissroll(:, 3));
title('graph')

subplot(1,3,3)
scatter(Y(:,1), Y(:,2), 36, swissroll_labels, '.');
title('Projection on first 2 eigenvectors')