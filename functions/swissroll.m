function [data, labels] = swissroll(varargin)
    % SWISSROLL Generate a swiss roll dataset
    %   [DATA, LABELS] = SWISSROLL() generates swissroll with default
    %   parameters.
    %
    %   [DATA, LABELS] = SWISSROLL(N, CENTERS, S) generates swissroll with 
    %   N samples per class, with class centered around the CENTERS which
    %   is a 4x2 array and with a standard deviation along the x and y axis
    %   given by the 2-elements array S = [SX, SY].
    %
    %   [DATA, LABELS] = SWISSROLL(__, 'Seed', seed) sets the seed for the
    %   random number generator.
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
    if any(ismember(p.UsingDefaults, 'centers'))
        warning('amlp:usingdefaults', ...
            'Using default value for parameter %s', 'centers'),
    end
    if any(ismember(p.UsingDefaults, 's'))
        warning('amlp:usingdefaults', ...
            'Using default value for parameter %s', 's'),
    end
    
    % rng seed
    if ~any(ismember(p.UsingDefaults, 's'))
        seed = p.Results.Seed;
        rng(seed);
    end
 
    % parameters
    N = p.Results.N; % number of points in each class
    sx = p.Results.s(1);  %2 standard deviation on x
    sy = p.Results.s(2);  %3 standard deviation on y
    centers = p.Results.centers; % centers of classes

    % generate gaussian distributions
    X = [normrnd(centers(1,1),sx,1,N)...
        normrnd(centers(2,1),sx,1,N)...
        normrnd(centers(3,1),sx,1,N)...
        normrnd(centers(4,1),sx,1,N)];

    Y = [normrnd(centers(1,2),sy,1,N)...
        normrnd(centers(2,2),sy,1,N)...
        normrnd(centers(3,2),sy,1,N)...
        normrnd(centers(4,2),sy,1,N)];

    % compute 3d dataset
    X3 = X .* cos(X);
    Y3 = Y;
    Z3 = X .* sin(X);
    
    if p.Results.ShowFigures
        % plot original 2d dataset
        figure
        plot(X(1:N),Y(1:N), 'r.',...
            X(N:2*N), Y(N:2*N), 'g.',...
            X(2*N:3*N), Y(2*N:3*N), 'm.',...
            X(3*N:4*N), Y(3*N:4*N), 'b.');
        legend('Class 1', 'Class 2', 'Class 3', 'Class 4', 'Location', 'Best')
        title('2D base dataset')

        % plot 3d dataset
        figure
        plot3(X3(1:N), Y3(1:N), Z3(1:N), 'r.',...
            X3(N:2*N), Y3(N:2*N), Z3(N:2*N), 'g.',...
            X3(2*N:3*N), Y3(2*N:3*N), Z3(2*N:3*N), 'm.',...
            X3(3*N:4*N), Y3(3*N:4*N), Z3(3*N:4*N), 'b.');
        view(-16,14)
        legend('Class 1', 'Class 2', 'Class 3', 'Class 4', 'Location', 'Best')
        title('3D dataset')
    end

    % prepare exported data
    data = [X3' Y3' Z3'];
    labels = reshape(repmat(1:4,N,1),[1,N*4])';

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
        if exist('seed', 'var')
            disp(['seed = ' num2str(seed)]);
        end
        disp(['N = ' num2str(N)]);
        disp(['sx = ' num2str(sx)]);
        disp(['sy = ' num2str(sy)]);
        diary off;
        fclose('all');
        kvf2tex(kvffile, texfile, 'swissroll'); % to latex
        delete(kvffile);
    end
    
    % Reference: http://people.cs.uchicago.edu/~dinoj/manifold/swissroll.html
end
