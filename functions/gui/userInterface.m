clear all
close all
clc

% Create figure and guidata and initialize it
fig=figure('Name','Isomap - Eigenmap',...
    'MenuBar', 'none');
fig.Position = fig.Position.*[1 1 0 0] + [0 0 350 200];
fig.Units = 'normalized';
data.methodName='Isomap';
data.methodNumber ='1';
data.datasetName='swissroll';
data.dataset=[];
data.labels=[];
data.M=[];
data.dim=[];
guidata(fig,data);

% create run button
runBt = uicontrol('Style','pushbutton',...
    'String','Run',...
    'Callback',@runCB,...
    'Units', 'normalized',...
    'Position', [0 0 1 0.2]);

% Load button to load the dataset
loadBt = uicontrol('Style','pushbutton',...
    'String','Load dataset',...
    'Callback',@loadDatasetCB,...
    'Units', 'normalized',...
    'Position', [0 0.2 1 0.2]);

% Create dataset list popup menu
list={'swissroll', 'iris', 'breast', 'parkinsons'};
datasetList=uicontrol('Style', 'popup',...
    'String', list,...
    'Callback', @popupCB,...
    'Units', 'normalized',...
    'Position', [0 .4 1 0.2]);

% Create the button group for choosing the method
bg = uibuttongroup('Position',[0 .7 1 .2],...
                   'SelectionChangedFcn',@methodSelectionCB,...
                   'Units', 'normalized');
              
% Create two radio buttons in the button group.
r1 = uicontrol(bg,'Style',...
                  'radiobutton',...
                  'Units', 'normalized',...
                  'String','Isomap',...
                  'Position',[0 .5 1 .5],...
                  'HandleVisibility','off');
              
r2 = uicontrol(bg,'Style','radiobutton',...
                  'String','Eigenmap',...
                  'Units', 'normalized',...
                  'Position',[0 0 1 .5],...
                  'HandleVisibility','off');
