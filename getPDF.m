function result = getPDF(data)
    meaner = mean(data,1);
    stder = std(data,0,1);
%     std = ((data - repmat(mean, [size(data, 1) 1])) .^ 2);
%     std = sum(std, 1) / size(data, 1);
%     std = sqrt(std);
    result = vertcat(meaner, stder);
end