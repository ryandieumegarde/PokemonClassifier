METHOD = 'NaiveBayes'; %1NN or NaiveBayes
angleDelta = 8*pi/2; %Golden Ratio
labelMap = containers.Map;
labelMap('Abra') = "Abra"; labelMap('Arcanine') = "Arcanine"; 
labelMap('Articuno') = "Articuno"; labelMap('Beedrill') = "Beedrill";
labelMap('Blastoise') = "Blastoise"; labelMap('Bulbasaur') = "Bulbasaur";
labelMap('Butterfree') = "Butterfree"; labelMap('Charizard') = "Charizard";
labelMap('Charmander') = "Charmander"; labelMap('Diglett') = "Diglett";
labelMap('Ditto') = "Ditto"; labelMap('Dragonite') = "Dragonite";
labelMap('Eevee') = "Eevee"; labelMap('Electabuzz') = "Electabuzz";
labelMap('Electrode') = "Electrode"; labelMap('Flareon') = "Flareon";
labelMap('Gengar') = "Gengar"; labelMap('Geodude') = "Geodude";
labelMap('Gyarados') = "Gyarados"; labelMap('Jolteon') = "Jolteon";
labelMap('Magmar') = "Magmar"; labelMap('Marowak') = "Marowak";
labelMap('Mew') = "Mew"; labelMap('Mewtwo') = "Mewtwo";
labelMap('Moltres') = "Moltres"; labelMap('Nidoking') = "Nidoking";
labelMap('Nidoqueen') = "Nidoqueen"; labelMap('Oddish') = "Oddish";
labelMap('Pikachu') = "Pikachu"; labelMap('Poliwag') = "Poliwag";
labelMap('Raichu') = "Raichu"; labelMap('Sandshrew') = "Sandshrew";
labelMap('Slowpoke') = "Slowpoke"; labelMap('Squirtle') = "Squirtle";
labelMap('Staryu') = "Staryu"; labelMap('Vaporeon') = "Vaporeon";
labelMap('Venomoth') = "Venomoth"; labelMap('Venusaur') = "Venusaur";
labelMap('Zapdos') = "Zapdos";

testingImages = vertcat(dir(strcat('Images/Testing/*.jpg')));

% this loop goes through all of the testing images. It then checks to see
% if the label the algorithm guessed is correct or not and prints out the
% results
% 1NN implementation
if strcmp(METHOD, '1NN')
    correct = 0;
    for i = 1 : length(testingImages)
        fileName = strcat(testingImages(i).folder, '\', testingImages(i).name);
        unprocessedImage = imread(fileName);
        % this passes all of the necessary information to testImage1NN to
        % apply the preprocessing phases and rotational implementation
        [label distance] = testImage1NN(unprocessedImage, angleDelta, ...
                blurKernel, edgeKernel, grid, trainingData);
        correctLabel = labelMap(char(extractBefore(testingImages(i).name, ".jpg")));
        disp(strcat('Predict:', label));
        disp(strcat('Actual:', correctLabel));
        disp(distance);
        if label == correctLabel
            correct = correct + 1;
        end
    end
    disp(strcat('Correct:', num2str(correct), '/', num2str(length(testingImages))));
    disp(strcat('Accuracy:', num2str(correct / length(testingImages))));
end
% Gaussian Bayes implementation
if strcmp(METHOD, 'NaiveBayes')
    correct = 0;
    for i = 1 : length(testingImages)
        fileName = strcat(testingImages(i).folder, '\', testingImages(i).name);
        unprocessedImage = imread(fileName);
        [label probability] = testImageGaussianBayes(unprocessedImage, angleDelta, ...
            blurKernel, edgeKernel, grid, trainedPDFs);
        correctLabel = labelMap(char(extractBefore(testingImages(i).name, ".jpg")));
        disp(char(strcat('Predict:', label)));
        disp(strcat('Actual:', correctLabel));
        
        if label == correctLabel
            correct = correct + 1;
        end
    end
    disp(strcat('Correct: ', num2str(correct), '/', num2str(length(testingImages))));
    disp(strcat('Accuracy: ', num2str(correct / length(testingImages))));
end
