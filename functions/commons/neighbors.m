function [ G ] = neighbors( dx, method, parameter )
%NEIGHBORS Compute the weighted graph G between all points
%   Two methods are implemented:
%       'radius': all points within a fixed radius epsilon   
%       'count': nearest k neigbors
%
%   Inputs:
%       dx          distance matrix MxM
%       method      Either 'radius' or 'count'
%       parameter   depending of the method, it is either the radius
%                   epsilon or the count k of nearest neighbours
%
%   Outputs:
%       G           weighted graph. A zero value 0 means no connection

    [M, ~] = size(dx);
    switch method
        case 'radius'
            G = tril(dx);
            for i=1:M
                for j=1:i
                    if dx(i,j) > parameter
                        G(i,j) = 0;
                    end
                end
            end
            G = G + G';
        case 'count' % Note: a better algorithm could be implemented
            G = dx;
            parameter = min(parameter, M);
            for i=1:M
                [x, si] = sort(dx(i, :));
                if length(si) > parameter+sum(x==0)
                    G(i, si(parameter+2:end)) = 0;
                end
            end
            for i=1:M
                for j=1:i
                    if G(i,j) > 0
                        G(j,i) = G(i,j);
                    end
                    if G(j,i) > 0
                        G(i,j) = G(j,i);
                    end
                end
            end
        otherwise
            error(['Unknown method "' ...
                method '". Should be "count" or "radius".']);
    end
end

