function correlation_analysis(x,fs)

    if size(x,2) == 2
        % stereo
        left = x(:,1);
        right = x(:,2);
    else
        % mono
        left = x;
        right = x;
    end

    N = length(left);
    lags = (-N+1:N-1)/fs;

    % Autocorrelation
    auto_corr = xcorr(left, 'coeff');

    figure;
    plot(lags,auto_corr);
    title('Auto-correlation');

    % Cross-correlation
    cross_corr = xcorr(left, right, 'coeff');
    
    figure;
    plot(lags,cross_corr);
    title('Cross-correlation L-R');

    % Max lag
    [~, idx] = max(cross_corr);
    delay = lags(idx);
    fprintf('Max lag = %.6f', delay);
    

