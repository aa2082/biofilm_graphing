function scatter_plot(cut_dir,cut1,color_label)
    global x y z c i_cells thickness dot_size plot_range;
    figure
    scatter3(x,y,z,dot_size,c, 'filled');
    cut2 = cut1+thickness;
    range = plot_range;   
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
    box on
    h1=colorbar;
    h1.Label.String = color_label;
    colormap(parula(10))
    caxis([0, ceil(max(c))]);
    title(['time = ' num2str(i_cells*.1) 'h - ' cut_dir ' cross section']);
end