function [ param ] = fun_param( Xi,a,s,H,kind )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
param=0;
if(kind==1)
    param=s;
elseif(kind==2)
    param=
    param = inv(param);
elseif(kind==3)
    param=zeros(size(Xi,1));
    for i=1:size(Xi,1)
        tem=fun_ja_1(Xi(i,:),0,a,2);
        param(i,i)=tem*(tem-1);
    end
end

end

