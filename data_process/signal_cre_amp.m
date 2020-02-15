function [signal] = signal_cre_amp(amp,phase)

        signal = amp.*exp(-1i.*phase);

end