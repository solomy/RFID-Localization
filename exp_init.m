function exp_init

    global TAGNAME ANTNAME DATE ...
        FREQUENCIES SPEED_OF_LIGHT LAMBDAS ...
        ANT_NUM TAG_NUM EXP_NUM OBJ_NUM MATERIAL_NUM DERECT_NUM ISNAFANG

    ANT_NUM = 2;      %1根天线
    TAG_NUM = 14;     %7个tag
    EXP_NUM = 5;
    OBJ_NUM = 12;
    MATERIAL_NUM = 3; 
    DERECT_NUM = 4;
    ISNAFANG = 2;
%     TAGNAME =
%     {'01520360EE0B';'01530360EE03';'01540360EE0C';'01720360EDD9';'01560360EDF9';'01570360EDF1';'01580360EDFA'};%7tag
TAGNAME = {'01590360EDF2';'01600360EDFB';'01630360EDF4';'01640360EDE9';'01680360EDEB';'01690360EDE3';'01710360EDE4';
               '02020350ED3D';'02010350ED38';'02000350ED30';'01990350ED37';'01930350ED28';'01920350ED20';'01910350ED27'};
    ANTNAME = {'ant1','ant2'};
    DATE = 'D:/document/MATLAB/RFID/2019-03-26';

    global PAX PAY PTX PTY  X_REF Y_REF ANT_HEI TAG_HEI PHASE_REF RSSI_REF SIG_REF GRID_NUM GRID_X GRID_Y
 
    FREQUENCIES = 920.625e6;
    SPEED_OF_LIGHT = 299792458;
    LAMBDAS = SPEED_OF_LIGHT/FREQUENCIES;

    %% 天线tag位置信息
    X_REF = 0;
    Y_REF = 0.8;
    ANT_HEI = 0.4; %天线高度
    TAG_HEI = 0.15; %tag高度

    PAX = [0 0.9];
    PAY = [0 0.9];
    PTX = [-0.45 -0.3 -0.15 0 0.15 0.3 0.45 0.5 0.5 0.5 0.5 0.5 0.5 0.5];
    PTY = [0.4 0.4 0.4 0.4 0.4 0.4 0.4 0.45 0.6 0.75 0.9 1.05 1.2 1.35 ];
%% 计算参考点的相位理论值
    dis_a = sqrt((X_REF-PAX).^2 + (Y_REF-PAY).^2+ANT_HEI^2);
    dis_t = sqrt((X_REF-PTX).^2 + (Y_REF-PTY).^2+TAG_HEI^2);
    dis_a = repmat(reshape(dis_a,ANT_NUM,1),1,TAG_NUM);
    dis_t = repmat(reshape(dis_t,1,TAG_NUM),ANT_NUM,1);
    PHASE_REF = mod((dis_a + dis_t).*2.*pi./LAMBDAS,2*pi);
    RSSI_REF = 1./(dis_a.^2.*dis_t.^2);
    SIG_REF = RSSI_REF.*exp(1i*PHASE_REF);
    %% 网格信息设置
    GRID_NUM = 101;
    GRID_X = linspace(-0.5,0.5,GRID_NUM);
    GRID_Y = linspace(0.4,1.4,GRID_NUM);
end