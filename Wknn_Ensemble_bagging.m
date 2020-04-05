% Cross-validation and Independent test with the bagging distance-weighted knn(DWKNN)
% Nindex=5£¬Ne=4£¬Cl=[20,20,30,58]£¬RD(p=0.05)

clear;
disp('=====================================================================')

%%
disp('Creating sample matrix ...')
% load data
load('data.mat')   % GPCRs, Drugs, D92M, Check390
AAindexGroup = xlsread('AAindex.xlsx');  % double matrix

numAAindex = 5;
numEngine = 4;
Ks = unidrnd(15, numAAindex, numEngine);  % random K value in each classifier
trainSamplesCell = cell(numAAindex, numEngine);
testSamplesCell = cell(numAAindex, numEngine);
wordbookCell = cell(numAAindex, numEngine);  % col_idx{i,j}
col_idx_cell = cell(numAAindex, numEngine);
for i = 1:numAAindex
    AAindex = AAindexGroup(i,:);
    for j = 1:numEngine
        wordbookCell{i,j} = create_wordbook_fun(GPCRs, AAindex);
        normFlag = 1;
        featureMap = create_feature_vector(GPCRs, Drugs, AAindex, wordbookCell{i,j}, normFlag);
        % create sample matrix of trainging and testing datasets
        featureType = 5;
        [D92M_sample, D92M_label] = create_sample_matrix(D92M, featureMap, featureType, GPCRs, Drugs);
        [Check390_sample, Check390_label] = create_sample_matrix(Check390, featureMap, featureType, GPCRs, Drugs);
        
        trainSamplesCell{i,j} = D92M_sample;
        testSamplesCell{i,j} = Check390_sample;
        
        if i==1 && j==1
            trainLabels = D92M_label;
            trainLabels(trainLabels==0) = 2;  % adapt to DWknn
            testLabels = Check390_label;
            testLabels(testLabels==0) = 2;    % adapt to DWknn
        end
        clear D92M_sample Check390_sample D92M_label Check390_label
    end
end

save trainData.mat AAindexGroup wordbookCell trainSamplesCell trainLabels Ks
disp('Creating sample matrix finished.')
%% Get the outputs of all base learners
r = 2;   % the order of Minkowski distance
nfold = 5;  % Cross validation. length(trainLabels) for LOOCV
CVP = cvpartition(length(trainLabels),'kfold',nfold);
outputs_CV = cell(numAAindex, numEngine);  % outputs of cross-validation
outputs_IT = cell(numAAindex, numEngine);  % outputs of independent test
metrics_CV = cell(numAAindex, numEngine);
for i = 1:numAAindex
    for j = 1:numEngine
        trainSamples = trainSamplesCell{i,j};
        testSamples = testSamplesCell{i,j};
        
        % randomly discard features with a probability of 0.05 (RD)
        col_idx = rand(1,size(trainSamples,2))>=0.05;
        trainSamples = trainSamples(:,col_idx);
        testSamples = testSamples(:,col_idx);
        
        % normalize the training and testing datasets
        method = 'minmax';
        [trainSamples, ps] = NormTrainData(trainSamples, method);
        testSamples = NormTestData(testSamples, method, ps);
        
        [metrics_CV{i,j}, outputs_CV{i,j}] = DWknnCV(trainSamples, trainLabels, CVP, Ks(i,j), r);
        [~, outputs_IT{i,j}] = DWknn(trainSamples, trainLabels, testSamples, Ks(i,j), r);
    end
end

%% get the final outputs by averaging all the outputs of base learners
Ave_outputs_CV = zeros(size(outputs_CV{1,1}));
Ave_outputs_IT = zeros(size(outputs_IT{1,1}));
for i = 1:numAAindex
    for j = 1:numEngine
        Ave_outputs_CV = Ave_outputs_CV + outputs_CV{i,j};
        Ave_outputs_IT = Ave_outputs_IT + outputs_IT{i,j};
    end
end
Ave_outputs_CV = Ave_outputs_CV ./ (numAAindex*numEngine);
Ave_outputs_IT = Ave_outputs_IT ./ (numAAindex*numEngine);

[~,Pred_CV] = max(Ave_outputs_CV,[],2);    % numTrain¡Á1
[~,Pred_IT] = max(Ave_outputs_IT,[],2);    % numTest¡Á1

ensemble_metrics_CV = myEvaluate(trainLabels, Pred_CV)
ensemble_metrics_IT = myEvaluate(testLabels, Pred_IT)
