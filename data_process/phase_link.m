function phase =phase_link(phase,count)
for i= 2:count
    while phase(i)-phase(i-1)<-2
        phase(i) = phase(i) + 2*pi;
    end
    while phase(i)-phase(i-1)>2
        phase(i) = phase(i) - 2*pi;
    end
end