function runCB( hObject, eventdata, handles )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
    
    % get the guidata linked to the figure
    fig=gcf;
    data = guidata(fig);
    
    % check if data is already loaded
    if(isempty(data.dataset))
        disp('no dataset loaded')
    else
        disp(['Running ', data.methodName, ' with dataset "', data.datasetName, '"'])
        switch data.methodName
            case 'Eigenmap'
                Eigenmap( data.dataset , data.labels);
            case 'Isomap'
                Isomap( data.dataset');
            otherwise
                disp('wrong method name')
        end
    end
    
    disp('end of program')   

end

