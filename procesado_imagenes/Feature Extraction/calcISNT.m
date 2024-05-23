function ISNT = calcISNT(bwseg,centre,I)
if centre(2) > (width(I)/2)
    rightside = false;
else
    rightside = true;
end
if ~islogical(bwseg)
    bwseg = logical(bwseg);
end
col = centre(2);
row = centre(1);
if rightside == true
    T = sum(bwseg(row,col:-1:1));
    N = sum(bwseg(row,col:1:width(bwseg)));
else
    N = sum(bwseg(row,col:-1:1));
    T = sum(bwseg(row,col:1:width(bwseg)));
end
I = sum(bwseg(row:1:height(bwseg),col));
S = sum(bwseg(row:-1:1,col));
if (I >= S) & (S >= N) & (N >= T)
    ISNT = 1;
else
    ISNT = 0;
end