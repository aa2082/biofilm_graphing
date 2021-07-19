classdef plt
    %PLT class that contains all plotting functions used to visualise
    %biofilm data
    methods (Static)
        function color_scatter(x,y,z,dot_size,color_var, color_var_name, varargin)
            %plots each cell as a dot in 3d space colored according to
            %color_var
            figure
            scatter3(x,y,z,dot_size,color_var, 'filled');
            box on
            h1=colorbar;
            h1.Label.String = color_var_name;
            colormap(parula)
            caxis([min(color_var) max(color_var)]);
            cross_sec(6, varargin, nargin);
        end
        function color_quiver(x1,y1,z1,x2,y2,z2,color_var, color_var_name, varargin)
            %plots each cell as a line in 3d space with the length of the
            %cel determined by the color of the line
            % quiver3
            subplot(1,1,1)
            % You can find out the indices of the cells whose center of mass has height less than 2um by the following command:
            % https://stackoverflow.com/questions/29632430/quiver3-arrow-color-corresponding-to-magnitude
            % You can plot all such cells with stick representation and different color by the following command:
            %q = quiver3(cells(:,4), cells(:,5), cells(:,6), cells(:,7)-cells(:,4), cells(:,8)-cells(:,5), cells(:,9)-cells(:,6));
            q = quiver3(x1,y1,z1,x2-x1,y2-y1,z2-z1,'b', 'ShowArrowHead','off', 'Autoscale','off');

            %// Get the current colormap

            colormap default
            caxis([min(color_var), max(color_var)])
            currentColormap = colormap(gca);

            %// Now determine the color to make each arrow using a colormap
            [~, ~, ind] = histcounts(color_var, size(currentColormap, 1));

            %// Now map this to a colormap to get RGB
            cmap = uint8(ind2rgb(ind(:), currentColormap) * 255);
            cmap(:,:,4) = 255;
            cmap = permute(repmat(cmap, [1 3 1]), [2 1 3]);

            %// We repeat each color 2 times (using 1:2 below) because each tail has 2 vertices
            set(q.Tail, ...
                'ColorBinding', 'interpolated', ...
                'ColorData', reshape(cmap(1:2,:,:), [], 4).');
            h1 = colorbar;
            h1.Label.String = color_var_name;
            cross_sec(8,varargin, nargin);
        end
    end
end
function cross_sec(number_of_var_no_cut,var, nvar)
    %deals with all cross sections in above graphs
    global plot_range thickness i_cells;
    if nvar == number_of_var_no_cut
        axis(plot_range);
    elseif nvar == number_of_var_no_cut + 2
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