function [PEF,FEV1, FVC] = intoFrequency(frequency, sampling, time)


flow = (frequency)./31.46;
fs = sampling;
maxT = time;
%flow = (frequency)./30;
flow = flow(1,:);
num = length(frequency);

vol = zeros(1,num);
t = (0:maxT/num:maxT-1/num);
vol(1)=0;
for i=2:num
    vol(i) = vol(i-1)+(flow(i)*maxT/num);
end


% And finally plot to the axes:
h = figure;%('Visible', 'off');
subplot(2,2,1);
hold on;
plot(t, flow);
title('Flow vs. Time');
axis([0 max(t) 0 10]);
xlabel('Time (s)');
ylabel('Flow rate (L/s)');

subplot (2,2,2);
plot(t,vol);
title('Vol vs. time');
ylabel('Vol (L)');
xlabel('Time (s)');
axis([0 max(t) 0 10]);


subplot(2,2,3:4);
plot(vol, flow,'b');
title('Flow vs. Volume loop');
xlabel('Vol (L)');
ylabel('Flow rate (L/s)');
axis([0 2*max(flow) 0 10]);
saveas(h, 'result.jpg');

PEF = max(flow);
FEV1 = vol(floor(num/time))
FVC = max(vol)
end