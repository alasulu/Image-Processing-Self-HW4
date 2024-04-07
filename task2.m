clear
clc

% Image Reading
I3 = imread("Image3.jpg"); % Reading Image 3
I4 = imread("Image4.jpg"); % Reading Image 4

% Converting to Grayscale
Ig3 = rgb2gray(I3); % Convert Image 3 to Grayscale
Ig4 = rgb2gray(I4); % Convert Image 4 to Grayscale

% Perform Discrete Fourier Transform (DFT)
DFT_Ig3 = fft2(double(Ig3)); %Execute a FFT Operation on Image 3
DFT_Ig4 = fft2(double(Ig4)); %Execute a FFT Operation on Image 3

% Define radius values for the filters
r_values = [20, 50, 100]; % You can adjust these values

% Initialize filtered images respect the request radius values
filtered_ig3_highpass = cell(1, numel(r_values)); 
filtered_ig3_lowpass = cell(1, numel(r_values));
filtered_ig4_highpass = cell(1, numel(r_values));
filtered_ig4_lowpass = cell(1, numel(r_values));

% Apply High-Pass and Low-Pass Filters to Image 3
for i = 1:numel(r_values)
    [rows, cols] = size(Ig3);
    [X, Y] = meshgrid(1:cols, 1:rows); % Create a meshgrid to generate frequency components
    centerX = ceil(cols / 2); % Calculate the center coordinates for X
    centerY = ceil(rows / 2); % Calculate the center coordinates for Y
    % Creating high-pass filter kernel
    H_highpass = ones(rows, cols);
    r_highpass = r_values(i);
    H_highpass(sqrt((X - centerX).^2 + (Y - centerY).^2) <= r_highpass) = 0;
    % Creating low-pass filter kernel
    H_lowpass = ones(rows, cols);
    r_lowpass = r_values(i);
    H_lowpass(sqrt((X - centerX).^2 + (Y - centerY).^2) > r_lowpass) = 0;
    filtered_ig3_highpass{i} = real(ifft2(DFT_Ig3 .* fftshift(H_highpass))); % Applying high-pass filter
    filtered_ig3_lowpass{i} = real(ifft2(DFT_Ig3 .* fftshift(H_lowpass)));  % Applying low-pass filter
end

% Apply High-Pass and Low-Pass Filters to Image 4
for i = 1:numel(r_values)
    [rows2, cols2] = size(Ig4); % Define Image Size
    [X2, Y2] = meshgrid(1:cols2, 1:rows2); % Create a meshgrid to generate frequency components
    centerX2 = ceil(cols2 / 2); % Calculate the center coordinates for X2
    centerY2 = ceil(rows2 / 2); % Calculate the center coordinates for Y2
    % Creating high-pass filter kernel
    H_highpass2 = ones(rows2, cols2);
    r_highpass2 = r_values(i);
    H_highpass2(sqrt((X2 - centerX2).^2 + (Y2 - centerY2).^2) <= r_highpass2) = 0;
    % Creating low-pass filter kernel
    H_lowpass2 = ones(rows2, cols2);
    r_lowpass2 = r_values(i);
    H_lowpass2(sqrt((X2 - centerX2).^2 + (Y2 - centerY2).^2) > r_lowpass2) = 0;
    filtered_ig4_highpass{i} = real(ifft2(DFT_Ig4 .* fftshift(H_highpass2))); % Applying high-pass filter
    filtered_ig4_lowpass{i} = real(ifft2(DFT_Ig4 .* fftshift(H_lowpass2))); % Applying low-pass filter
end

% Display filtered images for Image 3
figure;
for i = 1:numel(r_values)
    subplot(numel(r_values), 2, (i-1)*2+1);
    imshow(uint8(filtered_ig3_highpass{i}), []);
    title(['High-pass Filtered Image 3 (Radius = ', num2str(r_values(i)), ')']);
    
    subplot(numel(r_values), 2, (i-1)*2+2);
    imshow(uint8(filtered_ig3_lowpass{i}), []);
    title(['Low-pass Filtered Image 3 (Radius = ', num2str(r_values(i)), ')']);
end

% Display filtered images for Image 4
figure;
for i = 1:numel(r_values)
    subplot(numel(r_values), 2, (i-1)*2+1);
    imshow(uint8(filtered_ig4_highpass{i}), []);
    title(['High-pass Filtered Image 4 (Radius = ', num2str(r_values(i)), ')']);
    
    subplot(numel(r_values), 2, (i-1)*2+2);
    imshow(uint8(filtered_ig4_lowpass{i}), []);
    title(['Low-pass Filtered Image 4 (Radius = ', num2str(r_values(i)), ')']);
end

% Hayriye Kaymaz, Oğuzhan Alasulu