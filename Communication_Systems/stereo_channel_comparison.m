function stereo_channel_comparison(x,fs)

    if size(x,2) ~= 2
        error('error')
    end

    left = x(:, 1);
    right = x(:, 2);

    t = (0:length(left)-1)/fs;

    % Channel Difference
    diff_signal = left - right;

    figure;
    plot(t,diff_signal)
    title('Difference');

    %
    corr_coef = corrcoef(left,right);
    fprintf('Correlation Coefficient L-R: %.4f \n', corr_coef(1,2));

    % Heterocorrelation
    [cc, lags] = xcorr(left,right,'coeff');

    figure;
    plot(lags/fs, cc);
    title('Lag(s)')
end