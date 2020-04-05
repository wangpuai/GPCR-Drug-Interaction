# GPCR-Drug-Interaction
Identifying GPCR-Drug interaction based on wordbook learning from sequences

You can use main_predictor function to get the GPCR-Drug interaction result as following
[result, prob] = main_predictor(GPCRseq, DRUGfp2)
% Input the GPCR primary sequence and the Drug fp2 fingerprint, then you will get their interaction result and probability.

You can also run the Wknn_Ensemble_bagging file to check out the cross-validation and independent test results.
