function [ dx ] = distancex( X, varargin )
%distancex Compute the matrix of euclidian distance dx
%   Compute the matrix dx of euclidian distances between all pairs of 
%   points in a dataset containing M points with N dimensions.
%
%   Inputs:
%       X       MxN input data
%       dfun    distance function: 'L2' or ...
%   
%   Output:
%       dx      MxM distance matrix
%

    p = inputParser;
    p.FunctionName = 'distancex';
    addRequired(p, 'X', @(x)validateattributes(x,{'numeric'},{'2d'}));
    addOptional(p, 'normtype', 'L2', @(x)validateattributes(x,{'char'},{'scalartext'}));
    parse(p, X, varargin{:})
    
    switch validatestring(p.Results.normtype,{'L2'})
        case 'L2'
            normtype = 2;
    end
    
    [M, ~] = size(X);
    dx = zeros(M, M);
    for i=1:M
        for j=1:i
           dx(i,j) = norm(X(i,:) - X(j,:), normtype); 
        end
    end
    
    dx = dx + dx';  % faster to compute the full matrix
end

