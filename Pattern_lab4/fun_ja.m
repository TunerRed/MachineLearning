function [ ja ] = fun_ja( Xi,Yi,a,kind )

ja=0;
if(kind==1 || kind==2)
    ja=(a'*Xi(:,:)')^2/(2*norm(Xi(:,:)')^2);    
elseif(kind==3)
    e=exp(sum(a(2:size(a,1)).*Xi'));
    ja=e/(1+e);
end
end

