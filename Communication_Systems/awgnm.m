function y = awgnm(x, snr_db, varargin)

    %% WARNING! Funtion was generated!

    % Manual implementation of awgn with 'measured' option support
    % x: input signal
    % snr_db: signal-to-noise ratio in decibels
    % varargin: optional 'measured' flag
    
    % Check for 'measured' option
    if nargin > 2 && strcmp(varargin{1}, 'measured')
        % Use actual measured power of the signal
        signal_power = mean(abs(x).^2);
    else
        % Assume unit power signal
        signal_power = 1;
    end
    
    % Convert SNR from dB to linear scale
    snr_linear = 10^(snr_db / 10);
    
    % Calculate noise power needed
    noise_power = signal_power / snr_linear;
    
    % Generate Gaussian noise
    noise = sqrt(noise_power) * randn(size(x));
    
    % Add noise to signal
    y = x + noise;
end
