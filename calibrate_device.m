function h_device = calibrate_device(ref_obj_signal)
global SIG_REF
    h_device = ref_obj_signal./SIG_REF;
%     phase = angle(ref_obj_signal);
end