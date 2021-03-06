f_verticals_new = [];
colony_areas_new = [];
com_offset_new = [];
for i = 1:7
    I1=im2double(imread(sprintf('masks/new/%d_1.tif',i)));
    [row1,col1] = find(I1 == 1);

    I2=im2double(imread(sprintf('masks/new/%d_2.tif',i)));
    [row2,col2] = find(I2 == 1);

    colony_area = length(row1);
    f_vertical = length(row2)/length(row1);

    com_offset_new = [com_offset_new, sqrt((mean(row1) - mean(row2))^2 + (mean(col1) - mean(col2))^2)];
    f_verticals_new = [f_verticals_new, f_vertical];
    colony_areas_new = [colony_areas_new, colony_area];
end

f_verticals_old = [];
colony_areas_old = [];
com_offset_old = [];
for i = 1:7
    I1=im2double(imread(sprintf('masks/old/%d_1.tif',i)));
    [row1,col1] = find(I1 == 1);

    I2=im2double(imread(sprintf('masks/old/%d_2.tif',i)));
    [row2,col2] = find(I2 == 1);

    colony_area = length(row1);
    f_vertical = length(row2)/length(row1);

    com_offset_old = [com_offset_old, sqrt((mean(row1) - mean(row2))^2 + (mean(col1) - mean(col2))^2)];
    f_verticals_old = [f_verticals_old, f_vertical];
    colony_areas_old = [colony_areas_old, colony_area];
end

% h1 = histogram(com_offset_old,4);
% h1.BinWidth = 10;
% hold on
% h2 = histogram(com_offset_new,3);
% h2.BinWidth=10;

% subplot(1,2,1)
% boxplot(com_offset_old)
% title('old')
% ylim([0,150])
% subplot(1,2,2)
% boxplot(com_offset_new)
% ylim([0,150])
% title('new')

plot(colony_areas_old,f_verticals_old);
hold on
plot(colony_areas_new,f_verticals_new);
legend('old', 'agar-air')