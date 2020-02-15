function [test_signal,env_signal,ref_signal] = get_signal()
% 0123增加插值操作
global TAGNAME ANTNAME DATE TESTNAME ...
        ANT_NUM TAG_NUM SIG_LEN DLT_TIME ENVDATA ENVNAME REFNAME
    DLT_TIME = 0.05;
    test_signal = zeros(ANT_NUM,TAG_NUM);
    env_signal = zeros(ANT_NUM,TAG_NUM);
    ref_signal = zeros(ANT_NUM,TAG_NUM);
    SIG_LEN = 1000000;
%     TESTNAME = 'material_direction010301';
    for index_ant=1:ANT_NUM
        for index_tag=1:TAG_NUM
            refpath = [DATE '/' REFNAME '/epcE2000016380D' TAGNAME{index_tag} '' ANTNAME{index_ant} '.dat'];
            envpath = [DATE '/' ENVNAME '/epcE2000016380D' TAGNAME{index_tag} '' ANTNAME{index_ant} '.dat'];
            testpath = [DATE '/' TESTNAME '/epcE2000016380D' TAGNAME{index_tag} '' ANTNAME{index_ant} '.dat'];
            [~,t_phase,t_rssi,t_time,~] = readtagdata(testpath);
            [t_phase,t_rssi] = preprocess(t_phase,t_rssi,t_time);

            [~,e_phase,e_rssi,e_time,~] = readtagdata(envpath);
            [e_phase,e_rssi] = preprocess(e_phase,e_rssi,e_time);

            [~,r_phase,r_rssi,r_time,~] = readtagdata(refpath);
            [r_phase,r_rssi] = preprocess(r_phase,r_rssi,r_time);
            ref_signal(index_ant,index_tag) = 10^(r_rssi/10)*exp(-1i.*r_phase);
            test_signal(index_ant,index_tag) = 10^(t_rssi/10)*exp(-1i.*t_phase);
            env_signal(index_ant,index_tag) = 10^(e_rssi/10)*exp(-1i.*e_phase);
        end
    end
end