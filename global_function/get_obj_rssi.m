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
    smphase = smooth(phase,51,'rlowess');
%     figure;
%     plot(time,phase);
%     hold on;
%     plot(time,env_phase,':.g');
%     figure;
%     plot(time,rssi);
%     hold on;
%     plot(time,env_rssi,':.g');
%% 求波峰波谷
    fff = zeros(count,1); %表示求根公式的正负号
    if min(smphase)> env_phase 
        env_phase = env_phase + 2*pi;
    end
    if max(smphase)< env_phase 
        env_phase = env_phase - 2*pi;
    end
    flag = 1;
    for i= 2:count
        if (smphase(i) > env_phase) && (smphase(i-1) < env_phase)
            [~,loc] = min(smphase(flag:i));
            loc = flag + loc - 1;
            fff(flag:loc) = 1;
            fff(loc:i) = -1;
            flag = i;
        end
        if (smphase(i) < env_phase) && (smphase(i-1) > env_phase)
            [~,loc] = max(smphase(flag:i));
            loc = flag + loc - 1;
            fff(flag:loc) = -1;
            fff(loc:i) = 1;
            flag = i;
        end
        if i == count
            if smphase(i) < env_phase
                [~,loc] = min(smphase(flag:i));
                loc = flag + loc - 1;
                fff(flag:loc) = 1;
                fff(loc:i) = -1;
            end
            if smphase(i) > env_phase
                [~,loc] = max(smphase(flag:i));
                loc = flag + loc - 1;
                fff(flag:loc) = -1;
                fff(loc:i) = 1;
            end
        end
            
    end



    global D_NOW LAMBDAS meanrssi0 meanphase0
    k = 5;              %耗散系数
    env_amp = 10.^(env_rssi./10);
    signal = 10.^(rssi./10).*exp(-1i.*phase);
    signal0 = 10.^(meanrssi0./10).*exp(-1i.*meanphase0);
    obj_signal0 = signal0 - env_signal;
    obj_phase0 = angle(obj_signal0);
    obj_amp0 = abs(obj_signal0);
    for i = 1:3
        obj_signal = signal - env_signal;
        obj_phase = angle(obj_signal);
        obj_amp = abs(obj_signal);
%         figure;
%         plot(time,obj_amp,'Linewidth',5);
%         title('the measured amplitude','fontsize',40),ylabel('amplitude','fontsize',40),xlabel('time/s','fontsize',40);
%         set(gca,'fontsize',40,'Linewidth',5);
%         figure;
%         plot(time,abs(signal));
%         xlabel('time(s)');
%         ylabel('amplitude');
        obj_phase = phase_link(obj_phase,count);
        dis = ((obj_phase-obj_phase0)./(2*pi/LAMBDAS) + D_NOW)/D_NOW;
        para = 1./dis.^k; %% 这里次方考虑要不要更改
        co = polyfit(para,obj_amp,1); %拟合求系数
        obj_amp = co(1).*para + co(2);
%         figure;
%         plot(time,obj_amp,'Linewidth',5);
%         title('the amplitude calculated by the distance','fontsize',40),ylabel('amplitude','fontsize',40),xlabel('time/s','fontsize',40);
%         set(gca,'fontsize',40,'Linewidth',5);
%         obj_amp = obj_amp0.*para;
        amp = abs(obj_amp.*exp(1i.*obj_phase) + env_signal);
        signal = amp.*exp(-1i.*phase);
    end
%     figure
%     plot(amp)
%     hold on;
%     plot(1:count,env_amp,'.g');
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