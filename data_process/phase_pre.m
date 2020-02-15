function new_phase = phase_pre(phase,count)

    % 处理2π的跳变
    for i=2:count
        difph = phase(i)-phase(i-1);
        if(difph>5)
%         phase(i) = mod((phase(i)+pi),(2*pi));
            phase(i) = phase(i) - 2*pi;
        end
        if(difph<-5)
            phase(i) = phase(i) + 2*pi;
        end
    end
    phasesm = smooth (phase,5,'rlowess');
    %处理π的跳变
    new_phase = phase;
    for i=1:count
        difph = phase(i)-phasesm(i);
        if(difph>2.1) && (difph<4.2)
%         phase(i) = mod((phase(i)+pi),(2*pi));
            new_phase(i) = phase(i) - pi;
        end
        if(difph<-2.1) && (difph>-4.2)
            new_phase(i) = phase(i) + pi;
        end
    end
end