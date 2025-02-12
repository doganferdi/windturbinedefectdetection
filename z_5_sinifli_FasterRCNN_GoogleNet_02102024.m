clear all;
% verilerin yüklenmesi
load ('C:\Program Files\MATLAB\R2024b\toolbox\nnet\cnn\zeliharuzgarturbini\zelihav4_5_sinif_v1.mat');
%%
trainingData = ruzgartirbunu_train_ds;

rng(0)
shuffledIndices = randperm(height(trainingData));
idx = floor(0.8 * height(trainingData));
trainingIdx = 1:idx;
trainingDataTbl = trainingData(shuffledIndices(trainingIdx),:);
validationIdx = idx+1 : idx + 1 + floor(0.1 * length(shuffledIndices) );

validationDataTbl = trainingData(shuffledIndices(validationIdx),:);
testIdx = validationIdx(end)+1 : length(shuffledIndices);
testDataTbl = trainingData(shuffledIndices(testIdx),:);

imdsTrain = imageDatastore(trainingDataTbl{:,"resim_yolu"});
bldsTrain = boxLabelDatastore(trainingDataTbl(:,{'boyaHasari','erozyon','serration','vortex','vortexHasarli'}));
imdsValidation = imageDatastore(validationDataTbl{:,"resim_yolu"});
bldsValidation = boxLabelDatastore(validationDataTbl(:,{'boyaHasari','erozyon','serration','vortex','vortexHasarli'}));
imdsTest = imageDatastore(testDataTbl{:,"resim_yolu"});
bldsTest = boxLabelDatastore(testDataTbl(:,{'boyaHasari','erozyon','serration','vortex','vortexHasarli'}));

trainingData = combine(imdsTrain,bldsTrain);
validationData = combine(imdsValidation,bldsValidation);
testData = combine(imdsTest,bldsTest);

%% 
siniflar = {'boyaHasari','erozyon','serration','vortex','vortexHasarli'}
cikis_sinif_sayisi = 1+numel(siniflar); % arka planı belirlemek için +1 diyoruz sınıf sayısını
net = googlenet;
lgraph = layerGraph(net);
numClasses = 5;
numClassesPlusBackground = numClasses + 1;
lgraph = removeLayers(lgraph, {'loss3-classifier','prob','output'});
            newLayers = [
                     fullyConnectedLayer(numClassesPlusBackground,'Name','fc1000','WeightLearnRateFactor',10,'BiasLearnRateFactor', 10)
                     softmaxLayer('Name','softmax')
                     classificationLayer('Name','ClassificationLayer_predictions')
                        ];
            lgraph = addLayers(lgraph,newLayers);
            
            % yapılan değişikliklerle grafikleri kontrol et
                lgraph = connectLayers(lgraph,'pool5-drop_7x7_s1','fc1000');
             
% Define the number of outputs of the fully connected layer.

data = read(trainingData);
inputSize = [840 840 3]
numClasses=5;
preprocessedTrainingData = transform(trainingData, @(data)preprocessData(data,inputSize));
numAnchors = 15;
[anchorBoxes,meanIoU] = estimateAnchorBoxes(bldsTrain,numAnchors);
featureLayer = "inception_4d-output";
lgraph = fasterRCNNLayers(inputSize,numClasses,anchorBoxes,lgraph,featureLayer);

options = trainingOptions('sgdm', ...
        'LearnRateSchedule','piecewise', ...
    'LearnRateDropFactor',0.1, ...
    'LearnRateDropPeriod',1, ...
    'InitialLearnRate',1e-4,...
    'MaxEpochs',5, ...
    'MiniBatchSize',4, ...
    'Verbose', true, ...
    'ValidationFrequency',20, ...
    Plots='training-progress');% 'ValidationData',validationData, ...
 gpu = gpuDevice;
 freeMem = gpu.FreeMemory;
 availMem = gpu.AvailableMemory;   

    detector = trainFasterRCNNObjectDetector(trainingData,lgraph,options, ...
        NegativeOverlapRange=[0 0.3], ...
        PositiveOverlapRange=[0.3 1]);

