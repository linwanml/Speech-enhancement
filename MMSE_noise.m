function Pnn = MMSE_noise(Pyy)

[length num] = size (Pyy);
Pnn = zeros(length, num);
Pnn(:, 1) = Pyy(:, 1); % 1st frame only noise
SNR = 30;
alpha = 0.8;
E_n_y = zeros(length, num);
for idx = 2: num;
    E0(:,idx) = Pyy(:, idx);
    E1(:,idx) = Pnn(:, idx-1);
    e(:, idx) = -(Pyy(:,idx)./Pnn(:,idx-1)) * SNR/(SNR+1);
    P1(:,idx) = 1./(1+0.9*(1+SNR)*exp(e(:, idx)));
    P0(:,idx) = 1-P1(:,idx);
    
    E_n_y(:, idx) = E0(:,idx).*P0(:,idx) + E1(:,idx).*P1(:,idx);
    
    Pnn(:, idx) = alpha * Pnn(:, idx-1) + (1-alpha)*E_n_y(:,idx);
end
end

