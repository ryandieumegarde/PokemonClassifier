labels = ["Abra", "Arcanine", "Articuno", "Beedrill", "Blastoise", "Bulbasaur", "Butterfree", "Charizard", "Charmander", "Diglett", "Ditto", "Dragonite", "Eevee", "Electabuzz", "Electrode", "Flareon", "Gengar", "Geodude", "Gyarados", "Jolteon", "Machamp", "Magmar", "Marowak", "Mew", "Mewtwo", "Moltres", "Nidoking", "Nidoqueen", "Oddish", "Pikachu", "Poliwag", "Raichu", "Sandshrew", "Slowpoke", "Squirtle", "Staryu", "Vaporeon", "Venomoth", "Venusaur", "Zapdos"];
% define user variables: blur, resolution, blocksize, kerbel size, and
% angle for rotations
blurKernel = fspecial('gaussian', 5, 3);
resolution = 512; blockSize = 64; padding = 8; edgeDetectionKernelHalfSize = 2;
grid = getCircleBlocks(resolution, blockSize, padding);
edgeKernel = sobelSize(edgeDetectionKernelHalfSize);

%go through all the training images and preprocess them, then add the
%feature vector into the trainingData table
trainingData = [];
for i = 1 : length(labels)
    label = labels(i);
    images = vertcat(dir(strcat('Images/Training/', char(label), '/*.png')), dir(strcat('Images/Training/',char(label), '/*.jpg')));
    for j = 1 : length(images)
        fileName = strcat(images(j).folder, '\', images(j).name);
        unprocessedImage = imread(fileName);
        processedImage = processImage(unprocessedImage, edgeKernel, blurKernel);
        imshow(processedImage)
        row = [imageToData(processedImage, grid) label];
        trainingData = vertcat(trainingData, row);
    end
end
trainedPDFs = getTrainedPDFs(trainingData);