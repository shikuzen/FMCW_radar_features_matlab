function [process_data, range_fft, doppler_fft, angle_fft] = feature_extract(raw_data, adc, chirp, tx, rx, pad_range, pad_txrx, r_start, r_end)
% create TX1-4
process_data = permute(reshape(raw_data, rx, adc, tx, chirp, []), [5 4 2 3 1]);
process_data = reshape(process_data, [], chirp, adc, tx*rx);
% create range-azimuth profile
range_fft = fft(process_data, adc*pad_range, 3);
doppler_fft = fft(range_fft(:,:,r_start:r_end,:), [], 2);
doppler_fft = fftshift(doppler_fft, 2);
angle_fft = fft(range_fft(:,:,r_start:r_end,:), tx*rx*pad_txrx, 4);
angle_fft = fftshift(angle_fft, 4);
range_fft = range_fft(:,:,r_start:r_end,:);

end

