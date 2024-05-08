function bwselected = selectseg(bw)
    statsd = regionprops(bw,'Circularity','Centroid',"Area","BoundingBox","Perimeter","Eccentricity");
    dotper = cat(1,statsd.Perimeter);
    dotarea = cat(1,statsd.Circularity);
    dotcirc = cat(1,statsd.Area);
    dotecc = cat(1,statsd.Eccentricity);
    compcirc=isinf(dotcirc)==0;
    dotcirc=dotcirc.*compcirc;
    dotarea=dotarea.*compcirc;
    dotper=dotper.*compcirc;
    dotecc=dotecc.*compcirc;
    dotcircnorm = dotcirc/max(dotcirc);
    L=0;
    x = 1;
    for j = 1:height(dotcircnorm)
        if dotcircnorm(j) < 0.5
            L(x) = j;
            x = x+1;
        end
    end
    dotcircnorm(dotcircnorm<0.5) = [];
    if L~=0
        dotarea(L,:) = [];
        dotper(L,:) = [];
        dotecc(L,:) = [];
    end
    [~,idx] = max(dotarea);
    label_circ = dotarea(idx);
    label_area = dotcirc(idx);
    label_per = dotper(idx);
    label_ecc = dotecc(idx);
    ratios = label_circ.*(label_area./(label_per.*label_ecc));
    [~,ratio_idx] = max(ratios);
end