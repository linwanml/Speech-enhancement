function Pnn = Min_Statistics(Pyy,M,B)
[L num] = size(Pyy); % length of segements & num of segements
Pnn = zeros(L, num);
for i = 1:num
  if i<M
      Q = Pyy(:, 1:i);
      Pnn(:,i) = min(Q, [], 2)*B;
  else
      Q = Pyy(:, i-M+1:i);
      Pnn(:,i) = min(Q, [], 2)*B;
  end
end

