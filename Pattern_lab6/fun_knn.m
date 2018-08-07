disp('-----knn-----');
for index = 1:testCount
    knn_single = zeros(1,trainCount);
    for trainIndex = 1:trainCount
        temp = abs(testImages(index,:) - trainImages(trainIndex,:));
        for dimensionIndex = 1:28*28 
            if (temp(1,dimensionIndex)<=0.3)
                knn_single(1,trainIndex) = knn_single(1,trainIndex) + 1;
            end
        end
    end
    cols = zeros(1,6);
    for i = 1:size(cols,2)
        temp =  find(knn_single==max(knn_single));
        cols(1,i) = temp(1);
        knn_single(cols(1,i)) = 0;
    end
    knn_single = zeros(1,10);
    for i = 1:size(cols,2)
        knn_single(trainLabels(cols(1,i)) + 1) = knn_single(trainLabels(cols(1,i)) + 1) + 1;
    end
    temp = find(knn_single==max(knn_single));
    result_knn(index) = temp(1) - 1;
end