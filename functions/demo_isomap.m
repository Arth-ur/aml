clear all
close all
clc

%% Load swissroll dataset
fprintf('\n\nGenerating Swiss roll dataset...')
close all
dx = 5;
dy = 2;
%[X, labels] = swissroll(100, [10-dx,10-dy;10+dx,10-dy;10-dx,10+dy;10+dx,10+dy], [2.5,1], 'ShowFigures', false);
[X, labels] = swissroll2(1000, 'ShowFigures', false);
fprintf('Done!\n')
%%
% Distance computation between all points and neighborhood graph
fprintf('Building neighborhood graph...')
fprintf('distance matrix\n')
dx = distancex(X);
fprintf(repmat('\b', 1, length('distance matrix')+1))
fprintf('neighbors\n')
G = neighbors(dx, 'count', 8);
fprintf(repmat('\b', 1, length('neighbors')+1))
fprintf('Done!\n')

subplot(2,2,1)
scatter3(X(:,1),X(:,2),X(:,3),[],linspace(0,1,size(X,1)),'filled');
title('swissroll')
view(-22,5)

subplot(2,2,2)
plot(graph(G), 'XData', X(:, 1), 'YData', X(:, 2), 'ZData', X(:,3), 'NodeCData', linspace(0,1,size(X,1)));
title('graph')

% And now we project
Y = project(G);

subplot(2,2,3)
plot(graph(G), 'XData', Y(:, 1), 'YData', Y(:, 2), 'NodeCData', linspace(0,1,size(Y,1)));
title('graph')

subplot(2,2,4)
scatter(Y(:,1), Y(:,2), [], linspace(0,1,size(Y,1)));
title('Projection on first 2 eigenvectors')

%%
for N=linspace(500,5000,2)
    [X, labels] = swissroll2(N, 'ShowFigures', false);
    dx = distancex(X);
    G = neighbors(dx, 'count', 10);
    Y = project(G);
end

%%
ns = 7;
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
save('output/timing-isomap.dat', 'times', 'Ns')
%%
%load('output/timing-isomap.dat')
boxplot(times', Ns)
xlabel('N','Interpreter','latex')
ylabel('time (s)','Interpreter','latex')
title('Isomap timing','Interpreter','latex')
h = figure(1);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print('output/timing-isomap', '-dpdf','-r0')