global ANT_NUM TAG_NUM GRID_NUM
load phase_map.mat phase_map 
init;
    for i = 1:GRID_NUM
        for j = 1:GRID_NUM
            phase_m = reshape(b(i,j,:),1,ANT_NUM*TAG_NUM);            
            weight = f_prob(min(abs(phase_m),2*pi-abs(phase_m)));
            sum_sig = sum(weight.*exp(1i*phase_m));
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
    
    heatmap(x_grid,y_grid,delta_map.','GridVisible','off');
    
    function ret = f_prob(x)
    mean = 0;
    var = 0.4*sqrt(2);
    ret = 1/(var*sqrt(2*pi)).*exp(-(x-mean).^2./(4*var^2)); 
end