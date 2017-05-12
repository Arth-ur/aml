function loadDataset(datasetName)
 
    % load dataset based on the name
    switch datasetName
        case 'Breast'
            breast = load('datasets/breast-cancer-wisconsin.dat');
            dataset = breast(:,2:10);
            labels = breast(:,11);
            [M,dim]=size(dataset);
            clear breast
        case 'Iris'
            iris = csvread('datasets/iris.csv');
            dataset = iris(51:150,1:4);    
            labels = iris(51:150,5);
            [M,dim]=size(dataset);
            clear iris
        case 'Swissroll'
            dataset = load('datasets/swissroll.dat');
            labels = load('datasets/swissroll_labels.dat');
            labels = labels(dataset(:,1)>-10);
            dataset = dataset(dataset(:,1)>-10,:);
            [M,dim] = size(dataset);
        case 'FunSwissroll'
            [dataset, labels] = swissroll(100,[5,8;5,12;15,8;15,12],[2.5, 1]);
            [M,dim] = size(dataset);
        case 'FunSwissroll2'
            [dataset, labels] = swissroll2(1000);
            labels=linspace(0,1,1000);
            [M,dim] = size(dataset);
        case 'Parkinsons'
            parkinsons=load('datasets/parkinsons.csv');
            dataset=parkinsons(:,1:22);
            labels=parkinsons(:,23);
            clear parkinsons
            [M,dim]=size(dataset);
        otherwise
            datasetName='Swissroll';
            dataset=load('datasets/swissroll.dat');
            labels=load('datasets/swissroll_labels.dat');
            [M,dim]=size(dataset);
    end
    
    % save dataset and labels in data struct
    data.name=datasetName;
    data.dataset=dataset;
    data.labels=labels;
    data.M=M;
    data.dim=dim;
    
    % save dataset and labels to workspace
    assignin('base','data',data);
    
    data
    
    disp([datasetName, ' dataset loaded'])
end
