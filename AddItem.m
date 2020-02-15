function [pos_x,pos_y,maxvalue,test_obj]=AddItem(now_sig)
    global HISLIST ENV OBJNUM HDEVICE 
    if(OBJNUM == 0)
        test_obj = now_sig - ENV;
    else
        test_obj = now_sig - HISLIST(OBJNUM).env;
    end
    test_obj = test_obj./HDEVICE;
    [pos_x,pos_y,maxvalue] = compare_vector(test_obj);
%% HISLIST需要在主程序更新
%     OBJNUM = OBJNUM + 1;
%     HISLIST(OBJNUM).obj = test_obj;
%     HISLIST(OBJNUM).env = now_sig;
%     HISLIST(OBJNUM).pos = [pos_x pos_y];

end