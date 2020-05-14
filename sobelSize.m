% this function calculates the sobel kernel and sets any NaN value to 0
function outputSobel = sobelSize(kernelHalfSize)
    [x, y] = meshgrid(-kernelHalfSize : kernelHalfSize);
    outputSobel = x ./ (x .* x + y .* y);
    outputSobel(isnan(outputSobel)) = 0;
end

