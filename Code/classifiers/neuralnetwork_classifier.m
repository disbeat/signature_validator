function [ result ] = neuralnetwork_classifier( train_data, test_data )

    p1 = train_data.X;
    t1 = train_data.y;

    % Two-layer feed-forward network. Has one hidden layer with 1000 neurons
    net = newff(p1, t1, [500 1000], {}, 'traingdm');
    net.divideFcn = '';
    net.trainParam.show = 5;
    net.trainParam.epochs = 400;
    net.trainParam.goal = 1e-6;
    net = train(net, p1, t1);
    
    p2 = test_data.X;
    t2 = test_data.y;
    
    output = sim(net, p2);
    output = round(output);
    
    output(output < 1) = 999;
    
	result = performance(output, t2);

end
