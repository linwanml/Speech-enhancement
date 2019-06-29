function [SNR Pss] = snr_dd(Pyy, Pnn,alpha)

[L num] = size(Pyy); % length of segements & num of segements
Pss = zeros(L, num);
Pss(:, 1) = 0;
SNR = zeros(L, num);
for idx = 2:num
    SNR(:, idx) = alpha * Pss(:, idx-1)./Pnn(:, idx)...
        + (1-alpha) * max(Pyy(:, idx)./Pnn(:, idx)-1, 0);
    Pss(:, idx) = SNR(:, idx) .* Pnn(:, idx);
end
end

    