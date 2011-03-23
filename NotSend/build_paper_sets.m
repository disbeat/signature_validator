load 'images_data.mat'

train_set = images_data(1 : 20, 2 : end);
test_set = images_data(21 : 24, 2 : end);

genuine_set = find(images_data(:,end) == 1);


sig = randi(size(genuine_set,1),1, 172);
sig2 = randi(size(genuine_set,1),1, 860);

for i = 1 : length(sig)
	train_set = [train_set; images_data(sig(i), 2: end)];
end


for i = 1 : length(sig2)
	test_set = [test_set; images_data(sig2(i), 2: end)];
end

train_set = [train_set; images_data(25:29,2:end)];

test_set = [test_set; images_data(30:54,2:end)];

train_struct = stprstruct(train_set);
test_struct = stprstruct(test_set);

rbf_classifier(train_struct, test_struct)
