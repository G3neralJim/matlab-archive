function stats = analyze_stereo_signal(x, fs)

    if size(x,2) ~= 2
        error('error')
    end

    channels = {'left_channel', 'right_channel'};
    T = 1/fs;
    N = size(x,1);

    for i = 1:2
        chan_data = x(:,i);

        % DC component
        stats(i).DC = mean(chan_data);

        % Energy
        stats(i).Energy = sum(abs(chan_data.^2))*T;

        % Average Power
        stats(i).Power = sum(abs(chan_data.^2))/N;

        % RMS
        stats(i).RMS = rms(chan_data);

        % PSD
        [pxx, f] = periodogram(chan_data, rectwin(N), N, fs);
        stats(i).PSD_freq = f;
        stats(i).PSD_val = pxx;

        % Plot
        
        fprintf('--- %s ---\n', channels{i});
        fprintf('DC: %.4f\n', stats(i).DC);
        fprintf('Energy: %.4f J\n', stats(i).Energy);
        fprintf('Average Power: %.4f W\n', stats(i).Power);
        fprintf('RMS: %.4f \n\n', stats(i).RMS);

        figure
        plot(stats(i).PSD_freq, stats(i).PSD_val);
        hold on
        plot(-stats(i).PSD_freq, stats(i).PSD_val);
        if i == 1
            title('1');
        else
            title('2')
        end
        
    end
end