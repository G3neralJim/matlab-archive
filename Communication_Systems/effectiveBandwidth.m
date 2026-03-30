function [f0,B_eff] = effectiveBandwidth(f,spectrum)
% 1. Calculate Power Spectral Density (PSD)
psd = spectrum.^2;

% 2. Calculate the Spectral Centroid (f0)
% This is the "center of mass" of the frequency
f0 = sum(f' .* psd) / sum(psd);

% 3. Calculate Effective Bandwidth (B_eff)
variance = sum(((f' - f0).^2) .* psd) / sum(psd);
B_eff = sqrt(variance);

fprintf('The Spectral Centroid is: %.2f Hz\n', f0);
fprintf('The Effective Bandwidth is: %.2f Hz\n', B_eff);

end