function single_init
%% physical
% LAMBDA: wavelength of the signal;
% FREQUENCY: frequency of the signal;
% M: antenna array size;
% L: # propagation paths;
% D: spacing between adjacent rx antenna
% N: # sample
% F: # measured subcarrier
% DELTA_FREQUENCY: difference between adjacent subcarrier
    global SPEED_OF_LIGHT M L ITERATION  ...
        DOMAIN_X DOMAIN_Y F  FREQUENCIES LAMBDAS ...
        PAX PAY PTX PTY C_PAX C_PAY C_PTX C_PTY COM_PHASE0 X0 Y0 ...
        LEN DELTAH1 DELTAH2 C_D
 
    FREQUENCIES = 920.625e6;
    SPEED_OF_LIGHT = 299792458;
    LAMBDAS = SPEED_OF_LIGHT/FREQUENCIES;

    M = 2;      %2根天线
    L = 1;      %1个位置
    F = 14;     %14个tag
    ITERATION = 1;
    DOMAIN_X = struct('start', -0.2, 'end', 0.2, 'step', 0.001); % unit: m
    DOMAIN_Y = struct('start', -0.2, 'end', 0.2, 'step', 0.001); % unit: m
    LEN = round((DOMAIN_X.end - DOMAIN_X.start) ...
        / DOMAIN_X.step + 1);
    %% 天线tag位置信息

    X0 = 0;
    Y0 = 0.85;
    DELTAH1 = 0.59; %高度暂时设置为0.2，根据实验更改 
    DELTAH2 = 0.08;
    C_X0 = repmat(X0, M, F); %#ok<REPMAT>
    C_Y0 = repmat(Y0, M, F);
%     PAX = [0 1.6].';
%     PAY = [0 1.6].';
%     PTX = [-0.45 -0.3 -0.15 0 0.15 0.3 0.45 0.8 0.8 0.8 0.8 0.8 0.8 0.8];
%     PTY = [0.8 0.8 0.8 0.8 0.8 0.8 0.8 1.15 1.3 1.45 1.6 1.75 1.8 1.95];
% 
%     PAX = [0 1.1].';
%     PAY = [0 1].';
%     PTX = [-0.45 -0.3 -0.15 0 0.15 0.3 0.45 0.8 0.8 0.8 0.8 0.8 0.8 0.8];
%     PTY = [0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.55 0.7 0.85 1 1.15 1.3 1.45];

% 直线参数
    PAX = [0 1.3].';
    PAY = [0 1.3].';
    PTX = [-0.45 -0.3 -0.15 0 0.15 0.3 0.45 0.6 0.6 0.6 0.6 0.6 0.6 0.6];
    PTY = [0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.75 0.9 1.05 1.2 1.35 1.5 1.65];

    PTX = reshape(PTX,1,F);
    PTY = reshape(PTY,1,F);
    C_PAX = repmat(PAX, 1,  F);
    C_PAY = repmat(PAY, 1,  F);
    C_PTX = repmat(PTX, M,  1);
    C_PTY = repmat(PTY, M,  1);       

    C_D = sqrt((C_PAX-C_X0).^2 + (C_PAY-C_Y0).^2 + DELTAH1^2) + sqrt((C_PTX-C_X0).^2 + (C_PTY-C_Y0).^2 + DELTAH2^2);
    COM_PHASE0 = mod(2*pi/LAMBDAS.*C_D,2*pi);

end