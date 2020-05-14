% this function calculates the converts the image to grayscale, applies the
% sobel kernel and calculates the arctan of the X/Y kernels and then sets
% the NaN and  below threshold values to 0
function outputImage = processImage(image, edgeKernel, blurKernel)
    image = im2double(rgb2gray(image));
    image = imfilter(image, blurKernel, 'replicate');
    kernelX = edgeKernel;
    kernelY = rot90(kernelX);
    processedX = imfilter(image, kernelX, 'replicate');
    processedY = imfilter(image, kernelY, 'replicate');
    processedX(processedX <= .001) = 0;
    processedY(processedY <= .001) = 0;
    %outputImage = (processedX <= .01 & processedY <= .01);
    outputImage = atan(processedY ./ processedX);
    %outputImage(isnan(outputImage)) = 100;
    %outputImage(isnan(outputImage)) = 0;
end

