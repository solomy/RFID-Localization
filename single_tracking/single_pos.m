function [ret_x,ret_y] = single_pos(r_signal,pos_x,pos_y)

global DOMAIN_X DOMAIN_Y M LAMBDAS F ...
        PAX PAY PTX PTY PHASE0 COM_PHASE0 ...
        LEN DELTAH1 DELTAH2

x_query = (pos_x+DOMAIN_X.start):DOMAIN_X.step:(pos_x+DOMAIN_X.end);
y_query = (pos_y+DOMAIN_Y.start):DOMAIN_Y.step:(pos_y+DOMAIN_Y.end);
x_space = repmat(reshape(x_query,1,LEN,1,1),M,1,LEN, F);
y_space = repmat(reshape(y_query,1,1,LEN,1),M,LEN,1, F);

Z_PAX = repmat(reshape(PAX,M,1,1,1),1,LEN, LEN,F);
Z_PAY = repmat(reshape(PAY,M,1,1,1),1,LEN, LEN,F);
Z_PTX = repmat(reshape(PTX,1,1,1,F),M,LEN, LEN,1);
Z_PTY = repmat(reshape(PTY,1,1,1,F),M,LEN, LEN,1);
Z_DW = sqrt((Z_PAX-pos_x).^2 + (Z_PAY-pos_y).^2 + DELTAH1^2) + sqrt((Z_PTX-pos_x).^2 + (Z_PTY-pos_y).^2 + DELTAH2^2 ); %距离权重
Z_DW = 1./Z_DW;
maxdw = max(max(Z_DW(:,1,1,:)));
Z_DW = Z_DW./maxdw; %归一化
Z_D = sqrt((Z_PAX-x_space).^2 + (Z_PAY-y_space).^2 + DELTAH1^2) + sqrt((Z_PTX-x_space).^2 + (Z_PTY-y_space).^2 + DELTAH2^2 );
phase = mod(2*pi/LAMBDAS.*Z_D,2*pi); 
r_phase = angle(r_signal);
z_rphase = repmat(reshape(r_phase,M,1,1,F),1,LEN,LEN,1);
z_comph0 = repmat(reshape(COM_PHASE0,M,1,1,F),1,LEN,LEN,1);
z_ph0 = repmat(reshape(PHASE0,M,1,1,F),1,LEN,LEN,1);
Z_phase = mod(phase - z_comph0,2*pi)-mod(z_rphase-z_ph0,2*pi);
Z_w = f_prob(min(abs(Z_phase),2*pi-abs(Z_phase))).*Z_DW;
Z_signal = Z_w.*exp(1j.*Z_phase);

% Z_abs1 = abs(squeeze(sum(sum(Z_signal(1,:,:,3:9),1), 4)));

Z_abs1 = abs(squeeze(sum(Z_signal(1,:,:,1:14), 4)));
Z_abs2 = abs(squeeze(sum(Z_signal(2,:,:,1:14), 4)));
Z_abs = Z_abs1 + Z_abs2;
[rows,cols] = find(Z_abs==max(max(Z_abs)));
% [~, I] = max(Z_abs);

ret_x = pos_x+DOMAIN_X.step*(rows-1)+DOMAIN_X.start;
ret_y = pos_y+DOMAIN_Y.step*(cols-1)+DOMAIN_Y.start;
end

function ret = f_prob(x)
    mean = 0;
    var = 0.4*sqrt(2);
    ret = 1/(var*sqrt(2*pi)).*exp(-(x-mean).^2./(2*var^2)); 
end
