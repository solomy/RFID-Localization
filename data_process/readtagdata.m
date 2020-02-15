function [tid,phase,rssi,time,antport] = readtagdata(filename)
    

%% file proc
    f=fopen(filename,'r');
    narginchk(1,1);
    data = fscanf(f,'%*s %lf %lf %lf %lf %*lf',[4,inf]);
    data = data';
    tid = filename;
    phase = data(:,1);
    rssi = data(:,2);
    time = data(:,3);
    antport = data(:,4);
    init_time = time(1);
%% change the unit of time
    time = (time-init_time)./1000000;
    fclose(f);
end