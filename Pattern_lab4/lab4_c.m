load lab4.mat;
%�淶������Y
rows = 10;
one=ones(rows,1);
X=[w1;w3];
Y=[one;-1*one];

%��ʼ��Ȩ����a����ֵtheta����ʼѧϰ��s
%�ݶ��½���ʹ���ɳ��㷨��׼����
counts=zeros(1,100);
theta=0.01;
kind=1;
for s=0.01:0.02:2
    a=[1;1];
    count_temp=0;
    while(1)
        delta=0;
        count_temp = count_temp +1;
        for i=1:2*rows
            if((Y(i,1)==1 && a'*X(i,:)'<=0) || (Y(i,1)==-1 && a'*X(i,:)'>0))
                delta=delta+s*fun_delta(X(i,:),Y(i,1),a,kind);
            end
        end
        a=a-delta;    %����a
        if(norm(delta)<theta)
            break;
        end
        if(count_temp>10000)
            break;
        end
    end
    counts(1,uint8(s*50))=count_temp;
end

plot(0.01:0.02:2,counts(1,1:100),'g');
hold on;