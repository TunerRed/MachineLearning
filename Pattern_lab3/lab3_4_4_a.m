function  lab3_4_4_a(w3)
    %第一问，w3,x1,n个样本点
    [rows,~]=size(w3);
    p=zeros(1,300);
    %生成n(n=300)个测试样本点
    x=(0.01:0.01:3);
    distance=zeros(size(p,2),rows);
    for i=1:1:size(p,2)
        for j=1:rows
            %距离
            distance(i,j)=abs(x(i)-w3(j,1));
        end
    end
    dist_sort=sort(distance,2); %按行排序
    k=[1,2,5];
    for index=1:size(k,2)
        for i=1:size(x,2) 
            %eps:MATLAB中的最小正数（一维时必然会出现距离为0）
            %p(x)=k/n/V
            %体积V=2*length
            p(i)=k(index)/rows/(2*dist_sort(i,k(index))+eps); 
        end
        subplot(1,size(k,2),index);
        plot(x,p);
    end
end