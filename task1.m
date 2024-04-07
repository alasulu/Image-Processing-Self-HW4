clear
clc

% Image Reading
I = imread("Image1.jpg"); % Reading Image 1
I2 = imread("Image2.jpg"); % Reading Image 2
T = imread("temp_image1.jpg"); % Reading Template Image 1
T2 = imread("temp_image2.jpg"); % Reading Template Image 2

% Converting to Grayscale
Ig = rgb2gray(I); % Convert Image 1 to Grayscale
Ig2 = rgb2gray(I2); % Convert Image 2 to Grayscale
Tg = rgb2gray(T); % Convert Template 1 to Grayscale
Tg2 = rgb2gray(T2); % Convert Template 2 to Grayscale

% Finding the Template in Image
corr_map = normxcorr2(Tg, Ig); % Finding First Template in Image 1
corr_map2 = normxcorr2(Tg2, Ig2); % Finding Second Template in Image 2

% Finding Peak Locations, Threshold Peaks and Extracting Locations
[max_corr, maxIndex] = max(corr_map(:)); % Find the Max Correlation Indices in Correlation Map
[max_corr2, maxIndex2] = max(corr_map2(:)); % Find the Max Correlation Indices in Correlation Map 2
thres = 0.8; %Adjusting a Threshold
thres2 = 0.8; %Adjusting a Threshold 2
thres_peak = corr_map > thres * max_corr; %Threshold Peaks Respect to Max Correlation and Ajudsted Threshold Value
thres_peak2 = corr_map2 > thres2 * max_corr2; %Threshold Peaks Respect to Max Correlation and Ajudsted Threshold Value 2
[y_coordinates,x_coordinates] = find(thres_peak); % Finding Y and X Coordinates of Threshold Peaks
[y_coordinates2,x_coordinates2] = find(thres_peak2); % Finding Y and X Coordinates of Threshold Peaks 2

% Displaying the Result 1
figure
imshow(Ig) % Displaying First Image
hold on
for i = 1:numel(x_coordinates)
    region = [x_coordinates(i) - size(Tg, 2), y_coordinates(i) - size(Tg, 1), size(Tg, 2), size(Tg, 1)];
     %Creating Rectangle That Shows the Exact Position of Template in Image
    rectangle('Position', region, 'EdgeColor', 'g', 'LineWidth', 0.5);
end

pause(0.1); % Add a slight delay

% Displaying the Result 2
figure; 
imshow(Ig2) % Displaying Second Image
hold on
for k = 1:numel(x_coordinates2)
    % Define template region
    region2 = [x_coordinates2(k) - size(Tg2, 2), y_coordinates2(k) - size(Tg2, 1), size(Tg2, 2), size(Tg2, 1)]; 
    %Creating Rectangle That Shows the Exact Position of Template in Image
    rectangle('Position', region2, 'EdgeColor', 'g', 'LineWidth', 0.5);
end

% Oğuzhan Alasulu, Hayriye Kaymaz