function [mean_phase,mean_rssi] = preprocess(phase,rssi,time)
    %% smooth
    phase = unwrap(phase);
    %Æ½»¬
%     phase = smooth(phase,19,'rlowess');
%     phase = medfilt1(phase,5);
    mean_phase = mean(phase);
    mean_rssi = mean(rssi);
%     rssi(:) = rssi2;

end