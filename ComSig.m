function ret = ComSig(Siga,Sigb)
    global ANT_NUM TAG_NUM
    Thres = 0.1;
    diff = angle(Siga) - angle(Sigb);
    for index_ant=1:ANT_NUM
        for index_tag=1:TAG_NUM
            diff = abs(diff);
            diff = min(diff,2*pi-diff);
        end
    end
    DiffSum = sum(sum(diff));
    if DiffSum<Thres
        ret = 1;
    else
        ret = 0;
    end
end