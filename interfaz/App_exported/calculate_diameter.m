function diameter = calculate_diameter(bwselected)
    diameter = 0;
    for i = 1:90
        bwrot = imrotate(bwselected,-i,'Bilinear','Crop');
        maxsumin = 0;
        for j = 1:width(bwrot)
               linearsum = sum(bwrot(:,j));
               if linearsum > maxsumin
               maxsumin = linearsum;
               end
        end
        if maxsumin > diameter
        diameter = maxsumin;
        end
    end
end