function Solver = usePreTrainedNetwork(Solver)
%%%%%% use it before 1st iteration in train
w1 = Solver.Solver_.net.get_weights();
w2 = load('/llight_ps384_bs1.mat'); 
w2 = w2.weight;
w1(1).weights = w2(1).weights;
w1(2).weights = w2(2).weights;
w1(3).weights = w2(3).weights;
w1(end-2).weights = w2(end-2).weights;
w1(end-1).weights = w2(end-1).weights;
w1(end).weights = w2(end).weights;
Solver.Solver_.net.set_weights(w1);