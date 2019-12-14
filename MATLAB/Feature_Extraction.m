% close all;clear;clc;

[aud,fs] = audioread('left 10.m4a');

% Frequency domain analysis for whole signal
ts = 1/fs;
N = length(aud);
n = 2^nextpow2(N);
aud_fft = fft(aud,n);
P_aud_fft = abs(aud_fft/n);
f = fs*(0:(n/2))/n;
plot(f,P_aud_fft(1:n/2+1))

% short-time Fourier Transform
% spectrogram(aud)

%% NBIP computation
% [aud,fs] = audioread('left11.m4a');
% v_all = [];
% w = 9;
for w = 11:20
[aud,fs] = audioread(['left ',num2str(w),'.m4a']);
% [aud,fs] = audioread('right.m4a ');
ts = 1/fs;

% take frames 
frame_int = 0.1/ts;   % 20ms window  
frame_slide = 80;  % slide 1.814058956916 ms
frame_num = floor((length(aud)-frame_int)/(frame_slide));
frames = [];
for i = 1:(frame_num)
    frames = [frames;(aud(((i-1)*frame_slide+1):((i-1)*frame_slide+frame_int)))'];
end

% FFT
P = [];
for i = 1: frame_num
    N = length(frames(i,:));
    f = fs*(0:N/2)/N;
    frames_fft = fft(frames(i,:),N);
    mag_fft = abs(frames_fft);
    mag_fft = mag_fft(1:N/2+1);
    P = [P;20*log10((mag_fft).^2/fs/N)];
end

B = 20;
a = 0.3;
b = 18;
delta1 = a/b;
delta2 = (1-a)/(B-b);
df = fs/N;
v = zeros(frame_num,B);

for i = 1:frame_num
for k = 1:B
    if k<= b
        v(i,k) = sum(P(i,round((k-1)*delta1*fs/2/df+1): round(k*delta1*fs/2/df)))*df/fs*2;
    else
        starting = round((a+(k-b-1)*delta2)*fs/2/df+1);
        ending = round((a+(k-b)*delta2)*fs/2/df+1);
        v(i,k) = sum(P(i,starting:ending))*df/fs*2;
    end
end
end
save (['left',num2str(w),'.mat'],'v')
%     v_all = [v_all;v];
end
% output 
% save robusttest.mat v
% v = v(4500:end,:);
% save training4_2.mat v
% save training4.mat v_all

%% Detect tones

[aud,fs] = audioread('right 16.wav');
ts = 1/fs;

% take frames 
frame_int = 0.1/ts;   % 20ms window  
frame_slide = 80;  % slide 1.814058956916 ms
frame_num = floor((length(aud)-frame_int)/(frame_slide));
frames = [];
for i = 1:(frame_num)
    frames = [frames;(aud(((i-1)*frame_slide+1):((i-1)*frame_slide+frame_int)))'];
end

for i = 1: frame_num
    N = length(frames(i,:));
    f = fs*(0:N/2)/N;
    frames_fft = fft(frames(i,:),N);
    mag_fft = abs(frames_fft);
    mag_fft = mag_fft(1:N/2+1);
    plot(f,mag_fft)
    if mag_fft(101)>10
        index = i;
        break
    end
end

