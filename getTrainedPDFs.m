function trainedPDFs = getTrainedPDFs(trainingData)
    uniqueLabels = unique(trainingData(:, size(trainingData, 2)));
    trainedPDFs = containers.Map;
    for i = 1 : length(uniqueLabels)
        data = trainingData(trainingData(:, size(trainingData, 2)) == uniqueLabels(i), :);
        data = data(:, 1 : size(data, 2) - 1);
        trainedPDFs(char(uniqueLabels(i))) = getPDF(double(data));
    end
end

