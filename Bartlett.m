function psd_b = Bartlett (y, M)
% input 1 is the signal
% input 2 is the number of periodogram segement to average
% output is the power spectrum density estimated by Bartlett method

% periodogram of each segement
[L num] = size(y); % length of segements & num of segements
periodogram = zeros(L, num);
for idx = 1:num
    periodogram(:,idx) = abs(y(:,idx)) .^2;
end
% Bartlett PSD is the average of M periodogram segments
psd_b = zeros(L, num);
for l = 1: num
    if l<M
        psd_b(:,l) = 1/l*sum(periodogram(:, 1:l), 2);
    else
        psd_b(:,l) = 1/M * sum(periodogram(:, l-M+1:l), 2);
end

end
