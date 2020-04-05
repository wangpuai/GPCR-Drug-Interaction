function [labels, centroids, J] = k_means(X, k)
% K-means clustering algorithm
%   X: m×n data matrix, m samples and n dimensions
%   k: number of classes
%   labels: m×1 label vector
%   centroids: k×n, k clustering centroids
%   J: criterion function, J = 1/m * ∑norm(x-μ)^2

tol = 1e-10;
maxiter = 500;  % 最大迭代次数
J = inf(1,maxiter);  % 准则函数初始化
[m,n] = size(X);
labels = ones(m,1);

% 1.随机选取k个点作为起始聚类中心
centroids = X(randsample(m,k),:);   % k×n
% 2.随机生成k个点作为起始聚类中心
% centroids = zeros(k,n);
% minimum = min(X);
% maximum = max(X);
% for i = 1:n
%     centroids(:,i) = unifrnd(minimum(i), maximum(i), k, 1);
% end

converged = false;
t = 1;
while ~converged && t<maxiter
    t = t+1;
    % compute cluster assignments
    for i = 1:m
        dists = sum((repmat(X(i,:), k, 1) - centroids).^2, 2);
        [~, labels(i)] = min(dists);
    end
    % compute cluster centroids
    for i = 1:k
        centroids(i,:) = mean(X(labels == i, :));
    end
    % compute J
    J(t) = sum(sum((X-centroids(labels,:)).^2, 2))/m;
    converged = J(t-1)-J(t) < tol*J(t);
end
if J(t-1)-J(t) < 0
    error('ERROR: The criterion function is ascending');
end
J = J(2:t);
if converged
    fprintf('Converged in %d steps.\n', t-1);
else
    fprintf('Not converged in %d steps.\n', maxiter);
end

end
