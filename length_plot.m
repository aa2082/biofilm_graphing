function length_plot(x1,y1,z1,x2,y2,z2,lengths)
    % quiver3
    subplot(1,1,1)
    % You can find out the indices of the cells whose center of mass has height less than 2um by the following command:
    % https://stackoverflow.com/questions/29632430/quiver3-arrow-color-corresponding-to-magnitude
    % You can plot all such cells with stick representation and different color by the following command:
    %q = quiver3(cells(:,4), cells(:,5), cells(:,6), cells(:,7)-cells(:,4), cells(:,8)-cells(:,5), cells(:,9)-cells(:,6));
    q = quiver3(x1,y1,z1,x2-x1,y2-y1,z2-z1,'b', 'ShowArrowHead','off', 'Autoscale','off');
    
    %// Get the current colormap
    
    colormap default
    caxis([floor(min(lengths)) ceil(max(lengths))])
    currentColormap = colormap(gca);
    
    %// Now determine the color to make each arrow using a colormap
    [~, ~, ind] = histcounts(lengths, size(currentColormap, 1));
    
    %// Now map this to a colormap to get RGB
    cmap = uint8(ind2rgb(ind(:), currentColormap) * 255);
    cmap(:,:,4) = 255;
    cmap = permute(repmat(cmap, [1 3 1]), [2 1 3]);
    
    %// We repeat each color 2 times (using 1:2 below) because each tail has 2 vertices
    set(q.Tail, ...
        'ColorBinding', 'interpolated', ...
        'ColorData', reshape(cmap(1:2,:,:), [], 4).');
    h1 = colorbar;
    h1.Label.String = 'cell length';
end