%load lab3_data.xlsx as lab3data
selected = lab3data(:,4)==2;
w2 = lab3data(selected,1:2);
selected = lab3data(:,4)==3;
w3 = lab3data(selected,1);

%lab3_4_4_a(w3);
%lab3_4_4_b(w2);
lab3_4_4_c(lab3data);