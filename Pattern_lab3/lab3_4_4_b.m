function  lab3_4_4_b(w2)
    %�ڶ��ʣ�w2,[x1,x2],n��������
[rows,~]=size(w2);
p=zeros(100,100);
%����n(n=100*100)������������
x=(-2.95:0.05:2);
y=(0.04:0.04:4);
distance=zeros(size(p,1),size(p,1),rows);
for i=1:1:size(p,1)
    for j=1:size(p,1)
        for k=1:rows
            %���� sqrt[(x-x1)2+(y-y1)2]
            distance(i,j,k)=sqrt((x(i)-w2(k,1))^2+(y(j)-w2(k,2))^2);
        end
    end
end
k=[1,2,5];
for index=1:size(k,2)
    for i=1:size(x,2) 
        for j=1:size(y,2) 
            dist_sort=sort(distance(i,j,:)); %����
            %eps:MATLAB�е���С����
            %p(x)=k/n/V
            %���V=pi*r2
            p(i,j)=k(index)/rows/(pi*dist_sort(k(index))^2); 
        end
    end
    subplot(1,3,index);
    mesh(x,y,p);
end
end

