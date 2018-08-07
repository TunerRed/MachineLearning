function [ output_args ] = lab3_4_4_c( w )
x=[-0.41,0.82,0.88;
    0.14,0.72,4.1;
    -0.81,0.61,-0.38];
distance=zeros(3,10,3);
for i=1:3
    for j=1:3
        selected = w(:,4)==j;
        w3 = w(selected,1:3);
        for k=1:10
            distance(j,k,i)=sqrt((x(i,1)-w3(k,1))^2+(x(i,2)-w3(k,2))^2+(x(i,3)-w3(k,3))^2);
        end
    end
end
dist_sort=sort(distance,2);
k=3;
p=zeros(3,3);
for i=1:3
    for j=1:3
        p(i,j)=k/10/(4*3.14*dist_sort(j,k,i)^3/3);
    end
end
for i=1:3
     display([' [',num2str(x(i,:)),'] £º',num2str(p(i,:))]);
end
end

