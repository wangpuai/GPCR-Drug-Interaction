function centroids = create_wordbook_fun(GPCRs, AAindex)
% Create wordbook by clustering fragments with different length

sequences = values(GPCRs);  % get all values in Map

num = 1200;    % number of framents sampled from each sequence expectantly
times = 0;     % times of clustering to find a lower cost
flag = 0;      % logical value for whether to plot
lens = [2, 3, 4];   % length of framents
Cs = [20, 30, 58];  % number of centroids to cluster for each length of framents
% Cs = Cs + (unidrnd(5, 1, 3) - 3);
centroids = cell(1,length(lens));
% for each length, do ...
for i = 1:length(lens)
    len = lens(i);
    C = Cs(i);
    disp('---------------------------------------------')
    fprintf('Creating %d-D centroids ...\n', lens(i));
    centroids{i} = create_centroids(sequences, AAindex, num, len, C, times, flag);
end

end