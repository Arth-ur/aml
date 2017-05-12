function Isomap( X )
%% 4) Compute Isomap with ML_toolbox
options = [];
options.method_name       = 'Isomap';
options.nbDimensions      = 2;      % Number of Eigenvectors to compute.
options.neighbors         = 8;      % Number of k-NN for Adjacency Graph

[proj_ISO_X, mappingISO]  = ml_projection(X',options);

if length(proj_ISO_X)<length(X)
    warning('Graph has disconnected components! \n Only %d points from the largest connected component were projected! \n There Ids are stored in: mappingISO.conn_comp.', length(proj_ISO_X))
end

%scatter(proj_ISO_X(:,1),proj_ISO_X(:,2),[],linspace(0,1,size(proj_ISO_X,1)),'filled');

% Plot EigenValues to try to find the optimal "p"
%if exist('h3a','var') && isvalid(h3a), delete(h3a);end
%h3a = ml_plot_eigenvalues(diag(mappingISO.val));

end

