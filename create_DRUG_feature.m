function featureVec = create_DRUG_feature(strSeq, normFlag)
% create the drug features based on the fingerprints
% INPUT:
%   strSeq - the fingerprint of one drug
%   normFlag - flag of if normlize the feature vector
% OUTPUT:
%   featureVec - row vector of the input fingerprint based on DFT

S = myStr2num(strSeq,0);  % no normalization
L = length(S);
Y = fft(S);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
featureVec = P1(1:end-1);
if normFlag
    featureVec = featureVec/sum(featureVec);
end

end

