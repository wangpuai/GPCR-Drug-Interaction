function centroids = create_centroids(sequences, av, num_sample, len, k, times, flag)
% Code the sequences by the attribute values, then cluster the
% framents sampled from the coded sequences to creat centroids
%
% Input:
%   sequences - a cell including the string sequences
%   av - a vector including the attribute values of chars in the string sequence
%   num_sample - number of framents sampled from each sequence expectantly
%   len - length of framents
%   k - number of clusters
%   times - times of clustering to find a lower cost
%   flag - logical value for whether to plot
% Output:
%   centroids - centroids clustered from the mapData


% create framents from sequneces ------------------------------------------
FragMat = [];   % matrix including all the framents sampled from the input sequences
for i = 1:length(sequences)
    seq = standardize_sequence(sequences{i});
    framents = code_split_sequence(seq, av, num_sample, len);
    FragMat = [FragMat; framents];
end

% clustering the framents -------------------------------------------------
[label, centroids, J] = k_means(FragMat, k);
while any(isnan(centroids(:)))
    disp('There are NaN values in centroids.');
    [label, centroids, J] = k_means(FragMat, k);
end
% random start to find the lower cost
if times>0
    for i = 1:times
        [tmp_label, tmp_centroids, tmp_J] = k_means(FragMat, k);
        if any(isnan(tmp_centroids(:)))
            continue;
        end
        if tmp_J(end) < J(end)
            disp('Find better clustering with lower cost.');
            label = tmp_label;
            centroids = tmp_centroids;
            J = tmp_J;
        end
    end
end
% Show the cost values with respect to the training step
if flag
    figure, plot(J)
    xlabel('Step')
    ylabel('Cost')
    grid on
    % Show the fragments and centroids
    if len==2
        show_samples(FragMat', label)
        xlabel('x_1')
        ylabel('x_2')
        hold on
        scatter(centroids(:,1), centroids(:,2), 108, 'k*');
        hold off
    end
end

end