save ('C:\Program Files\MATLAB\R2024b\toolbox\nnet\cnn\zeliharuzgarturbini\sonuc_5sinifli_GoogleNetv1.mat','-v7.3');
%%

data = read(trainingData);
I = data{1};
bbox = data{2};
annotatedImage = insertShape(I,"rectangle",bbox);
annotatedImage = imresize(annotatedImage,2);
figure
imshow(annotatedImage)


for t=10:15
I = imread(testDataTbl.resim_yolu{t});
I = imresize(I,inputSize(1:2));
% [bboxes,scores] = detect(detector,I, Threshold=0.6);
[bboxes,scores,labels] = detect(detector,I, Threshold=0.5);

I = insertObjectAnnotation(I,"rectangle",bboxes,labels);
figure
imshow(I)
end
 % preprocessedTrainingData = transform(trainingData, @(data)preprocessData(data,inputSize));

testData = transform(testData,@(data)trainingData(data,inputSize));
% [C,scores] = semanticseg(testData,lgraph,classes='damage');

results = detect(detector,imdsTest,'MinibatchSize',8,Threshold=0.5);
metrics = evaluateObjectDetection(results,bldsTest);

% recalld = metrics.ClassMetrics{"burn_mark","Recall"};
% precisiond = metrics.ClassMetrics{"burn_mark","Precision"};
% apd = metrics.ClassMetrics{"burn_mark","AP"};
% figure
% plot([recalld{:}],[precisiond{:}]);
% xlabel("Recall")
% ylabel("Precision")
% grid on
% title(["Average Precision = %.2f  burn_mark", metrics.ClassMetrics.mAP("burn_mark")])

recallbh = metrics.ClassMetrics{"boyaHasari","Recall"};
precisionbh = metrics.ClassMetrics{"boyaHasari","Precision"};
apc = metrics.ClassMetrics{"boyaHasari","AP"};
figure('Name','Paint Damage');
plot([recallbh{:}],[precisionbh{:}]);
% xlabel("Recall")
% ylabel("Precision")
% grid on
% title(["Average Precision = Paint Damage", metrics.ClassMetrics.AP("boyaHasari")])


% recalld = metrics.ClassMetrics{"drenaj","Recall"};
% precisiond = metrics.ClassMetrics{"drenaj","Precision"};
% apd = metrics.ClassMetrics{"drenaj","AP"};
% figure
% plot([recalld{:}],[precisiond{:}]);
% xlabel("Recall")
% ylabel("Precision")
% grid on
% title(["Average Precision = %.2f  drenaj", metrics.ClassMetrics.AP("drenaj")])

recalle = metrics.ClassMetrics{"erozyon","Recall"};
precisione = metrics.ClassMetrics{"erozyon","Precision"};
ape = metrics.ClassMetrics{"erozyon","AP"};
figure('Name','Erosion');
plot([recalle{:}],[precisione{:}]);
% xlabel("Recall")
% ylabel("Precision")
% grid on
% title(["Average Precision = Erosion", metrics.ClassMetrics.AP("erozyon")])

% recallka = metrics.ClassMetrics{"kabukAyrilmasi","Recall"};
% precisionka = metrics.ClassMetrics{"kabukAyrilmasi","Precision"};
% ape = metrics.ClassMetrics{"kabukAyrilmasi","AP"};
% figure
% plot([recallka{:}],[precisionka{:}]);
% xlabel("Recall")
% ylabel("Precision")
% grid on
% title(["Average Precision = %.2f  kabukAyrilmasi", metrics.ClassMetrics.mAP("kabukAyrilmasi")])

