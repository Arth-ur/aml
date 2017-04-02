function methodSelectionCB(source,event)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    fig=gcf;
    data = guidata(fig);
    data.methodName=event.NewValue.String;
    
    switch data.methodName 
        case 'Isomap'
           data.methodNumber = 1;
        case 'Eigenmap'
           data.methodNumber = 2;
        otherwise
           data.methodName = 'Isomap';
           data.methodNumber = 1;
    end
    
    guidata(fig,data);
end