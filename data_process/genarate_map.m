ax = [0 0.9];
ay = [0 0.9];
ant_h = 0.51;
tag_h = 0.14;
lambda = 0.32564;
grid_num = 1001;
tx = [-0.45 -0.3 -0.15 0 0.15 0.3 0.45 0.5 0.5 0.5 0.5 0.5 0.5 0.5];
ty = [0.4 0.4 0.4 0.4 0.4 0.4 0.4 0.45 0.6 0.75 0.9 1.05 1.2 1.35];
x = linspace(-0.5,0.5,grid_num);
y = linspace(0.4,1.4,grid_num);
phase_map = zeros(grid_num,grid_num,28);
for index_ant = 1:2
    for index_tag = 1:14
        for index_x = 1:grid_num
            for index_y = 1:grid_num
                dis_a = sqrt((x(index_x)-ax(index_ant))^2 + (y(index_y)-ay(index_ant))^2+ant_h^2);
                dis_t = sqrt((x(index_x)-tx(index_tag))^2 + (y(index_y)-ty(index_tag))^2+tag_h^2);
                phase = mod((dis_a + dis_t)*2*pi/lambda,2*pi);
                phase_map(index_x,index_y,(index_ant-1)*14+index_tag) = phase;
            end
        end
    end
end
heatmap(phase_map(:,:,1));
save phase_map.mat phase_map
