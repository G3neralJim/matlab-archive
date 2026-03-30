function [f_low, f_high, occupied_bw] = occupiedBW(f,spectrum)
% 1. Compute Cumulative Power (Integration of the PSD)
psd = spectrum.^2; 
total_power = sum(psd);
cumulative_power = cumsum(psd);

% 2. Find the 0.5% and 99.5% power points
p_low = 0.005 * total_power;
p_high = 0.995 * total_power;

% Find the frequencies closest to these power levels
idx_low = find(cumulative_power >= p_low, 1, 'first');
idx_high = find(cumulative_power >= p_high, 1, 'first');

f_low = f(idx_low);
f_high = f(idx_high);
occupied_bw = f_high - f_low;

% 3. Visualization
fprintf('99%% Occupied Bandwidth: %.2f Hz to %.2f Hz (Span: %.2f Hz)\n', ...
         f_low, f_high, occupied_bw);

% Optional: Plot the integration area
area(f(idx_low:idx_high), psd(idx_low:idx_high), 'FaceAlpha', 0.3);
title(['Occupied Bandwidth: ', num2str(occupied_bw), ' Hz']);
end