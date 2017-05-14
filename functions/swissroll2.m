function [data, labels] = swissroll2(varargin)
    % SWISSROLL Generate a swiss roll dataset
    %   [DATA, LABELS] = SWISSROLL() generates swissroll with default
    %   parameters.
    %
    %   [DATA, LABELS] = SWISSROLL(N) generates swissroll with 
    %   N samples per class, with class centered around the CENTERS which
    %   is a 4x2 array and with a standard deviation along the x and y axis
    %   given by the 2-elements array S = [SX, SY].
    %
    %   [DATA, LABELS] = SWISSROLL(__, 'Output', output)  enables output of
    %   data and figures to files.
    %
    %   [DATA, LABELS] = SWISSROLL(__, 'OutputDir', outputDir)  sets the
    %   output directory.
    %
    %   [DATA, LABELS] = SWISSROLL(__, 'ShowFigures', showFigures)  enables
    %   the display of figures.
    %
    %   Informations
    %   ------------
    %   File: swissroll.m
    %   Author: Arthur Gay
    %   Date: 2017-05-05
    %   
    
    p = inputParser;
    p.FunctionName = 'swissroll';
    addOptional(p,'N', 500, ...
        @(x) validateattributes(x,{'numeric'},{'scalar','integer','nonnegative'}));
    addOptional(p,'centers', [5 5;15 15;15 5;5 15],...
        @(x) validateattributes(x,{'numeric'},{'size', [4,2]}));
    addOptional(p, 's', [2, 3], ...
        @(x) validateattributes(x,{'numeric'},{'size',[1,2],'nonnegative'}));
    addParameter(p, 'Seed', 550);
    addParameter(p, 'Output', false, ...
        @(x) validateattributes(x,{'logical'},{'scalar'}));
    addParameter(p, 'OutputDir', '.');
    addParameter(p, 'ShowFigures', true, ...
        @(x) validateattributes(x,{'logical'},{'scalar'}));
    parse(p,varargin{:});
    
    if any(ismember(p.UsingDefaults, 'N'))
        warning('amlp:usingdefaults', ...
            'Using default value for parameter %s', 'N'),
    end
    if ~any(ismember(p.UsingDefaults, 'centers'))
        warning('amlp:usingdeprecated', ...
            'Using deprecated parameter %s', 'centers'),
    end
    if ~any(ismember(p.UsingDefaults, 's'))
        warning('amlp:usingdeprecated', ...
            'Using deprecated parameter %s', 's'),
    end
    if ~any(ismember(p.UsingDefaults, 'Seed'))
        warning('amlp:usingdeprecated', ...
            'Using deprecated parameter %s', 'Seed'),
    end
 
    % parameters
    N = p.Results.N; % number of points in each class

    % generate gaussian distributions
    X = sort(rand(1,N)*2*pi*2);

    Y = rand(1,N)/10;

    % compute 3d dataset
    X3 = X .* cos(X);
    Y3 = Y;
    Z3 = X .* sin(X);
    
    if p.Results.ShowFigures
        % plot original 2d dataset
        figure
        scatter(X(1:N),Y(1:N),[],linspace(0,1,N), 'filled');
        title('2D base dataset','Interpreter','latex')

        % plot 3d dataset
        figure
        scatter3(X3(1:N), Y3(1:N), Z3(1:N), [], linspace(0,1,N), 'filled');
        view(-16,14)
        title('3D dataset','Interpreter','latex')
    end

    % prepare exported data
    data = [X3' Y3' Z3'];
    labels = (1:N)';

    % export data and figure to output directory
    % check if output directory does exist
    if p.Results.Output
        if ~exist(p.Results.OutputDir, 'dir')
            mkdir(p.Results.OutputDir)
        end
        
        % output figures
        if p.Results.ShowFigures
            h = figure(1);
            set(h,'Units','Inches');
            pos = get(h,'Position');
            set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
            print([p.Results.OutputDir '/swissroll2d'], '-dpdf','-r0')
            h = figure(2);
            set(h,'Units','Inches');
            pos = get(h,'Position');
            set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
            print([p.Results.OutputDir '/swissroll3d'], '-dpdf','-r0')
            save([p.Results.OutputDir '/swissroll.dat'], 'data', '-ascii')
            save([p.Results.OutputDir '/swissroll_labels.dat'], 'labels', '-ascii')
        end
        
        % output parameters to .tex file to be used as variables in latex report
        kvffile = [p.Results.OutputDir '/swissroll.kvf'];
        texfile = [p.Results.OutputDir '/swissroll.tex'];
        diary(kvffile);
        disp(['N = ' num2str(N)]);
        diary off;
        fclose('all');
        kvf2tex(kvffile, texfile, 'swissroll'); % to latex
        delete(kvffile);
    end
    
    % Reference: http://people.cs.uchicago.edu/~dinoj/manifold/swissroll.html
end