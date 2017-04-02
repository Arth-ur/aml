function loadDatasetCB(hObject, eventdata, handles)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    % get the guidata linked to the figure
    fig=gcf;
    data = guidata(fig);
    
    % load dataset based on the name
    switch data.datasetName
        case 'breast'
            breast = load('datasets/breast-cancer-wisconsin.dat');
            dataset = breast(:,2:10);
            labels = breast(:,11);
            [M,dim]=size(dataset);
            clear breast
        case 'iris'
            iris = csvread('datasets/iris.csv');
            dataset = iris(51:150,1:4);    
            labels = iris(51:150,5);
            [M,dim]=size(dataset);
            clear iris
        case 'swissroll'
            dataset = load('datasets/swissroll.dat');
            labels = load('datasets/swissroll_labels.dat');
            labels = labels(dataset(:,1)>-10);
            dataset = dataset(dataset(:,1)>-10,:);
            [M,dim] = size(dataset);
        case 'parkinsons'
            parkinsons=load('datasets/parkinsons.csv');
            dataset=parkinsons(:,1:22);
            labels=parkinsons(:,23);
            clear parkinsons
            [M,dim]=size(dataset);
        otherwise
            dataset=load('datasets/swissroll.dat');
            labels=load('datasets/swissroll_labels.dat');
            [M,dim]=size(dataset);
    end
    
    % save dataset and labels to guidata
    data.dataset=dataset;
    data.labels=labels;
    data.M=M;
    data.dim=dim;
    guidata(fig,data);
    
    % save dataset and labels to workspace
    assignin('base','data',data);
    
    disp('dataset loaded')
end



