clear all
close all
clc

% Create figure and guidata and initialize it
fig=figure('Name','Isomap - Eigenmap');
data.methodName='Isomap';
data.methodNumber ='1';
data.datasetName='swissroll';
data.dataset=[];
data.labels=[];
data.M=[];
data.dim=[];
guidata(fig,data);

% Create dataset list popup menu
list={'swissroll', 'iris', 'breast', 'parkinsons'};
datasetList=uicontrol('Style', 'popup','String', list, 'Callback', @popupCB);
datasetList.Position = [100 300 80 20];

% Create the button group for choosing the method
bg = uibuttongroup('Visible','off',...
                  'Position',[0.1 0.8 0.2 0.2],...
                  'SelectionChangedFcn',@methodSelectionCB);
              
% Create three radio buttons in the button group.
r1 = uicontrol(bg,'Style',...
                  'radiobutton',...
                  'String','Isomap',...
                  'Position',[10 40 100 30],...
                  'HandleVisibility','off');
              
r2 = uicontrol(bg,'Style','radiobutton',...
                  'String','Eigenmap',...
                  'Position',[10 10 100 30],...
                  'HandleVisibility','off');
% make group visible
bg.Visible = 'on';

% create close button
closeBt = uicontrol('Style','pushbutton','String','Close','Callback',@closeCB);
closeBt.Position = [300 100 80 20];

% create run button
runBt = uicontrol('Style','pushbutton','String','Run','Callback',@runCB);
runBt.Position = [200 100 80 20];

% Load button to load the dataset
loadBt = uicontrol('Style','pushbutton','String','Load dataset','Callback',@loadDatasetCB);
loadBt.Position = [100 100 80 20];

