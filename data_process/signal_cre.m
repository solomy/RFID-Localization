function [signal,amp] = signal_cre(phase,rssi)
        % amp(t) = 10^sqrt((rssi(t)+100)/1000);
    	amp = 10.^(rssi./10);
        signal = amp.*exp(-1i.*phase);
end