function loadDataset(datasetName)
 
    % load dataset based on the name
    switch datasetName
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
        case 'FunSwissroll'
            
            [dataset, labels] = swissroll();
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
    
    % save dataset and labels in data struct
    data.name=datasetName;
    data.dataset=dataset;
    data.labels=labels;
    data.M=M;
    data.dim=dim;
    
    % save dataset and labels to workspace
    assignin('base','data',data);
    
    disp([datasetName, ' dataset loaded'])
end
