global PAX PAY PTX PTY GRID_X GRID_Y ANT_HEI TAG_HEI LAMBDAS GRID_NUM ANT_NUM TAG_NUM 
exp_init();

phase_map = zeros(GRID_NUM,GRID_NUM,28);
for index_ant = 1:ANT_NUM
    for index_tag = 1:TAG_NUM
        for index_x = 1:GRID_NUM
            for index_y = 1:GRID_NUM
                dis_a = sqrt((GRID_X(index_x)-PAX(index_ant))^2 + (GRID_Y(index_y)-PAY(index_ant))^2+ANT_HEI^2);
                dis_t = sqrt((GRID_X(index_x)-PTX(index_tag))^2 + (GRID_Y(index_y)-PTY(index_tag))^2+TAG_HEI^2);
                phase = mod((dis_a + dis_t)*2*pi/LAMBDAS,2*pi);
                phase_map(index_x,index_y,(index_ant-1)*TAG_NUM+index_tag) = phase;
            end
        end
    end
end
% heatmap(phase_map(:,:,1));
save phase_map.mat phase_map
