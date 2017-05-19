function [proj_ISO_X, mappingISO] = OurIsomap( X , options)
%% Compute Isomap with ML_toolbox

if(length(X)>1000)
    warning(['number of data points is larger than 1000, expect time '...
        'spent in djikstra to be quite long'])
end
[proj_ISO_X, mappingISO]  = ml_projection(X,options);

if length(proj_ISO_X)<length(X)
    warning(['Graph has disconnected components!\n'...
        'Only %d points from the largest connected component were'...
        'projected!\n Their Ids are stored in: mappingISO.conn_comp.',...
        length(proj_ISO_X)])
end

disp('end of Isomap function')

end

