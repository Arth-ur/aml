function [ W ] = weights( G, t )
%WEIGHTS compute weights using heat kernel
%   Input:
%       G: distance matrix (0 if not connected) MxM
%       t: heat kernel parameter. Inf for simple-minded variation.
%   Output:
%       W: MxM weight matrix (0 if not connected)

    [M, ~] = size(G);
    
    W = zeros(M);
    
    for i=1:M
       for j=1:M
           if G(i,j) ~= 0
              W(i,j) = exp(-G(i,j)^2/t);
           end
       end
    end
    

end

