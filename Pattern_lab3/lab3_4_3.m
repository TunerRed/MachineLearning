%load lab3_data.xlsx as lab3data
x = [[0.5,1.0,0]
    [0.31,1.51,-0.5]
    [-0.3,0.44,-0.1]];
h=1;
test_size = 3;
for i=1:test_size
    r=lab3_4_3_parzen(lab3data,h,x(i,:),test_size);
    result=find(r==max(r));
    disp(['result of test',num2str(i),':',num2str(result)]);
    disp(['p(x):',num2str(r)]);
end