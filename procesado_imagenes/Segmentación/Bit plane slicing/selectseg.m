function [bwselected,centre] = selectseg(bw)
    bw = bwlabel(bw);
    statsd = regionprops("table",bw,'Circularity','Centroid',"Area","BoundingBox","Perimeter","Eccentricity","PixelList");
    dotper = statsd.Perimeter;
    dotarea = statsd.Area;
    dotcirc = statsd.Circularity;
    dotecc = statsd.Eccentricity;
    compcirc=~isinf(dotcirc);
    dotcirc=dotcirc.*compcirc;
    dotarea=dotarea.*compcirc;
    dotper=dotper.*compcirc;
    dotecc=dotecc.*compcirc;
    dotareanorm = dotarea/max(dotarea);
    L=0;
    x = 1;
    for j = 1:height(dotareanorm)
        if dotareanorm(j) < 0.5
            L(x) = j;
            x = x+1;
        end
    end
    dotareanorm(dotareanorm<0.5) = [];
    if L~=0
        dotarea(L) = [];
        dotper(L) = [];
        dotecc(L) = [];
        dotcirc(L) = [];
        statsd(L,:) = [];
    end
    ratios = dotarea.*(dotcirc./(dotper.*dotecc));
    [~,ratio_idx] = max(ratios);
    pixels = cell2mat(statsd.PixelList(ratio_idx));
    bwselected = false(size(bw));
    bwselected(sub2ind(size(bw), pixels(:, 2), pixels(:, 1))) = true;
    bwselected = imclose(bwselected,strel('disk',20,8));
    centre = round(statsd.Centroid(ratio_idx,:));
end