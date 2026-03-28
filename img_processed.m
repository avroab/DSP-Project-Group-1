function p_img = img_processed(image)
    standard_size = [3508, 2481];
    image = imresize(image, standard_size);

    igs = im2gray(image); % conversion to gray scale
    igs = medfilt2(igs, [3 3]);   % 3x3 median filter
    bw  = imbinarize(igs); % binarization
    % (igs, 0.5)
    bw_inv = ~bw; % inverted

    cc    = bwconncomp(bw_inv);  %finds "connected components" (blobs of white pixels) in the inverted binary image
    stats = regionprops(cc, 'Area', 'Centroid', 'BoundingBox'); % acts like a tape measure for those blobs. It calculates:
    % area, centroid, and smallest rectangle that can fit inside the box

    % Anchor detection
    min_area = 250;
    max_area = 550;
    valid = [];
    for idx = 1:length(stats)
        a  = stats(idx).Area;
        bb = stats(idx).BoundingBox;
        aspect = bb(3) / bb(4);   % calculates aspect ratio by dividing width (bb(3)) by height (bb(4))
        if a > min_area && a < max_area && aspect > 0.7 && aspect < 1.4
            valid(end+1) = idx;   % If the shape passes, its ID is saved in the valid list.
        end
    end

    if length(valid) >= 4 %code first checks if it found at least 4 anchors. If not, it skips the alignment entirely and warns
        centroids = vertcat(stats(valid).Centroid); %Gathers all the x,y center points of the valid anchors into one list.
        sums  = centroids(:,1) + centroids(:,2);
        diffs = centroids(:,1) - centroids(:,2);
        [~, tl] = min(sums);  [~, br] = max(sums);
        [~, bl] = min(diffs); [~, tr] = max(diffs);

        TL = centroids(tl,:);
        TR = centroids(tr,:);
        BL = centroids(bl,:);
        BR = centroids(br,:);

        ideal_TL = [101,  225 ];
        ideal_TR = [2382, 225 ];
        ideal_BL = [101,  3285];
        ideal_BR = [2382, 3285];

        movingPoints = [TL; TR; BL; BR];
        fixedPoints  = [ideal_TL; ideal_TR; ideal_BL; ideal_BR];  % "template" oe target for alignment.

        tform = fitgeotrans(movingPoints, fixedPoints, 'projective'); % creates a Projective Transformation. 
        % a mathematical map that says, "Take the point at the tilted corner and move it to the perfect corner".
        igs   = imwarp(igs, tform, 'OutputView', imref2d(standard_size)); % actually moves the pixels. 
        % stretches and warps the gray image so that the document appears perfectly flat and front-facing.
    else
        warning('Anchor detection failed. Found %d anchors instead of 4. Proceeding without alignment.', length(valid));
    end

    % Original processing unchanged
    igs   = medfilt2(igs, [3 3]);  % Step 1: denoise again after warping
    bw    = imbinarize(igs);       % Step 2: Otsu again on aligned image
    p_img = ~bw;
end