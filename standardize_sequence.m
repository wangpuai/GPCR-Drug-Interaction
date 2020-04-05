function sequence = standardize_sequence(sequence)
% remove the non-standard amino acid in the sequence.

SAA = 'ARNDCQEGHILKMFPSTWYV';  % 20 standard amino acid
L = length(sequence);
for i = L:-1:1
    if ~contains(SAA, sequence(i))
        sequence(i) = [];
    end
end

end