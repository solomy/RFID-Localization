function file_init()
global TESTNAME ENVNAME REFNAME ENV HDEVICE ...
    OBJNUM HISLIST 
    ENVNAME = 'env';   
    REFNAME = 'reference1';
    TESTNAME = 'test1';
    ENV = GetSignal(ENVNAME);
    ref_signal = GetSignal(REFNAME);
    ref_obj = ref_signal - ENV;
    HDEVICE = calibrate_device(ref_obj);
    %% init some value
    OBJNUM = 0;
    HISLIST = '';
end