% recallr = metrics.ClassMetrics{"reseptor","Recall"};
% precisionr = metrics.ClassMetrics{"reseptor","Precision"};
% apr = metrics.ClassMetrics{"reseptor","AP"};
% figure
% plot([recallr{:}],[precisionr{:}]);
% xlabel("Recall")
% ylabel("Precision")
% grid on
% title(["Average Precision = %.2f  reseptor", metrics.ClassMetrics.AP("reseptor")])
% 
% 
% recallrh = metrics.ClassMetrics{"reseptorHasarli","Recall"};
% precisionrh = metrics.ClassMetrics{"reseptorHasarli","Precision"};
% aprh = metrics.ClassMetrics{"reseptorHasarli","AP"};
% figure
% plot([recallrh{:}],[precisionrh{:}]);
% xlabel("Recall")
% ylabel("Precision")
% grid on
% title(["Average Precision = %.2f  reseptorHasarli", metrics.ClassMetrics.AP("reseptorHasarli")])


recalls = metrics.ClassMetrics{"serration","Recall"};
precisions = metrics.ClassMetrics{"serration","Precision"};
aps = metrics.ClassMetrics{"serration","AP"};
figure('Name','Serration');
plot([recalls{:}],[precisions{:}]);
% xlabel("Recall")
% ylabel("Precision")
% grid on
% title(["Average Precision = Serration", metrics.ClassMetrics.AP("serration")])

% recallsh = metrics.ClassMetrics{"serrationHasarli","Recall"};
% precisionsh = metrics.ClassMetrics{"serrationHasarli","Precision"};
% ape = metrics.ClassMetrics{"serrationHasarli","AP"};
% figure
% plot([recallsh{:}],[precisionsh{:}]);
% xlabel("Recall")
% ylabel("Precision")
% grid on
% title(["Average Precision = %.2f  serrationHasarli", metrics.ClassMetrics.mAP("serrationHasarli")])

recallv = metrics.ClassMetrics{"vortex","Recall"};
precisionv = metrics.ClassMetrics{"vortex","Precision"};
apv = metrics.ClassMetrics{"vortex","AP"};
figure('Name','Vortex');
plot([recallv{:}],[precisionv{:}]);
% xlabel("Recall")
% ylabel("Precision")
% grid on
% title(["Average Precision = Vortex", metrics.ClassMetrics.AP("vortex")])

recallvh = metrics.ClassMetrics{"vortexHasarli","Recall"};
precisionvh = metrics.ClassMetrics{"vortexHasarli","Precision"};
apvh = metrics.ClassMetrics{"vortexHasarli","AP"};
figure('Name','Vortex Damage');
plot([recallvh{:}],[precisionvh{:}]);
% xlabel("Recall")
% ylabel("Precision")
% grid on
% title(["Average Precision = Vortex Damage", metrics.ClassMetrics.AP("vortexHasarli")])

% recallyl = metrics.ClassMetrics{"yagLekesi","Recall"};
% precisionyl = metrics.ClassMetrics{"yagLekesi","Precision"};
% ape = metrics.ClassMetrics{"yagLekesi","AP"};
% figure
% plot([recallyl{:}],[precisionyl{:}]);
% xlabel("Recall")
% ylabel("Precision")
% grid on
% title(["Average Precision = %.2f  yagLekesi", metrics.ClassMetrics.AP("yagLekesi")])

% recallyh = metrics.ClassMetrics{"yildirimHasari","Recall"};
% precisionyh = metrics.ClassMetrics{"yildirimHasari","Precision"};
% ape = metrics.ClassMetrics{"yildirimHasari","AP"};
% figure
% plot([recallyh{:}],[precisionyh{:}]);
% xlabel("Recall")
% ylabel("Precision")
% grid on
% title(["Average Precision = %.2f  yildirimHasari", metrics.ClassMetrics.mAP("yildirimHasari")])

% recallyc = metrics.ClassMetrics{"yuzeyCatlagi","Recall"};
% precisionyc = metrics.ClassMetrics{"yuzeyCatlagi","Precision"};
% ape = metrics.ClassMetrics{"yuzeyCatlagi","AP"};
% figure
% plot([recallyc{:}],[precisionyc{:}]);
% xlabel("Recall")
% ylabel("Precision")
% grid on
% title(["Average Precision = %.2f  yuzeyCatlagi", metrics.ClassMetrics.mAP("yuzeyCatlagi")])
