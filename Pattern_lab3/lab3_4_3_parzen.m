function r=lab3_4_3_parzen(w,h,x,classes)
%w ��ά���ݣ���һάһ�����ݣ��ڶ�άά��
%h �߳�
%x ����������
%classes �������Ĭ�ϴ�1��ʼ������
r=zeros(1,classes);
for i=1:classes
    selected = w(:,4)==i;
    w1 = w(selected,1:3);
    rows=size(w1,1);
    for j=1:rows
        hn=h/sqrt(j);
        r(i)=r(i)+exp(-(x-w1(j,:))*(x-w1(j,:))'/(2*power(hn,2)))/(sqrt(hn));
    end
    r(i)=r(i)/rows;
end

