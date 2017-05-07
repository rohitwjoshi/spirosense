function [db2,fs2] = WaveCombinatorial()
%reading files, making the new .wav
[db1,fs1] = audioread('left2.wav');
[db2,fs2] = audioread('right2.wav');
t = (0:1/fs1:(length(db1)-1)/fs1);
db3 = db1-db2;
%audiowrite('sample.wav',db3,fs2);

%plotting the old functions
figure;
subplot(3,1,1);
plot (t,db1,'b-')
hold on;
plot (t,db2,'r-')
xlabel('Time (s)');
ylabel('Amplitude');
title('Exhalation Audio');

%plotting the wave :)
subplot(3,1,2);
plot (t,db3,'b-')
xlabel('Time (s)');
ylabel('Amplitude');
title('Exhalation Audio');




end