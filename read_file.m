function [retVal] = read_file(fileName)

numADCBits = 16; % number of ADC bits per sample
numLanes = 4; % do not change. number of lanes is always 4 even if only 1 lane is used. unused lanes
isReal = 0; % set to 1 if real only data, 0 if complex dataare populated with 0 %% read file an convert to signed number
fid = fopen(fileName,'r');
adcData = fread(fid, 'int16');
if numADCBits ~= 16
    l_max = 2^(numADCBits-1)-1;
    adcData(adcData > l_max) = adcData(adcData > l_max) - 2^numADCBits;
end
fclose(fid);
if isReal
    adcData = reshape(adcData, numLanes, []);
else
    adcData = reshape(adcData, numLanes*2, []);
    adcData = adcData([1,2,3,4],:) + sqrt(-1)*adcData([5,6,7,8],:);
end

    retVal = adcData;
end

