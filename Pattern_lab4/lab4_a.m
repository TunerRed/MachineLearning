load lab4.mat;
%规范化矩阵Y
rows = 10;
one=ones(rows,1);
X=[w1;w3];
Y=[one;-1*one];

%p=[0,1,0];
%scatter(X(1:10,1),X(1:10,2),20,p,'filled');
%hold on;
%p=[1,0,1];
%scatter(X(11:20,1),X(11:20,2),20,p,'filled');

%初始化权向量a，阈值theta，初始学习率s
a=[1;1];theta=0.01;s=0.1;
ja=ones(1,1000);
count=0;
kind=1;
%kind=1:梯度下降法使用松弛算法作准则函数
while(1)
    delta=0;
    count = count +1;
    for i=1:2*rows
        if((Y(i,1)==1 && a'*X(i,:)'<=0) || (Y(i,1)==-1 && a'*X(i,:)'>0))
            ja(1,count)=ja(1,count)+fun_ja(X(i,:),Y(i,1),a,kind);
            delta=delta+s*fun_delta(X(i,:),Y(i,1),a,kind);
        end
    end
    a=a-delta;    %更新a
    if(norm(delta)<theta)
        break;
    end
end
plot(1:count,ja(1,1:count),'g');
hold on;

%kind=2:牛顿法使用松弛算法作准则函数
a=[1;1];
kind=2;
ja=ones(1,1000);
count=0;
while(1)
    delta=0;
    H=0;
    count = count +1;
    for i=1:2*rows
        if((Y(i,1)==1 && a'*X(i,:)'<=0) || (Y(i,1)==-1 && a'*X(i,:)'>0))
            ja(1,count)=ja(1,count)+fun_ja(X(i,:),Y(i,1),a,kind);
            delta=delta+fun_delta(X(i,:),Y(i,1),a,kind);
            H=H+(X(i,:)'*X(i,:))/norm(X(i,:))^2;
        end
    end
    a=a-H\delta;    %更新a
    if(norm(delta)<theta)
        break;
    end
    if(count>=1000)
        break;
    end
end
plot(1:count,ja(1,1:count),'r');
hold on;