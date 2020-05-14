function [label distance]  = testImageKNN(image, angleDelta, blurKernel,...
        edgeKernel, grid, trainingData)
    minDistance = Inf;
    label = 'unknown';
    % this goes through every rotation (based on the value determined in
    % training.m
    for angle = 0 : angleDelta : 360
        rotatedImage = imrotate(image, angle, 'crop');
        % this preprocesses the image
        processedImage = processImage(rotatedImage, edgeKernel, blurKernel);
        data = imageToData(processedImage, grid);
        % diff creates a matrix for the feature vector just calculated and
        % repeats the vector until it becomes the size of the training
        % feature vector table. It then calculates the difference for each
        % image and keeps the smallest feature variance
        diff = (repmat(data, [size(trainingData, 1) 1])...
            - double(trainingData(:, 1 : size(trainingData, 2) - 1))) .^ 2;
        diff(diff > pi/2) = pi - diff(diff > pi/2);
        diff = nansum(diff, 2);
        [minDiff idx] = min(diff);
        % if the new feature distance is less than update the variables
        if minDiff < minDistance
            minDistance = minDiff;
            label = trainingData(idx, size(trainingData, 2));
        end
    end
    distance = minDistance;
end

