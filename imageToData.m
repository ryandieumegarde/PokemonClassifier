% this function calculates the mean of the angles create from the kernels
% within a block in the image
function data = imageToData(processedImage, gridIndices)
    data = [];
    for i = 1 : size(gridIndices, 1)
        indices = gridIndices(i, :);
        block = processedImage(indices(3) : indices(4), indices(1) : indices(2));
        data = [data nanmean(block(:))];
    end
    data(data == 0) = NaN;
end

