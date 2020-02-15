function [pos_x,pos_y] = plot_single()

   % ���������Ƕ����߶�tag����£��Լ�����λ�ã��ļ�����Ҫ����ʱ��
   % ��tag���Ʒ������飬���б�ǩ���ݴ���֧��'/epc2015 ' tagname(i) ' DDD9 0140 0000 0000'
   % ���͵ı�ǩ
    %% �ļ�������
    setenv('OMP_NUM_THREADS', '8');

    tagname = {'01520360EE0B';'01530360EE03';'01540360EE0C';'01720360EDD9';'01560360EDF9';'01570360EDF1';'01580360EDFA';
        '01590360EDF2';'01600360EDFB';'01630360EDF4';'01640360EDE9';'01680360EDEB';'01690360EDE3';'01710360EDE4'};
    antname = {'ant1','ant2'};
    date = 'D:\Documents\MATLAB\RFID\����\2018-07-15';
    testname = 'cz1';
    envname = 'env';   
%     testname = 'cardboard1';
%     envname = 'cardboardenv';  
%     date = 'D:\Documents\MATLAB\RFID\2018-05-16';
%     testname = 'exp1';
%     envname = 'env1'; 

    %% ʵ�������ʼ��
    single_init();
    global M F debug_opt mean_delta_amp
    mean_delta_amp = zeros(1,28);
    debug_opt = 0;
    %% �źŲ���
    leastlen = 1000;
    o_signal = cell(F,M);
    for i=1:F
        for j=1:M
%             envpath = [date '/' envname '/epc2015 ' tagname{i} ' DDD9 0140 0000 0000' antname{j} '.dat'];
%             filepath = [date '/' testname '/epc2015 ' tagname{i} ' DDD9 0140 0000 0000' antname{j} '.dat'];
            envpath = [date '/' envname '/epcE2000016380D' tagname{i} '' antname{j} '.dat'];
            filepath = [date '/' testname '/epcE2000016380D' tagname{i} '' antname{j} '.dat'];
            [~,o_signal{i,j}] = get_obj_signal(envpath,filepath);
            if length(o_signal{i,j}) < leastlen
                leastlen = length(o_signal{i,j});
            end
        end
    end
    
    for i = 1:F
        for j = 1:M
            id = leastlen+1:length(o_signal{i,j});
            o_signal{i,j}(id) = [];
        end
    end
    mat_signal =  reshape(cell2mat(o_signal),F,leastlen,M);
    global PHASE0 X0 Y0
    PHASE0 = squeeze(angle(mat_signal(:,1,:))).';
%% ��������Ѱ�����λ��
    pos_x = zeros(leastlen,1);
    pos_y = zeros(leastlen,1);
    X_NOW = X0;
    Y_NOW = Y0;
    figure;
    for i = 1:leastlen %��i��ʱ�̣�ÿ��ʱ��1s��
        sig_sample = mat_signal(:,i,:);
        sig_sample = squeeze(sig_sample).';
        [X_NOW,Y_NOW] = single_pos(sig_sample,X_NOW,Y_NOW);
        pos_x(i,:) = X_NOW;
        pos_y(i,:) = Y_NOW;
        plot(pos_x(i),pos_y(i),'bo');
%         pause(0.1);
        xlim([-0.5 0.7]);
        ylim([0 2]);
        hold on;
    end
end