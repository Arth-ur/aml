function loadDataset(datasetName)
 
    % load dataset based on the name
    switch datasetName
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
            [dataset, labels] = swissroll(500);
            [M,dim] = size(dataset);
        case 'Parkinsons'
            parkinsons=load('datasets/parkinsons.csv');
            dataset=parkinsons(:,1:22);
            labels=parkinsons(:,23);
            clear parkinsons
            [M,dim]=size(dataset);
        case 'wdbc'
            wdbc=readtable('datasets/wdbc.csv');
            [labels,idx]=datasample((cell2mat(table2array(wdbc(:,2)))-'B')/('M'-'B')+1, 100);
            dataset = table2array(wdbc(idx,3:end));
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
