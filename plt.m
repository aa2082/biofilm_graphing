classdef plt
    %PLT class that contains all plotting functions used to visualise
    %biofilm data
    methods (Static)
        function plot(x,y,z,dot_size,color_var, color_var_name, varargin)
            %plots each cell as a dot in 3d space colored according to
            %color_var
            figure
            scatter3(x,y,z,dot_size,color_var, 'filled');
            box on
            h1=colorbar;
            h1.Label.String = color_var_name;
            colormap(parula(10))
            caxis([floor(min(color_var)), ceil(max(color_var))]);
            cross_sec(varargin, nargin);
        end
    end
end
function cross_sec(var, nvar)
    %deals with all cross sections in above graphs
    global plot_range thickness i_cells;
    if nvar == 6
        axis(plot_range);
    elseif nvar == 8
        cut_dir = var{1};
        cut1 = var{2};
        cut2 = cut1+thickness;
        range = plot_range;
        title(['time = ' num2str(i_cells*.1) 'h - ' cut_dir ' cross section']);
        if cut_dir == 'X'
            range(1) = cut1;
            range(2) = cut2;
            view([-90 0])
        elseif cut_dir == 'Y'
            range(3) = cut1;
            range(4) = cut2;
            view([0 0])
        elseif cut_dir == 'Z'
            range(5) = cut1;
            range(6) = cut2;
            view([0 -90])
        else
            error("axis incorrect, can only be X, Y or Z");
        end
        axis(range);
        xlabel('X');
        ylabel('Y');
        zlabel('Z');
    end
end

