function [int_time,obj_signal] = get_obj_rssi(envname,filename)
	%% 实验参数 
    dltt = 1;
    
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
    phase = smooth(phase,17,'rlowess');
    rssi = smooth (rssi,31,'rlowess');
%     figure;
%     plot(time,phase);
%     hold on;
%     plot(time,env_phase,':.g');
%     figure;
%     plot(time,rssi);
%     hold on;
%     plot(time,env_rssi,':.g');

    global D_NOW LAMBDAS meanrssi0 meanphase0
    k = 3;              %耗散系数
    signal = 10.^(rssi./10).*exp(-1i.*phase);
    signal0 = 10.^(meanrssi0./10).*exp(-1i.*meanphase0);
    obj_signal0 = signal0 - env_signal;
    obj_phase0 = angle(obj_signal0);
    obj_amp0 = abs(obj_signal0);
    for i = 1:1
        obj_signal = signal - env_signal;
        obj_phase = angle(obj_signal);
%         figure;
%         plot(time,abs(signal));
%         xlabel('time(s)');
%         ylabel('amplitude');
        if obj_phase(1) - obj_phase0 > pi
            obj_phase0 = obj_phase0 + pi;
        end
        if obj_phase(1) - obj_phase0 < -pi
            obj_phase0 = obj_phase0 - pi;
        end
        obj_phase = phase_link(obj_phase,count);
        dis = ((obj_phase-obj_phase0)./(2*pi/LAMBDAS) + D_NOW)/D_NOW;
        para = 1./dis.^k; %% 这里次方考虑要不要更改
        obj_amp = obj_amp0.*para;
        amp = abs(obj_amp.*exp(1i.*obj_phase) + env_signal);
        signal = amp.*exp(-1i.*phase);
%         figure;
%         plot(time,obj_amp);
%         xlabel('time(s)');
%         ylabel('amplitude');
    end
    obj_signal = signal - env_signal;
    
    %% 根据delta t 插值
    int_time = 0:dltt:finaltime;
    obj_signal = interp1(time,obj_signal,int_time);
%     count = length(int_time);
%     signal = interp1(time,signal,int_time);
%     obj_signal = signal - env_signal;
%     phase = interp1(time,phase,int_time);
%     rssi = interp1(time,rssi,int_time);
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
%     [signal,~] = signal_cre(phase,rssi,count);
%     obj_signal = signal - env_signal;
%     obj_phase = angle(obj_signal);
%     figure;
%     plot(int_time,obj_phase,'-');
end