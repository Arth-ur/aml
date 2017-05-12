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
    dg = distances(graph(G));
    
    % square of distances
    S = dg.^2;
    % centering matrix
    H = eye(M) - 1/M * ones(M);
    TD = -H*S*H/2;
%    TD = -.5 .* (bsxfun(@minus, bsxfun(@minus, S, sum(S, 1)' ./ n), sum(S, 1) ./ n) + sum(S(:)) ./ (n .^ 2));
    [Y, ~, ~] = eig(TD);

end

