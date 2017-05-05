function [ Y, V ] = eigproject( W )
%EIGPROJECT project eigenmap
%   Input:
%       W: MxM weight matrix
%   Output:
%       Y: MxM eigen vectors

    % diagonal weight matrix
    [M, ~] = size(W);
    D = zeros(M);   
    
    for i=1:M
       D(i,i) = sum(W(i, :)); 
    end
    
    % Laplacian matrix
    L = D - W;

    %[ Y, V ] = eig(L, D);
    
    [Y,V] = eig(L, D);
    %[V,I] = sort(diag(V));
    %Y = Y(:, I);    
end

