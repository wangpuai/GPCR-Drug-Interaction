function [samples, labels] = create_sample_matrix(dataset, featureMap, featureType, AAseqs, Drugs)
% Create sample matrix and label vector of dataset

% if featureType<4 && nargin<4
%     error('You have to input the amino acid sequences to get the amino acid composition or dipeptide composition.')
% end
num_pos = length(dataset.Interact);
num_neg = length(dataset.NonInteract);
labels = [ones(num_pos,1); zeros(num_neg,1)];
samples = [];
% for each positive sample, do ...
for i = 1:num_pos
    AAseq_header = dataset.Interact(i).GPCR;
    drug_header = dataset.Interact(i).DRUG;
    switch featureType
        case 1
            vec = [AAComposition(AAseqs(AAseq_header))', featureMap(drug_header)];
        case 2
            vec = [DPComposition(AAseqs(AAseq_header))', featureMap(drug_header)];
        case 3
            vec = [AAComposition(AAseqs(AAseq_header))', DPComposition(AAseqs(AAseq_header))', featureMap(drug_header)];
        case 4
            vec = [featureMap(AAseq_header), featureMap(drug_header)];
        case 5
            vec = [AAComposition(AAseqs(AAseq_header))', featureMap(AAseq_header), featureMap(drug_header)];
        case 6
            vec = [AAComposition(AAseqs(AAseq_header))', featureMap(AAseq_header), myStr2num(Drugs(drug_header),0)];
    end
    samples = [samples; vec];
end
% for each negative sample, do ...
for i = 1:num_neg
    AAseq_header = dataset.NonInteract(i).GPCR;
    drug_header = dataset.NonInteract(i).DRUG;
    switch featureType
        case 1
            vec = [AAComposition(AAseqs(AAseq_header))', featureMap(drug_header)];
        case 2
            vec = [DPComposition(AAseqs(AAseq_header))', featureMap(drug_header)];
        case 3
            vec = [AAComposition(AAseqs(AAseq_header))', DPComposition(AAseqs(AAseq_header))', featureMap(drug_header)];
        case 4
            vec = [featureMap(AAseq_header), featureMap(drug_header)];
        case 5
            vec = [AAComposition(AAseqs(AAseq_header))', featureMap(AAseq_header), featureMap(drug_header)];
        case 6
            vec = [AAComposition(AAseqs(AAseq_header))', featureMap(AAseq_header), myStr2num(Drugs(drug_header),0)];
    end
    samples = [samples; vec];
end

end
