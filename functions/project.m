function [ Y ] = project( G )
%PROJECT project on eigenvectors
%   Inputs:
%       G       weighted neighborhood matrix MxM
%
%   Outputs:
%       Y       projection data MxM on eigenvectors (sorted)
%
    
    [M, ~] = size(G);

    % Shortest path computation between all points
    dg = distances(graph(G), 'Method', 'positive');
    % square of distances
    S = dg.^2;
    % centering matrix
    H = eye(M) - 1/M * ones(M);
    TD = -H*S*H/2;
    [Y, ~, ~] = eig(TD);

end

