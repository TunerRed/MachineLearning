%load lab2_data as lab2data
w1=[];
w2=[];
c1=1;
c2=2;
selected = lab2data(:,4)==c1;
w1 = lab2data(selected,1:3);
selected = find(lab2data(:,4)==c2);
w2 = lab2data(selected,1:3);

%[result_u,result_o] = calculate(w1,[1],10);
%[result_u,result_o] = calculate(w1,[2],10);
%[result_u,result_o] = calculate(w1,[3],10);
%[result_u,result_o] = calculate(w1,[1,2],10);
%[result_u,result_o] = calculate(w1,[2,3],10);
%[result_u,result_o] = calculate(w1,[1,3],10);
%[result_u,result_o] = calculate(w1,[1,2,3],10);
%[result_u,result_o] = calculate(w2,[1,2,3],10);
