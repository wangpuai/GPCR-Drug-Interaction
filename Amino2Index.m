function i = Amino2Index(amino)
switch amino
    case {'A', 'a'}
        i=1;
    case {'C', 'c'}
        i=2;
    case {'D', 'd'}
        i=3;
    case {'E', 'e'}
        i=4;
    case {'F', 'f'}
        i=5;
    case {'G', 'g'}
        i=6;
    case {'H', 'h'}
        i=7;
    case {'I', 'i'}
        i=8;
    case {'K', 'k'}
        i=9;
    case {'L', 'l'}
        i=10;
    case {'M', 'm'}
        i=11;
    case {'N', 'n'}
        i=12;
    case {'P', 'p'}
        i=13;
    case {'Q', 'q'}
        i=14;
    case {'R', 'r'}
        i=15; 
    case {'S', 's'}
        i=16; 
    case {'T', 't'}
        i=17;
    case {'V', 'v'}
        i=18;
    case {'W', 'w'}
        i=19;
    case {'Y', 'y'}
        i=20; 
    otherwise
        i=21;
        disp('There are non-stardard amino acid in the sequence.')
end
