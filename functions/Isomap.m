function Isomap( X )
%% Compute Isomap with ML_toolbox
options = [];
options.method_name       = 'Isomap';
options.nbDimensions      = 3;      % Number of Eigenvectors to compute.
options.neighbors         = 50;      % Number of k-NN for Adjacency Graph

try
    [proj_ISO_X, mappingISO]  = ml_projection(X',options);
catch
    error('Please enter a higher number of neighbors')
end

if length(proj_ISO_X)<length(X)
    warning('Graph has disconnected components! \n Only %d points from the largest connected component were projected! \n There Ids are stored in: mappingISO.conn_comp.', length(proj_ISO_X))
end

% Plot EigenValues to try to find the optimal "p"
if exist('h3a','var') && isvalid(h3a), delete(h3a);end
h3a = ml_plot_eigenvalues(diag(mappingISO.val));

disp('end of isomap function')

end

