function [result, prob] = test_example(type, idx)
load('data.mat')  % GPCRs, Drugs, D92M, Check390

switch type
    case 1
        gpcr_header = Check390.Interact(idx).GPCR;
        drug_header = Check390.Interact(idx).DRUG;
    case 2
        gpcr_header = Check390.NonInteract(idx).GPCR;
        drug_header = Check390.NonInteract(idx).DRUG;
end
disp(['GPCR: ', gpcr_header])
disp(['Drug: ', drug_header])
gpcr_sequence = GPCRs(gpcr_header);
drug_fp2 = Drugs(drug_header);

[result, prob] = main_predictor(gpcr_sequence, drug_fp2);

end