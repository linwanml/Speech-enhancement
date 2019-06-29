clc;
clear all;
close all;

[s1 fs] = audioread('clean_speech.wav');
[n_bouble f] = audioread('babble_noise.wav');
[n_shaped f] = audioread('Speech_shaped_noise.wav');
y_shaped = s1 + 0.3*n_shaped(1:length(s1));
y_babble = s1 + 0.3*n_bouble(1:length(s1));
y = awgn(s1,20,'measured');
y = y_shaped;

% frame length is often in the range 10-30ms 
frame_length = 20*1e-3 * fs; % 20ms / 320samples

% hop length is typically 25 - 75% of the frame length
hop_length = 0.5 * frame_length; % 50% 

%% framing
% calculate the number of frames
ans = (length(y)-hop_length)/(frame_length-hop_length);
num_frame = floor(ans)+1;

% segment
y_t = segment(y, frame_length, hop_length);

%% hann window + fft
% apply the window, hanning window, and transfrom
window = hann(frame_length);
y_k = zeros(size(y_t));
for idx = 1 : num_frame
    y_k(:, idx) = fft(window .* y_t(:, idx));
end

%% noisy speech PSD estimator Pyy
% noisy signal PSD estimation using Bartlett Method
L = 12; % number of periodogram segement 
Pyy = Bartlett(y_k,L);

%% noise PSD estimator Pnn
% (Minimum statistic)
% or MMSE?
M = 12; % num of segements
B = 1; % bias compensation
Pnn = Min_Statistics(Pyy,M,B);
%Pnn = MMSE_noise(Pyy);


%% SNR estimation
% ML and DD
SNR_ml = snr_ml(Pyy,Pnn);

alpha = 0.8;
SNR_dd = snr_dd(Pyy,Pnn,alpha);

%% Gain function
% Wiener and PSS
% Wiener
s_k_wiener = wiener(y_k,SNR_ml);

threshold = 0.05;
s_k_pss = subtraction(Pyy,Pnn,y_k,threshold);
%% ifft
s_t_wiener = ifft(s_k_wiener);

s_t_pss = ifft(s_k_pss);
%% overlap add
s_wiener = overlap_add(s_t_wiener, frame_length, hop_length);
s_wiener = real(s_wiener);

s_pss = overlap_add(s_t_pss, frame_length, hop_length);
s_pss = real(s_pss);

%% plot and listening test wiener
% time domian
%audiowrite('./results/filtered.wav', s_wiener, f);
figure();
plot(y);
hold on;
plot(s_wiener)
xlabel('sample')
ylabel('amplitude')
title('Time domain performance');
legend('original', 'filtered');

figure;
subplot(311);
spectrogram(s1(20000:100000),window,hop_length,frame_length,fs,'yaxis');colormap;
title('clean speech');
subplot(312);
spectrogram(y(20000:100000),window,hop_length,frame_length,fs,'yaxis');colormap;
title('noisy speech');
subplot(313);
spectrogram(s_wiener(20000:100000),window,hop_length,frame_length,fs,'yaxis');colormap;
title('filtered speech');
% listening test
compare = zeros(1,140000);
compare(1:70000)=y(1:70000);
compare(70001:140000)=s_wiener(1:70000);
soundsc(compare,fs);


%% plot and listening test pss
% % time domian
% figure();
% plot(y);
% hold on;
% plot(s_pss)
% xlabel('sample')
% ylabel('amplitude')
% title('Time domain performance');
% legend('original', 'filtered');
% figure;
% subplot(311);
% spectrogram(s1(20000:100000),window,hop_length,frame_length,fs,'yaxis');colormap;
% title('clean speech');
% subplot(312);
% spectrogram(y(20000:100000),window,hop_length,frame_length,fs,'yaxis');colormap;
% title('noisy speech');
% subplot(313);
% spectrogram(s_pss(20000:100000),window,hop_length,frame_length,fs,'yaxis');colormap;
% title('filtered speech');
% % listening test
% compare = zeros(1,140000);
% compare(1:70000)=y(1:70000);
% compare(70001:140000)=s_pss(1:70000);
% soundsc(compare,fs);
% 













