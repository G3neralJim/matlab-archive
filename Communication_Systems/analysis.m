%% Time and Frequency Analysis
clear;
clc;
close all;

%% --- 1. Parameters ---
fc = 5e+4;  % Carrier Frequency (50 kHz)

SNR_db = 20;    % Channel Noise
ka = 0.8;   % Modulation Indicator*
fm_max = 3e+3;  % Max information frequency (3 kHz)

disp('% --- 1. Parameters ---')
% fc
% SNR_db
% ka
% fm_max

%% --- 2. Message & Transmitter Filtering ---
filename = 'MOZART_40_D_Bay.mp3';
[m_raw, fs_audio] = audioread(filename);
t_audio = (0:length(m_raw)-1)'/fs_audio;
fprintf('Audio signal duration: %.2f s \n', t_audio(length(t_audio)));
fs = max(25e+4, fs_audio);  % Sampling Rate at least 5*fc
fprintf('Sampling Rate of audio signal: %.2f Hz \n', fs_audio);
fprintf('Sampling Rate in use: %.2f Hz \n', fs);
m_mono = resample(m_raw(:,1),fs,fs_audio);
t = (0:length(m_mono)-1)'/fs;
fprintf('Audio signal duration after resampling: %.2f s\n', t(length(t)));

disp('Audio file read')

%% --- Low pass filter for transmitter (restricting BW to 3kHz) ---
[b_tx, a_tx] = butter(6, fm_max/(fs/2));
m = filter(b_tx, a_tx, m_mono);
disp('Message passed through lowpass filter of type Butterworth');
m = m/max(abs(m));  % Normalize

%% --- 3. AM Modulation ---
s_am = (1 + ka*m) .* cos(2*pi*fc*t);
disp('Signal has been modulated on transmitter side')

%% --- 4. Channel (AWGN) ---
r = awgn(s_am, SNR_db, 'measured');
disp('Message received by the receiver')

%% --- 5. De-modulation ---
% A. Synchronous Detector (Coherent)
disp('------------------------------------');
s_prod = r .* cos(2*pi*fc*t); % Multiply received message with reference signal
[b_lp, a_lp] = butter(6, fm_max/(fs/2)); % Receiver filter
m_coherent = filter(b_lp, a_lp, s_prod);
m_coherent = m_coherent*2;

m_coherent = m_coherent - mean(m_coherent);

% B. Perivalousa* Detector (Envelope)
% Simulation with absolute value (rectification) and filter

disp('------------------------------------')
s_rect = abs(r);
[b_env, a_env] = butter(6, fm_max/(fs/2));
m_envelope = filter(b_env, a_env, s_rect);
m_envelope = (m_envelope - mean(m_envelope)) / ka;


