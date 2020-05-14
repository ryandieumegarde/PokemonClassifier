% this function gets the points that will form the feature vector blocks
function indices = getCircleBlocks(resolution, blockSize, padding)
    centerRadius = uint32((resolution - blockSize) / 2 - padding);
    center = uint32(resolution / 2);
    halfBlock = uint32(blockSize / 2);
    indices = [];
    for y = center - centerRadius : blockSize : center + centerRadius
        xRadius = uint32(sqrt(double(centerRadius) .^ 2 - (double(center) - double(y)) .^ 2));
        for x = center - xRadius : blockSize : center + xRadius
            indices = cat(1, indices, [x - halfBlock, x + halfBlock - 1,...
                y - halfBlock, y + halfBlock - 1]);
        end
    end
end