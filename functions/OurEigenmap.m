function OurEigenmap(data, options)
%% Compute Laplacian Eigenmap with ML_toolbox

X=data.dataset;
labels=data.labels;

[proj_LAP_X, mappingLAP]  = ml_projection(X,options);

% try
%     [proj_LAP_X, mappingLAP]  = ml_projection(X,options);
% catch
%     error('Please enter a higher number of neighbors or try different sigma!')
% end

% Plot EigenValues to try to find the optimal "p"
if exist('h3a','var') && isvalid(h3a), delete(h3a);end
h3a = ml_plot_eigenvalues(diag(mappingLAP.val));

% Plot result of Laplacian Eigenmaps Projection
plot_options              = [];
plot_options.is_eig       = false;
plot_options.labels       = labels;
plot_options.plot_labels  = {'$y_1$','$y_2$','$y_3$'};
% plot_options.title        = [data.name, ' : Projected data with Laplacian Eigenmaps'];
plot_options.title        = sprintf('Eigenmap Projection $k = %d$', options.neighbors);
if exist('h4','var') && isvalid(h4), delete(h4);end
h4 = ml_plot_data(proj_LAP_X(:,[1:3]),plot_options);
legend off
ax=gca;
ax.XLabel.FontSize=16;
ax.YLabel.FontSize=16;
ax.ZLabel.FontSize=16;

h=figure;
scatter(proj_LAP_X(:,1),proj_LAP_X(:,3),[],options.labels,'filled');
title(sprintf('Eigenmap Projection $k = %d$', options.neighbors), 'Interpreter', 'Latex','fontsize',20)
xlabel('Y1','Interpreter','latex')
ylabel('Y3','Interpreter','latex')
grid on
set(gca,'TickLabelInterpreter', 'latex', 'fontsize',16)

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
name=['output/',data.name,'_Laplacian_dim_', num2str(options.nbDimensions),...
    '_knn_', num2str(options.neighbors),'_sig_', num2str(options.sigma)];
print(name, '-dpdf','-r0')
fprintf(['Figure saved to file ', name,'.pdf!\n'])

disp('end of Eigenmap function')
end

