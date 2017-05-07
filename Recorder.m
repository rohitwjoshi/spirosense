function [PEF,FEV1, FVC] = Recorder()
hold off;
h = waitbar(0, ' ');
mic = audiorecorder(44100,16,2,1);
%disp('Begin test in one second.')
waitbar(.2,h, 'Exhale Forcibly into the Device');

recordblocking(mic,6);
waitbar(.4, h);
%disp('Test has ended');
y = getaudiodata(mic);
waitbar(.6, h, 'Please wait, analyzing data');
right = y(:,1);
left = y(:,2);
audiowrite('both.wav', y, 44100);

audiowrite('right2.wav', right, 44100);
audiowrite('left2.wav', left, 44100);
waitbar(.8, h);
[db, fs] = WaveCombinatorial();
[answer, sampling, time]= myStft(db, fs);
waitbar(1, h);
[PEF,FEV1,FVC] = intoFrequency(answer, sampling, time);
close(h);
end