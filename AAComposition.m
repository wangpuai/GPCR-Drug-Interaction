function AAC = AAComposition(AAS)
%把氨基酸序列(amino acid sequence)转换成20*1维氨基酸成分向量(amino acid composition vector)
type = 20;
count = zeros(type,1);
L = length(AAS);
for i = 1:L
    switch AAS(i)
        case {'A', 'a'}
            count(1) = count(1) + 1;
        case {'C', 'c'}
            count(2) = count(2) + 1;
        case {'D', 'd'}
            count(3) = count(3) + 1;
        case {'E', 'e'}
            count(4) = count(4) + 1;
        case {'F', 'f'}
            count(5) = count(5) + 1;
        case {'G', 'g'}
            count(6) = count(6) + 1;
        case {'H', 'h'}
            count(7) = count(7) + 1;
        case {'I', 'i'}
            count(8) = count(8) + 1;
        case {'K', 'k'}
            count(9) = count(9) + 1;
        case {'L', 'l'}
            count(10) = count(10) + 1;
        case {'M', 'm'}
            count(11) = count(11) + 1;
        case {'N', 'n'}
            count(12) = count(12) + 1;
        case {'P', 'p'}
            count(13) = count(13) + 1;
        case {'Q', 'q'}
            count(14) = count(14) + 1;
        case {'R', 'r'}
            count(15) = count(15) + 1;
        case {'S', 's'}
            count(16) = count(16) + 1;
        case {'T', 't'}
            count(17) = count(17) + 1;
        case {'V', 'v'}
            count(18) = count(18) + 1;
        case {'W', 'w'}
            count(19) = count(19) + 1;
        case {'Y', 'y'}
            count(20) = count(20) + 1;
    end
end
AAC = count/L;

end