clc;
clear all;

fileName = 'test_range_3tx.bin';

tx = 3;
rx = 4;
r_start = 20; % range_cliping (start) 20*range_res = 28 cm
r_end = 100; % range_cliping (stop) 20*range_res = 140 cm
pad_range = 5; % padding range
pad_txrx = 8; % padding sample 
chirp = 16; 
adc = 256;
sampling_rate = 9121 * 10^3;

sampling_time = adc / sampling_rate;
freq_slope = 63.343 * 10^6 / 10^-6;
BW = sampling_time * freq_slope;

range_res = physconst('LightSpeed')/ (2*BW) / 10^-2; % range resolution in cm unit
range_res = range_res / (1 + pad_range); % range_res = 1.4052 cm/bin (Not true resolution)
ranges = [0:range_res:range_res*((adc*pad_range)-1)];

lambda = physconst('LightSpeed')/ sampling_rate;
Na = tx*rx*pad_txrx;
omega = ((-(Na/2)+1:(Na/2))/Na)*2*pi;
omega = -1*omega;
angles = asin((lambda*omega)/(2*pi*(lambda/2))); % angle resolution
angles = rad2deg(angles); % angle

raw_data = read_file(fileName);

[process_data, range_fft, doppler_fft, angle_fft] = feature_extract(raw_data, adc, chirp, tx, rx, pad_range, pad_txrx, r_start, r_end); 
[detected_all, thres_all] = cfar_detection_1D(range_fft);

for idx = 1:size(detected_all,1)
    range_bin = round(mean(find(detected_all(idx,:)))); % selected bin to visualize a phase
    if isnan(range_bin)
        selected_range_bin(idx) = selected_range_bin(idx-1); 
    else
        selected_range_bin(idx) = range_bin;
    end
end

visualization(process_data, range_fft, doppler_fft, angle_fft, thres_all, ranges(1, r_start:r_end), angles, selected_range_bin);