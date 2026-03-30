function [f, left_spectrum, right_spectrum] = spectrum_of_stereo_signal(y,fs)
% 1. Separate Channels
left = y(:, 1);
right = y(:, 2);

% 2. FFT Parameters
n = length(left);
% Create frequency vector (0 to Nyquist frequency)
f = (0:n/2) * (fs/n); 

% 3. Compute FFT and derive the magnitude
% We multiply by 2/n to normalize the amplitude
left_fft = abs(fft(left)/n);
right_fft = abs(fft(right)/n);

% Single-sided spectrum (discard the second half)
left_spectrum = left_fft(1:floor(n/2)+1);
right_spectrum = right_fft(1:floor(n/2)+1);

% 5. Plotting
figure;


% Left Channel
subplot(2, 1, 1);
plot(f, left_spectrum, 'b');
hold on
plot(-f, left_spectrum, 'b');

grid on;

% Right Channel
subplot(2, 1, 2);
plot(f, right_spectrum, 'r');
hold on
plot(-f, right_spectrum, 'r');

grid on;
end