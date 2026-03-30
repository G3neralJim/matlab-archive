function [t,fs,y] = plotmp3waveform(filename)
% 1. Read the MP3 file
[y, fs] = audioread(filename); %If the MP3 is stereo, y will be an N×2

% 2. Create a time vector in seconds
    t = (0:length(y)-1) / fs;

% 3. Plot the waveform
    figure;
    plot(t, y);
 
    title('Audio Waveform');
    grid on;
end