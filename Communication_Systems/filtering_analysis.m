function filtering_analysis(x,fs)

    if size(x,2) == 2
        x = mean(x,2);
    end

    t = (0:length(x)-1)/fs;

    % Low pass
    fc_lp = 3e+3; % cutoff frequency (Hz)
    y_lp = lowpass(x,fc_lp,fs);

    % High pass
    fc_hp = 1e+3; % cutoff frequency (Hz)
    y_hp = highpass(x,fc_hp,fs);

    % Band pass
    fc1 = 5e+2;
    fc2 = 3e+3;
    y_bp = bandpass(x, [fc1 fc2], fs);

    figure;
    subplot(4,1,1); plot(t,x); title('Original Signal');
    subplot(4,1,2); plot(t,y_lp); title('Low-pass');
    subplot(4,1,3); plot(t,y_hp); title('High-pass');
    subplot(4,1,4); plot(t,y_bp); title('Band-pass');

    % Spectrum
    N = length(x);
    f = linspace(-fs/2, fs/2, N);

    X = fftshift(abs(fft(x)));
    Y_lp = fftshift(abs(fft(y_lp)));
    Y_hp = fftshift(abs(fft(y_hp)));
    Y_bp = fftshift(abs(fft(y_bp)));

    figure;
    subplot(4,1,1); plot(f,X); title('Original Spectrum');
    subplot(4,1,2); plot(t,Y_lp); title('Low-pass Spectrum');
    subplot(4,1,3); plot(t,Y_hp); title('High-pass Spectrum');
    subplot(4,1,4); plot(t,Y_bp); title('Band-pass Spectrum');

end    