function signal = GetSignal(filename)
global TAGNAME ANTNAME DATE ANT_NUM TAG_NUM 
    signal = zeros(ANT_NUM,TAG_NUM);
    for index_ant=1:ANT_NUM
        for index_tag=1:TAG_NUM
            path = [DATE '/' filename '/epcE2000016380D' TAGNAME{index_tag} '' ANTNAME{index_ant} '.dat'];
            [~,phase,rssi,time,~] = readtagdata(path);
            [phase,rssi] = preprocess(phase,rssi,time);
            signal(index_ant,index_tag) = 10^(rssi/10)*exp(-1i.*phase);
        end
    end
end