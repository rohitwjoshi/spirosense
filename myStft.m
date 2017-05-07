function  [bigs,sampling,time] = myStft(x, fs)

%Fourier Analysis of Audio Recording of Fluidic Oscillator
%[x,fs] = audioread(fileName);
T = 1/fs;
L = length(x); %Length of signal
wlen = 4410;
h = 220;
%test nfft (number of fft points);recommended to be power of 2
nfft = 65536;
%%original signal
t = (0:L-1)*T;

%%fft
n = 2^nextpow2(L); %next power of 2 from Length of transform
y = fft(x,n)/L; %Fast Fourier Transform
f = fs/2*linspace(0,1,n/2+1);
%y1 = filter(FIR_Hamming,y);


[maxValue, indexMax] = max(abs(y));
frequency = indexMax * fs/n;%should be /m?
%plot(f,2*abs(y(1:n/2+1)))
%depends on file data
%axis([0 300  0 5e-4]);

[maxval,index] = max(2*abs(y(1:n/2+1)));
f(index);


%%from STFT on file exchange; example.m
signal = x(:,1);
[s,f,t] = stft(signal,wlen,h,nfft,fs);
K = sum(hamming(wlen,'periodic'))/wlen;
s = abs(s)/1024/K;
% correction of the DC & Nyquist component
if rem(nfft, 2)                     % odd nfft excludes Nyquist point
    s(2:end, :) = s(2:end, :).*2;
else                                % even nfft includes Nyquist point%
    s(2:end-1, :) = s(2:end-1, :).*2;
end
s = log(s);
%s = s.^.8;

%figure
%imagesc(t,f,s);
set(gca, 'YDir', 'normal');

s1 = s(1:350,:); %checks the lowst 350 frequencies, not all 32k
Z = size(s1);
numRows = Z(1);
numCols = Z(2);
bigs = zeros(1,numCols);
for col=1:numCols 
    max1 = max(s1(:,col));
    for i=1:numRows
        if(s1(i,col)==max1)
            bigs(col)=f(i);
        elseif (s1(i,col)<-10)
            bigs(col) = 0;
        end
    end
end

hold on;

if(length(bigs)>length(t))
    bigs = bigs(:,1:end-1);
end

%removes spikes
for count=1:numCols-1
        if(bigs(count)==0 && bigs(count+1)>50)
            bigs(count+1) = 0;
        end
end


title('Frequency vs. time');
xlabel('Time(s)');
ylabel('Frequency(hz)');
axis([0 max(t) 0 400]);
%plot(t,bigs,'r-');

%figure
%plot(t,bigs,'b-');
%axis([0 max(t) 0 400]);
%smooth = tsmovavg(bigs,'s',40,2);
%hold on;
%plot(t,smooth,'r-');

%bigs = smooth(1,40:length(smooth));
sampling = fs;
time =  max(t);

end
