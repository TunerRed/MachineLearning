function [ delta ] = fun_delta( Xi,Yi,a,kind )
%DELTA 此处显示有关此函数的摘要
delta=0;
if(kind==1 || kind==2)
    delta=(a'*Xi(:,:)'/norm(Xi(:,:)')^2*Xi(:,:)');
elseif(kind==3)
    delta=sum(Xi)*(Yi(1,1)-fun_ja_1(Xi,Yi,a));
end
end

