function [mean_phase,mean_rssi] = meandata(filename)
	%% 读取数据
	[~,phase,rssi,time,~] = readtagdata(filename);
    count = length(phase);
    %% 数据预处理
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    phase = phase_pre(phase,count);
    mean_phase = mean(phase);
    mean_rssi = mean(rssi);
end