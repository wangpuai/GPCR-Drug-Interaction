function featureMap = create_feature_vector(GPCRs, Drugs, AAindex, centroids, normFlag)
% Create feature vectors of GPCR sequences and DRUG fingerprints, and save them in a Map
% normFlag: flag of if normlize the feature vector, 0 or 1

featureMap = containers.Map;
headers_GPCR = keys(GPCRs);
% for each GPCR, do ...
for i = 1:length(headers_GPCR)
    key = headers_GPCR{i};
    value = create_GPCR_feature(GPCRs(key), AAindex, centroids, normFlag);
    featureMap(key) = value;
end

headers_Drug = keys(Drugs);
% for each Drug, do ...
for i = 1:length(headers_Drug)
    key = headers_Drug{i};
    value = create_DRUG_feature(Drugs(key), normFlag);
    featureMap(key) = value;
end

end