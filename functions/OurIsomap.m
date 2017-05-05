function OurIsomap( X , options)
%% Compute Isomap with ML_toolbox

[proj_ISO_X, mappingISO]  = ml_projection(X,options);

% try
%     [proj_ISO_X, mappingISO]  = ml_projection(X,options);
% catch
%     error('Please enter a higher number of neighbors')
% end

if length(proj_ISO_X)<length(X)
    warning('Graph has disconnected components! \n Only %d points from the largest connected component were projected! \n There Ids are stored in: mappingISO.conn_comp.', length(proj_ISO_X))
end

% Plot EigenValues to try to find the optimal "p"
if exist('h3a','var') && isvalid(h3a), delete(h3a);end
h3a = ml_plot_eigenvalues(diag(mappingISO.val));

options.title        = [data.name, ' : Projected data with Isomap'];
ml_plot_data(proj_ISO_X(:,[1:3]), options);

disp('end of Isomap function')

end

