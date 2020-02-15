function [pos_x,pos_y,maxvalue] = compare_vector(test_obj)
    load phase_map.mat phase_map 
    global ANT_NUM TAG_NUM GRID_NUM
    phase = angle(test_obj);
%     len1 = length(phase_map(:,1,1));
%     len2 = length(phase_map(1,:,1));
    phase = reshape(phase.',1,ANT_NUM*TAG_NUM);
    delta_map = zeros(GRID_NUM,GRID_NUM);
%     for i = 1:len1
%         for j = 1:len2
%             phase_m = reshape(phase_map(i,j,:),1,ANT_NUM*TAG_NUM);            
%             delta_phase = mod(phase - phase_m,2*pi);
%             delta_phase = abs(delta_phase);
%             id = find(delta_phase>pi);
%             delta_phase(id) = 2*pi - delta_phase(id); 
%             delta_phase = delta_phase - min(delta_phase);
%             sum_phase = sum(delta_phase);
%             delta_map(i,j) = sum_phase;
%         end
%     end
%     [x_value,x] = min(delta_map,[],1);
%     [y_value,y] = min(min(delta_map,[],1),[],2);
%     pos_x = x(y);
%     pos_y =  y;
    for i = 1:GRID_NUM
        for j = 1:GRID_NUM
            if(i == 72 && j == 40)
                reshape(phase_map(i,j,:),1,ANT_NUM*TAG_NUM)
                phase
            end
            phase_m = reshape(phase_map(i,j,:),1,ANT_NUM*TAG_NUM);            
            delta_phase = mod(phase - phase_m,2*pi);
            weight = f_prob(min(abs(delta_phase),2*pi-abs(delta_phase)));
            sum_sig = sum(weight.*exp(1i*delta_phase));
%             sum_sig = sum(exp(1i*delta_phase));
%             sum_sig = sum(weight);
            delta_map(i,j) = abs(sum_sig);
        end
    end
    maxvalue = max(max(delta_map));
    [x,y] = find(delta_map==max(max(delta_map)));
    x_grid = linspace(-0.5,0.5,GRID_NUM);
    y_grid = linspace(0.4,1.4,GRID_NUM);
    pos_x = x_grid(x);
    pos_y = y_grid(y);
%     figure(1);
%     plot(pos_x,pos_y,'*');
%     hold on;
%     heatmap(x_grid,y_grid,delta_map.','GridVisible','off');
end  
function ret = f_prob(x)
    mean = 0;
    var = 0.4*sqrt(2);
    ret = 1/(var*sqrt(2*pi)).*exp(-(x-mean).^2./(4*var^2)); 
end
