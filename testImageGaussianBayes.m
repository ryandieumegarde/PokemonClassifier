function [label probability]  = testImageNaiveBayes(image, angleDelta, blurKernel,...
        edgeKernel, grid, trainedPDFs)
    maxProbability = -Inf;
    for angle = 0 : angleDelta : 360
        rotatedImage = imrotate(image, angle, 'crop');
        processedImage = processImage(rotatedImage, edgeKernel, blurKernel);
        data = imageToData(processedImage, grid);
        
        for testingLabel = trainedPDFs.keys
            pdfs = trainedPDFs(char(testingLabel));
            probs = 1;
            %disp(size(pdfs));
            for i = 1 : size(pdfs, 2)
                distribution = normpdf(data(i), pdfs(1, i), pdfs(2, i));
                if(~isnan(distribution))
                    probs = probs * distribution;
                end
            end
            if (isnan(probs)) 
                disp(testingLabel);
            end
            if probs > maxProbability
                maxProbability = probs;
                label = testingLabel;
                probability = probs;
            end
        end
    end
end

