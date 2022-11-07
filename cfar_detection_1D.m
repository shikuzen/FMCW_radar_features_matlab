function [detected_all, thres_all] = cfar_detection_1D(range_fft)
% CFAR detector
cfar = phased.CFARDetector('NumTrainingCells',30,'NumGuardCells',2);
cfar.ThresholdOutputPort = true;
chirp_select = 1;
rxtx_select = 1;
for idx = 1:size(range_fft,1)
    train_cell = squeeze(abs(range_fft(idx, chirp_select, :, rxtx_select)));
    [detected, thres] = cfar(train_cell, 1:length(train_cell));
    thres_all(idx, :) = thres;
    detected_all(idx, :) = detected;
end
end

