function [pos_x,pos_y,maxvalue] = test()

   % 本函数考虑多天线多tag情况下，自己设置位置，文件名需要大量时间
   % 将tag名称放入数组，进行标签数据处理，支持'/epc2015 ' tagname(i) ' DDD9 0140 0000 0000'
   % 类型的标签
    %% 文件名参数
    setenv('OMP_NUM_THREADS', '8');
    global TESTNAME ENVNAME REFNAME ANT_NUM TAG_NUM debug_opt mean_delta_amp
%     tagname = {'01590360EDF2';'01600360EDFB';'01630360EDF4';'01640360EDE9';'01680360EDEB';'01690360EDE3';'01710360EDE4';
%                '02020350ED3D';'02010350ED38';'02000350ED30';'01990350ED37';'01930350ED28';'01920350ED20';'01910350ED27'};
%     antname = {'ant1','ant2'};
%     date = 'D:\Documents\MATLAB\RFID\材质\2018-07-15';
    TESTNAME = 'test1';
    ENVNAME = 'env';   
    REFNAME = 'reference1';

    %% 实验参数初始化
    exp_init();
    [test_signal,env_signal,ref_signal]=get_signal();
    test_obj = test_signal-env_signal;
    ref_obj = ref_signal-env_signal;
    h_device = calibrate_device(ref_obj);
    test_obj = test_obj./h_device;
    [pos_x,pos_y,maxvalue] = compare_vector(test_obj);

end