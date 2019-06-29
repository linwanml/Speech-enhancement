function y_t = segment(y, frame_length, hop_length)
% calculate the number of frames
ans = (length(y)-hop_length)/(frame_length-hop_length);
num_frame = floor(ans)+1;
% segmentation, generate each segments
% fit 
y_t = zeros(frame_length, num_frame-1);
for idx = 1:(num_frame-1)
    front = 1+(idx-1)*(frame_length-hop_length);    
    rear = front + frame_length-1;
    y_t(:, idx) = y(front: rear);
end
% consider the last segment
last_segment = y(1+(num_frame-1)*(frame_length-hop_length):end);
last_segment = [last_segment; zeros(frame_length-length(last_segment), 1)];
y_t = [y_t last_segment];
end
