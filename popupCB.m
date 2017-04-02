function popupCB(source,event)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    fig=gcf;
    data = guidata(fig);
    data.datasetName=source.String{source.Value};
    guidata(fig, data);

end

