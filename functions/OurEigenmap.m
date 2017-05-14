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
plot_options.title        = [data.name, ' : Projected data with Laplacian Eigenmaps'];
if exist('h4','var') && isvalid(h4), delete(h4);end
h4 = ml_plot_data(proj_LAP_X(:,[1:3]),plot_options);
legend off
ax=gca;
ax.XLabel.FontSize=16;
ax.YLabel.FontSize=16;
ax.ZLabel.FontSize=16;
disp('end of Eigenmap function')
end
