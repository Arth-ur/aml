function [ dx ] = distancex( X, normtype )
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
    switch nargin
        case 1
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

