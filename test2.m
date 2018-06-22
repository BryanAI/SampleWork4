clc;
clear;
close all;

I = imread('train01.jpg');
figure(100), imshow(I), colorbar;

hsvImage = rgb2hsv(I);             %# Convert the image to HSV space
hPlane = 360.*hsvImage(:,:,1);     %# Get the hue plane scaled from 0 to 360
sPlane = hsvImage(:,:,2);          %# Get the saturation plane

nonRedIndex = (hPlane > 175);      %# Select "non-green" pixels
sPlane(nonRedIndex) = 0;           %# Set the selected pixel saturations to 0
nonRedIndex = (hPlane < 75);       %# Select "non-green" pixels
sPlane(nonRedIndex) = 0;           %# Set the selected pixel saturations to 0

hsvImage(:,:,2) = sPlane;          %# Update the saturation plane
% hsvImage(:,:,1) = sPlane;         % colour
% hsvImage(:,:,3) = sPlane;         % brightness
rgbImage = hsv2rgb(hsvImage);      %# Convert the image back to RGB space
figure(2), imshow(rgbImage), colorbar;






figure(1);
binEdges = 0:360;                 %# Edges of histogram bins
N = histc(hPlane(:),binEdges);    %# Bin the pixel hues from above
hBar = bar(binEdges(1:end-1),N(1:end-1),'histc');  %# Plot the histogram
set(hBar,'CData',1:360,...            %# Change the color of the bars using
         'CDataMapping','direct',...  %#   indexed color mapping (360 colors)
         'EdgeColor','none');         %#   and remove edge coloring
colormap(hsv(360));               %# Change to an HSV color map with 360 points
axis([0 360 0 max(N)]);           %# Change the axes limits
set(gca,'Color','k');             %# Change the axes background color
set(gcf,'Pos',[50 400 560 200]);  %# Change the figure size
xlabel('HSV hue (in degrees)');   %# Add an x label
ylabel('Bin counts');             %# Add a y label





test = rgb2gray(rgbImage);
test = sPlane;
% test = edge(test,'log', 0.01);
% figure(3), imshow(test), colorbar;

%# fill holes
test = imfill(test, 'holes');
% figure(5), imshow(test);

%# dilation-erosion
se = strel('octagon', 6);
% test = imdilate(test,se);
test = imerode(test,se);
% figure(4), imshow(test);

% test = edge(test,'sobel',0.05);
% figure(5), imshow(test);

BW = im2bw(test);
% figure(18), imshow(BW);
figure(100), imshow(I);


st = regionprops(BW, 'BoundingBox' );

for k = 1 : length(st)
  thisBB = st(k).BoundingBox;
  rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
  'EdgeColor','g','LineWidth',2 )
end



























% cc = normxcorr2(test,train);
% figure(56)
% surf(cc), shading flat
% [max_c, imax] = max(abs(cc(:)));
% [ypeak,xpeak] = ind2sub(size(cc),imax(1));
% 
% figure(100);
% hold on;
% rectangle('Position',[(xpeak-50) (ypeak-50) 75 75], 'LineWidth', 2, 'EdgeColor', 'b');



% test = rgb2gray(rgbImage);
% med = im2double(rgb2gray(imread('green_2by4brick.jpg')));
% figure(3), imshow(test), colorbar;
