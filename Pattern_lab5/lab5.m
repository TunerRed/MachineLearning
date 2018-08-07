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

studyRate1 = 0.3;
studyRate2 = 0.4;
middle = 30;
input = zeros(1,28*28);
outMiddle = zeros(1,middle);
outFinal = zeros(1,10);
s_outFinal = zeros(1,10);
%正态（高斯）分布的随机数生成器，normrnd(a,b,c,d)：产生均值为a、方差为b大小为cXd的随机矩阵
w1 = normrnd(0,0.5,28*28,middle);
w2 = normrnd(0,0.5,middle,10);
b1 = normrnd(0,0.2,1,middle);
b2 = normrnd(0,0.2,1,10);

disp('-----training-----');
disp(['rate1:' num2str(studyRate1) ';rate2:' num2str(studyRate2) ';nodes:' num2str(middle)]);
%train
lope=0;
for index=1:size(trainImages,1)
    if(rem(index,trainCount/50)==0)
        lope = lope + 2;
        fprintf('%2d ',lope); 
        if(rem(lope,50) == 0 || index==trainCount)
            fprintf('\n');
        end
    end
    input = trainImages(index,:);
    Etotal = 1;
    whileLope = 0;
    while(Etotal > 0.1)
        whileLope = whileLope + 1;
        if(whileLope > 1000)
            break;
        end
        %正向运行计算数据
        outMiddle = input*w1+b1;
        for middleIndex=1:size(outMiddle,2)
            outMiddle(middleIndex) = exp(outMiddle(middleIndex))/(1+exp(outMiddle(middleIndex)));
        end
        outFinal = outMiddle*w2+b2;
        for finalIndex=1:10
            outFinal(finalIndex) = exp(outFinal(finalIndex))/(1+exp(outFinal(finalIndex)));
        end
        y=zeros(1,10);
        y(trainLabels(index,1)+1)=1;
        s_outFinal = -(y-outFinal).*outFinal.*(1-outFinal);
        Etotal = sum((y-outFinal).*(y-outFinal),2)/2;
        %反向BP更新权值
        w2 = w2 - studyRate2*(outMiddle'*s_outFinal);
        w1 = w1-studyRate2*input'*((w2*s_outFinal')'.*outMiddle.*(ones(1,size(outMiddle,2))-outMiddle));
    end
end

disp('-----testing-----');

%test
rightCount = 0;
for index=1:size(testImages,1)
    input = testImages(index,:);
    %正向运行计算数据
    outMiddle = input*w1+b1;
    for middleIndex=1:size(outMiddle,2)
        outMiddle(middleIndex) = exp(outMiddle(middleIndex))/(1+exp(outMiddle(middleIndex)));
    end
    outFinal = outMiddle*w2+b2;
    maxIndex=find(outFinal==max(max(outFinal)));
    if(maxIndex==(testLabels(index,1)+1))
        rightCount = rightCount + 1;
    end
end
rightRate = rightCount / size(testImages,1);
disp('-----finished-----');
disp(['right:' num2str(100*rightRate) '%']);