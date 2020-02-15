global TESTNAME ENV OBJNUM HISLIST
    TESTNAME = 'test1';
    now_sig = GetSignal(TESTNAME);
    [Addx,Addy,Addmax,Addobj]=AddItem(now_sig);
    [Delnum,Delmax]=DelItem(now_sig);
    [Movx,Movy,Movnum,Movmax,Movobj]=MovItem(now_sig);
    if(Addmax>Delmax && Addmax>Movmax)
        OBJNUM = OBJNUM + 1;
        HISLIST(OBJNUM).obj = Addobj;
        HISLIST(OBJNUM).env = now_sig;
        HISLIST(OBJNUM).pos = [Addx Addy];
    end
    if(Delmax>Addmax && Delmax>Movmax)
        OBJNUM = OBJNUM - 1;
        HISLIST(Delnum)='';
        if(Delnum == 1)
            env = ENV;
        else
            env = HISLIST(Delnum-1).env;
        end
        for index_item = Delnum:OBJNUM
            env = env + HISLIST(Delnum).obj;
            HISLIST(Delnum).env = env;
        end
    end
    if(Movmax>Delmax && Movmax>Addmax)
        HISLIST(Movnum).pos=[Movx Movy];
        HISLIST(Movnum).obj=Movobj;
        if(Movnum == 1)
            env = ENV;
        else
            env = HISLIST(Movnum-1).env;
        end
        for index_item = Movnum:OBJNUM
            env = env + HISLIST(Movnum).obj;
            HISLIST(Movnum).env = env;
        end
    end