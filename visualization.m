function visualization(process_data, range_fft, doppler_fft, angle_fft, thres_all, ranges, angles, selected_range_bin)

chirp_select = 1;
rxtx_select = 1;

for idx = 1:size(range_fft, 1)

    subplot(4,2,1);
    imagesc(mag2db(squeeze(abs(range_fft(idx, chirp_select, :, :)))));
    title('Range-Chirp Image');
    xlabel('chirp number');
    ylabel('range in cm');
    set(gca, 'YDir', 'normal');
    subplot(4,2,2);
    imagesc(mag2db(squeeze(abs(doppler_fft(idx, :, :, rxtx_select)))));
    title('Range-Doppler Image');
    xlabel('range in cm');
    ylabel('doppler velocity');
    set(gca, 'YDir', 'normal');
    subplot(4,2,3);
    imagesc(angles, ranges, mag2db(squeeze(mean(abs(angle_fft(idx, :, :, :)), 2))));
    title('Range-Angle Image');
    xlabel('angle in \circ');
    ylabel('range in cm');
    set(gca, 'YDir', 'normal');
    subplot(4,2,4);
    plane_thres = squeeze(mean(abs(angle_fft(idx, :, :, :)), 2));
    avg_plan = mean(plane_thres, 'all');
    plane_mul = 5;
    plane_thres(plane_thres < avg_plan*plane_mul) = 0;
    [row,col] = find(plane_thres);
    ranges_cut = ranges(row);
    angles_cut = deg2rad(angles(col));
    [x_pos, y_pos] = pol2cart(angles_cut, ranges_cut);
    scatter(x_pos, y_pos, 'filled');
    xlim([0 200]);
    ylim([-100 100]);
    xy_text = ['XY map (/w plane threshold)(average x ' num2str(plane_mul) ')'];
    title(xy_text);
    ylabel('Y');
    xlabel('X');
    subplot(4,2,5);
    plot(squeeze(real(process_data(idx, chirp_select, :, rxtx_select))));
    hold on
    plot(squeeze(imag(process_data(idx, chirp_select, :, rxtx_select))));
    hold off
    title('Raw ADC data');
    xlabel('ADC samples');
    ylabel('amplitude');
    subplot(4,2,6);
    plot(squeeze(mean(abs(range_fft(idx, :, :, rxtx_select)),2)));
    hold on
    plot(thres_all(idx, :));
    hold off
    title('Range Profile with 1-D CFAR ');
    xlabel('range in cm');
    ylabel('amplitude');
    subplot(4,2,7);
    plot(unwrap(angle(range_fft(idx, :, selected_range_bin(1,idx), rxtx_select))));
    pc_name = ['Phase-Chirps (TX-RX number, ' num2str(rxtx_select) ')'];
    title(pc_name);
    xlabel('chirp number');
    ylabel('phase angle');
    subplot(4,2,8);
    plot(unwrap(angle(range_fft(:, chirp_select, selected_range_bin(1,idx), rxtx_select))));
    hold on
    y = ylim; % current y-axis limits
    plot([idx idx],[y(1) y(2)]);
    hold off
    cf_name = ['Chirp-Frames (Chirp number, ' num2str(chirp_select), ')'];
    title(cf_name);
    xlabel('frame number');
    ylabel('phase angle');
    drawnow;
%     pause(0.01);
end

end

