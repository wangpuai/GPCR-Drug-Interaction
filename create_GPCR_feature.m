function featureVec = create_GPCR_feature(sequence, attr, centroidsCell, normFlag)
% Create feature vector of amino acid sequence.
% Input:
%   sequence - Amino acid sequence
%   attr - attribute values of standard amino acid
%   centroidsCell - cell array of centroids
%   normFlag - flag of if normlize the feature vector
% Output:
%   featureVec - feature vector of the input sequence

sequence = standardize_sequence(sequence);
L = length(sequence);
codedSeq = zeros(1,L);
for i = 1:L
    idx = Amino2Index(sequence(i));
    codedSeq(i) = attr(idx);
end

featureVec = [];
% for each type of centroids, do ...
for i = 1:length(centroidsCell)
    centroids = centroidsCell{i};
    [c,d] = size(centroids);
    vec = zeros(1,c);
    num = L - d + 1;  % number of fragments in sequence
    % for each fragment, do ...
    for j = 1:num
        frag = codedSeq(j:j+d-1);
        dist = pdist2(frag, centroids);
        [~, idx] = min(dist);
        vec(idx) = vec(idx) + 1;
    end
    if normFlag
        featureVec = [featureVec, vec/num];
    else
        featureVec = [featureVec, vec];
    end
end

end