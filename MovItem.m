function [pos_x,pos_y,itemnum,maxvalue,test_obj]=MovItem(now_sig)
    pos_x = 0;
    pos_y = 0;
    test_obj = '';
    maxvalue = 0;
    itemnum = 0;                                    %�˴���ʼ���ѿ��Ǳ߽����� OBJNUM = 0��                  
    global HISLIST ENV OBJNUM HDEVICE
    
    for index_item=OBJNUM:-1:1
        if(index_item == 1)
            env = ENV;
        else
            env = HISLIST(index_item-1).env;
        end
        
        for index_env = index_item+1:OBJNUM - 1 
            env = env + HISLIST(index_env).obj;
        end
        test_obj = now_sig - env;
        test_obj = test_obj./HDEVICE;               %�����ƶ��൱��һ�������壬������Ҫ�����豸����λƫ��
        [x,y,maxv] = compare_vector(test_obj);
        if(maxv > maxvalue)
            maxvalue = maxv;
            itemnum = index_item;
            pos_x = x;
            pos_y = y;
        end
    end
%% HISLIST��Ҫ�����������
%     HISLIST(itemnum).pos=[pos_x pos_y];
%     HISLIST(itemnum).obj=test_obj;
%     if(itemnum == 1)
%             env = ENV;
%         else
%             env = HISLIST(itemnum-1).env;
%     end
%     for index_item = itemnum:OBJNUM
%         env = env + HISLIST(index_item).obj;
%         HISLIST(index_item).env = env;
%     end
end