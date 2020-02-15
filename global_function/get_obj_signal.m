function [int_time,obj_signal] = get_obj_signal(envname,filename)
	%% 实验参数 
    dltt = 0.2;
    
    %% 读取环境数据
	[env_phase,env_rssi] = meandata(envname);
	env_signal = 10^(env_rssi/10)*exp(-1i*env_phase);

	%% 读取数据
	[~,phase,rssi,time,~] = readtagdata(filename);
    count = length(phase);
    
    %% 数据预处理
    phase = phase_pre(phase,count);
%     global finaltime
%     finaltime = 36;
     finaltime = time(count);  
    %% smooth
%     figure;
%     plot(time,phase);    
%     figure;
%     plot(time,rssi);
    phase = smooth(phase,13,'rlowess');
    rssi = smooth (rssi,31,'rlowess');
    figure(7);
    hold on;
    plot(phase(1:300)-phase(1));
%     hold on;
%     plot(time,env_phase,':.g');
%     figure;
%     plot(time,rssi);
%     hold on;
%     plot(time,env_rssi,':.g');
    signal = 10.^(rssi./10).*exp(-1i.*phase);

    %% 根据delta t 插值
    int_time = 0:dltt:finaltime;
    count = length(int_time);
%     signal = interp1(time,signal,int_time);
%     signal = signal - signal(1);

% %     obj_signal = signal - env_signal;
% %     figure;
% %     plot(angle(obj_signal));

    %% plot test
%     figure;
%     plot(int_time,phase);
%     hold on;
%     plot(time,env_phase,':.g');
%     saveas(gcf,'2018-01-24/tag68phase.jpg');
%     figure;
%     plot(int_time,rssi);

%     saveas(gcf,'2018-01-24/tag68rssi.jpg');
    %% create signals
%     [signal,~] = signal_cre(phase,rssi);
global debug_opt mean_delta_amp
    debug_opt = debug_opt + 1;
    phase = interp1(time,phase,int_time);
    rssi = interp1(time,rssi,int_time);
    obj_signal = signal - env_signal;
    for ii = 1:count-1
        signal_delta(ii) = signal(ii+1)-signal(ii);
    end
    mean_delta_amp(debug_opt) = mean(abs(signal_delta));
%     for ii = 5:5:count-1
%         signal_delta(ii) = obj_signal(ii+1)./obj_signal(ii-4);
%     end
%     figure;
%     plot(angle(signal));
%     figure;
%     plot(angle(signal_delta));
%     figure;
%     plot(abs(signal_delta));
%     global meanphase0 meanrssi0
%     obj_signal(1) = 10.^(meanrssi0./10).*exp(-1i.*meanphase0) - env_signal;
%     obj_phase = angle(obj_signal);
%     obj_amp = abs(obj_signal);
%     figure;
%     plot(obj_phase,'-');
%     figure;
%     plot(obj_amp,'-');
end