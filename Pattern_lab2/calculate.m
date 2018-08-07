function [ u,o2 ] = calculate( matrix, dim ,len)
%matrix ����
%dim ��һ�����飬���Ҫ�õ���ά��
%len ���ݵ�����
%   ��ʼ���̺ͦ�
    u=zeros(1,size(dim,2));
    o2=zeros(size(dim,2),size(dim,2));
    x = matrix(:,dim);
    for index = 1:len
        u = u + x(index,:);
    end
    u = u / len;
    for index = 1:len
        o2 = o2 + (x(index,:)-u)'*(x(index,:)-u);
    end
    o2 = o2 / len;
end

