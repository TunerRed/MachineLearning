disp('-----loading-----');
allTrainImages = loadMNISTImages('train-images.idx3-ubyte');
allTrainImages = allTrainImages';
trainLabels = loadMNISTLabels('train-labels.idx1-ubyte');
allTestImages = loadMNISTImages('t10k-images.idx3-ubyte');
allTestImages = allTestImages';
testLabels = loadMNISTLabels('t10k-labels.idx1-ubyte');

trainCount = 60000;
testCount = 10000;
trainImages = allTrainImages(1:trainCount,:);
testImages = allTestImages(1:testCount,:);

%----------------------------------
%              决策树
%----------------------------------
disp('-----决策树-----');
tree = classregtree(trainImages,trainLabels(1:trainCount,:));
predict_label = treeval(tree,testImages);
%得到的结果是double型，这里采取四舍五入取整的方法
result_tree=roundn(predict_label,0);

%----------------------------------
%               SVM
%----------------------------------
disp('-----SVM-----');
model=svmtrain(trainLabels(1:trainCount,:),trainImages);
[predict_label, ~, ~] = svmpredict(testLabels(1:testCount,:), testImages, model);
result_svm = predict_label;

%----------------------------------
%             神经网络
%----------------------------------
disp('-----神经网络-----');
result_nerual = zeros(testCount,1);
studyRate1 = 0.3;
studyRate2 = 0.4;
middle = 15;
input_nerual = zeros(1,28*28);
outMiddle_nerual = zeros(1,middle);
outFinal_nerual = zeros(1,10);
s_outFinal_nerual = zeros(1,10);
%正态（高斯）分布的随机数生成器，normrnd(a,b,c,d)：产生均值为a、方差为b大小为cXd的随机矩阵
w1 = normrnd(0,0.5,28*28,middle);
w2 = normrnd(0,0.5,middle,10);
b1 = normrnd(0,0.2,1,middle);
b2 = normrnd(0,0.2,1,10);
%train
for index=1:size(trainImages,1)
    input_nerual = trainImages(index,:);
    Etotal = 1;
    whileLope = 0;
    while(Etotal > 0.1)
        whileLope = whileLope + 1;
        if(whileLope > 1000)
            break;
        end
        %正向运行计算数据
        outMiddle_nerual = input_nerual*w1+b1;
        for middleIndex=1:size(outMiddle_nerual,2)
            outMiddle_nerual(middleIndex) = exp(outMiddle_nerual(middleIndex))/(1+exp(outMiddle_nerual(middleIndex)));
        end
        outFinal_nerual = outMiddle_nerual*w2+b2;
        for finalIndex=1:10
            outFinal_nerual(finalIndex) = exp(outFinal_nerual(finalIndex))/(1+exp(outFinal_nerual(finalIndex)));
        end
        y=zeros(1,10);
        y(trainLabels(index,1)+1)=1;
        s_outFinal_nerual = -(y-outFinal_nerual).*outFinal_nerual.*(1-outFinal_nerual);
        Etotal = sum((y-outFinal_nerual).*(y-outFinal_nerual),2)/2;
        %反向BP更新权值
        w2 = w2 - studyRate2*(outMiddle_nerual'*s_outFinal_nerual);
        w1 = w1-studyRate2*input_nerual'*((w2*s_outFinal_nerual')'.*outMiddle_nerual.*(ones(1,size(outMiddle_nerual,2))-outMiddle_nerual));
    end
end
for index=1:testCount
    input_nerual = testImages(index,:);
    %正向运行计算数据
    outMiddle_nerual = input_nerual*w1+b1;
    for middleIndex=1:size(outMiddle_nerual,2)
        outMiddle_nerual(middleIndex) = exp(outMiddle_nerual(middleIndex))/(1+exp(outMiddle_nerual(middleIndex)));
    end
    outFinal_nerual = outMiddle_nerual*w2+b2;
    result_nerual(index,1) = find(outFinal_nerual==max(outFinal_nerual))-1;
end

%----------------------------------
%              投票
%----------------------------------
disp('-----投票中-----');
result_final = zeros(testCount,1);
for index = 1:testCount
    predict_label = zeros(10,1);
    predict_label(result_tree(index,1) + 1,1) = predict_label(result_tree(index,1) + 1,1) + 1;
    predict_label(result_svm(index,1) + 1,1) = predict_label(result_svm(index,1) + 1,1) + 1;
    predict_label(result_nerual(index,1) + 1,1) = predict_label(result_nerual(index,1) + 1,1) + 1;
    temp_max = find(predict_label==max(predict_label));
    if size(temp_max,1) > 1 || size(temp_max,2) > 1
        result_final(index,1) = result_svm(index,1);
    else
        result_final(index,1) = temp_max - 1;
    end
end

%----------------------------------
%              结果
%----------------------------------
disp('-----完成-----');
rightCount = 0;
for index = 1:testCount
    if testLabels(index,1) == result_final(index,1)
        rightCount = rightCount + 1;
    end
end
disp(['正确率 ： ',num2str(100*rightCount/testCount),'%']);