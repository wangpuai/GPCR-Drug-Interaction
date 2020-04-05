function framents = code_split_sequence(sequence, AV, m, d)
% Code the string sequence by Attribute Value, then split the coded 
% sequence into framents with length d
%
% Input:
%   sequence - string sequence
%   AV - Attribute Value of chars in the string sequence
%   m - number of framents created expectantly
%   d - length of framents
% Output:
%   num - number of framents created actually, <= m
%   framents - A num*d matrix include all the fragments sampled from the coded sequence

L = length(sequence);

% code the string sequence by AV
codedSeq = zeros(1,L);    % initialize the coded sequence
for i = 1:L
    ind = Amino2Index(sequence(i));
    codedSeq(i) = AV(ind);
end

% split the coded sequence, and create fragments
maxVal = L - d + 1;
if m >= maxVal
    start_points = 1:maxVal;
else
    start_points = randperm(maxVal, m);  % m unique integers selected randomly from 1 to maxVal inclusive
end

num = length(start_points);   % # of framents created actually, <= m
framents = zeros(num, d);
for i = 1:num
    framents(i,:) = codedSeq( start_points(i) : start_points(i)+d-1 );
end

end