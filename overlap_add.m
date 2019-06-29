function s_t_est = overlap_add(s, frame_length, hop_length)
s_t_est1 = s(1:frame_length-hop_length/2, 1);
s_t_est2 = s(1+hop_length/2:end,end);
s(:, 1) = [];
s(:, end) = [];
s(1:hop_length/2, :) = [];
s(end-(hop_length/2-1): end, :) = [];
s = reshape(s, [], 1);
s_t_est = [s_t_est1; s;s_t_est2];
end