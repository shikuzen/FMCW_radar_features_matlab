# FMCW radar features (Matlab)
FMCW Radar features visualization (MATLAB version)

This matlab repo is used for visualizing the FMCW radar features in real time. A Data was collected from IWR1443 Dev board thorugh mm-wave studion software.

# Programming details.
1. main.m
2. read_file.m (read .bin file (this source code was coppied from Mmwave Radar Device ADC Raw Data Capture (Rev. B))
3. feature_extract.m (perform 3D FFT to get a range-profile, doppler-profile, and angle-profile)
4. cfar_detection_1D.m (perform 1D cfar on range-profile to get an object's location)
5. visualization.m (plot all features)

# Our setup.
<img src="fig/moving_robotic_hand.fig" width="100%" height="100%"/>
