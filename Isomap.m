function [ output_args ] = Isomap( X )
%% 4) Compute Isomap with ML_toolbox
options = [];
options.method_name       = 'Isomap';
options.nbDimensions      = 10;      % Number of Eigenvectors to compute.
options.neighbors         = 120;      % Number of k-NN for Adjacency Graph

try
    [proj_ISO_X, mappingISO]  = ml_projection(X',options);
catch
    error('Please enter a higher number of neighbors')
end

if length(proj_ISO_X)<M
    warning('Graph has disconnected components! \n Only %d points from the largest connected component were projected! \n There Ids are stored in: mappingISO.conn_comp.', length(proj_ISO_X))
end

% Plot EigenValues to try to find the optimal "p"
if exist('h3a','var') && isvalid(h3a), delete(h3a);end
h3a = ml_plot_eigenvalues(diag(mappingISO.val));

end

