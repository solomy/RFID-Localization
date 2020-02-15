function [itemnum,maxvalue]=DelItem(now_sig)
    MAXVALUE = 1000000; 
    maxvalue = 0;
    itemnum = 0;                                    %此处初始化已考虑边界条件 OBJNUM = 0等                  
    global HISLIST ENV OBJNUM 
    
    for index_item=OBJNUM:-1:1
        if(index_item == 1)
            env = ENV;
        else
            env = HISLIST(index_item-1).env;
        end
        if(index_item == OBJNUM)
            if(ComSig(now_sig,env) == 1)
                itemnum = index_item;
                maxvalue = MAXVALUE;
                return;
            end
            break;
        end
        for index_env = index_item+1:OBJNUM - 1 
            env = env + HISLIST(index_env).obj;
        end
        test_obj = now_sig - env;
        [~,~,maxv] = compare_vector(test_obj);
        if(maxv > maxvalue)
            maxvalue = maxv;
            itemnum = index_item;
        end
    end

%% HISLIST需要在主程序更新
%     OBJNUM = OBJNUM - 1;
%     HISLIST(itemnum)='';
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