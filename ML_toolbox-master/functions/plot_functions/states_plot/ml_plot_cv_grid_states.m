function [ handle ] = ml_plot_cv_grid_states(stats,options)
%ML_PLOT_CV_GRID_STATES Plots the results of grid search K-fold Cross
% Validation
%
%   input -----------------------------------------------------------------
%
%       o stats     : struct,   multi-layer structure, see output of
%                               ml_get_cv_grid_states.m
%
%       o options   : struct,   plot options.
%   
%               options.title = 'title_figure';
%               options.param_names = ['C', 'sigma'];
%   
%   output ----------------------------------------------------------------
%
%       o handle : figure handle
%


if ~isfield(options,'title'),options.title = 'add a title in options.title'; end

title_name = options.title;
handle = figure('Color', [1 1 1]);
hold on;

[P, N] = size(stats.test.acc.mean');

if P > 1 && N > 1
           
        colormap hot; 
        x = options.param_ranges(2,:);
        y = options.param_ranges(1,:);
        
        subplot(1, 2, 1)  
        z = stats.train.acc.mean;
        contourf(x,y,z)        
        title('Train Mean Accuracy')        
        xlabel(options.param_names(2))
        ylabel(options.param_names(1))

        colorbar
        grid off
        axis square

        subplot(1, 2, 2)          
        z = stats.test.acc.mean;
        contourf(x,y,z)        
        title('Test Mean Accuracy')        
        xlabel(options.param_names(2))
        ylabel(options.param_names(1))
        colorbar
        grid off
        axis square
        
        suptitle(title_name)
               
else
    
        x_index = 1:1:length(stats.test.acc.mean);
        
        h1 = errorbar(x_index,stats.test.acc.mean,stats.test.acc.std,'-rs');
        h2 = errorbar(x_index,stats.train.acc.mean,stats.train.acc.std,'-gs');
        
        xlabel('Models','FontSize',14);
        ylabel('Evaluation metric','FontSize',14);
        hl = legend([h1,h2],'Test ACC','Train ACC');
        set(hl,'Location','SouthEast');
        title(title_name,'FontSize',16);
        box on; 
        grid on;

end


end

