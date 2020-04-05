function vec = myStr2num(Seq, normFlag)
% Convert the fingerprint of one drug to vector

n = length(Seq);
vec = zeros(1,n);
for i = 1:n
    switch Seq(i)
        case '0'
            vec(i) = 0;
        case '1'
            vec(i) = 1;
        case '2'
            vec(i) = 2;
        case '3'
            vec(i) = 3;
        case '4'
            vec(i) = 4;
        case '5'
            vec(i) = 5;
        case '6'
            vec(i) = 6;
        case '7'
            vec(i) = 7;
        case '8'
            vec(i) = 8;
        case '9'
            vec(i) = 9;
        case {'a', 'A'}
            vec(i) = 10;
        case {'b', 'B'}
            vec(i) = 11;
        case {'c', 'C'}
            vec(i) = 12;
        case {'d', 'D'}
            vec(i) = 13;
        case {'e', 'E'}
            vec(i) = 14;
        case {'f', 'F'}
            vec(i) = 15;
    end
end
if normFlag
    vec = vec/sum(vec);
end

end