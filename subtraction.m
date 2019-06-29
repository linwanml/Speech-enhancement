function s_hat_k = subtraction(Pyy,Pnn,y_k,threshold)

s_mag = (Pyy.^0.5).*(max(1 - Pnn./Pyy,threshold)).^0.5;
phase = angle(y_k);
s_hat_k = s_mag.*exp(1j*phase); 

end

