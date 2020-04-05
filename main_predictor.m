function [result, prob] = main_predictor(GPCRseq, DRUGfp2)
% Input the GPCR primary sequence and the Drug fp2 fingerprint, then you
% will get their interaction result and probability.

load('trainData.mat')   % AAindexGroup wordbookCell trainSamplesCell trainLabels Ks
[numAAindex, numEngine] = size(trainSamplesCell);

GPCRseq = standardize_sequence(GPCRseq);
for i = 1:numAAindex
    for j = 1:numEngine
        % create test sample
        AAindex = AAindexGroup(i,:);
        wordbook = wordbookCell{i,j};
        gpcrVec = create_GPCR_feature(GPCRseq, AAindex, wordbook, 1);
        drugVec = create_DRUG_feature(DRUGfp2, 1);
        testSample = [AAComposition(GPCRseq)', gpcrVec, drugVec];
        
        % prediction
        trainSamples = trainSamplesCell{i,j};
        K = Ks(i,j);
        % randomly discard features with a probability of 0.05 (RD)
        col_idx = rand(1,size(trainSamples,2))>=0.05;
        trainSamples = trainSamples(:,col_idx);
        testSample = testSample(:,col_idx);
        % normalize the training and testing samples
        method = 'minmax';
        [trainSamples, ps] = NormTrainData(trainSamples, method);
        testSample = NormTestData(testSample, method, ps);
        % outputs of all base learners
        [~, outputCell{i,j}] = DWknn(trainSamples, trainLabels, testSample, K, 2);
    end
end
% average the outputs of all base learners
output = zeros(1,2);
for i = 1:numAAindex
    for j = 1:numEngine
        output = output + outputCell{i,j};
    end
end
% the probility belong to positive class
prob = output(1) / (numAAindex*numEngine);
% Predicted Label
if prob > 0.5
    result = 'Interaction';
else
    result = 'Non-interaction';
end

end