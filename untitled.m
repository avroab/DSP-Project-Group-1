im = imread('zoom.jpg');
im_resized = imresize(im, [3508, 2481]);

igs = im2gray(im_resized);
bw  = imbinarize(igs, 0.25);
bw_inv = ~bw;

cc    = bwconncomp(bw_inv);
stats = regionprops(cc, 'Area', 'Centroid', 'BoundingBox');

% Filter anchors
min_area = 250;
max_area = 550;
valid = [];
for idx = 1:length(stats)
    a  = stats(idx).Area;
    bb = stats(idx).BoundingBox;
    aspect = bb(3) / bb(4);
    if a > min_area && a < max_area && aspect > 0.6 && aspect < 1.6
        valid(end+1) = idx;
    end
end

fprintf('Number of anchors detected: %d\n', length(valid));

% Show image with detected anchors marked
figure;
imshow(im_resized);
hold on;
for i = 1:length(valid)
    c = stats(valid(i)).Centroid;
    plot(c(1), c(2), 'r+', 'MarkerSize', 40, 'LineWidth', 3);
    viscircles(c, 30, 'Color', 'r');
    text(c(1)+35, c(2), sprintf('Area=%d', stats(valid(i)).Area), ...
        'Color', 'red', 'FontSize', 14, 'FontWeight', 'bold');
end
title(sprintf('%d anchor(s) detected', length(valid)));
hold off;