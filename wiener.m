function s_hat_k = wiener(y_k,SNR)

mag_y_k = abs(y_k); % magnitute of the noisy signal
phase_y_k = angle(y_k); % phase of the noisy signal
Hk = SNR./(SNR+1);
s_hat_k = Hk .* mag_y_k .* exp(1j*phase_y_k);

end

