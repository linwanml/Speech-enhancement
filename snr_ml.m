function [SNR,Pss] = snr_ml(Pyy,Pnn)

SNR = Pyy ./Pnn - 1; 
Pss = Pyy - Pnn;

end

