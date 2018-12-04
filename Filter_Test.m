% Sifei Liu, 10/04/2016
% sliu32@ucmerced.edu
% Learn any type of image filters.
% FILTER_TYPE: supports the following methods:
%               'L0', 'shock', 'wls', 'WMF', 'RTV', 'RGF'
% TEST_IMAGE:  an rgb image.
% Solver:      solver configures and model parameters
% this version supports LRNN_v1.prototxt; in order to apply 
% LRNN_v2.prototxt u need to change "Gen_testing_data_v1" in line 26 to 
% "Gen_testing_data_v2"
function dehazed= Filter_Test(TEST_IMAGE, Solver)
% Solver = testdataconfig(Solver, TEST_IMAGE);
% Solver.height = size(TEST_IMAGE, 1);
% Solver.width = size(TEST_IMAGE, 2);

[batch, gt] = Gen_test_data( Solver, TEST_IMAGE );
batchc = {single(batch)};
fprintf('FP test image...\n');
tic
active = Solver.Solver_.net.forward(batchc);
toc
weights = Solver.Solver_.net.get_weights();
data = Solver.Solver_.net.get_data();
diff = Solver.Solver_.net.get_diff();

disp(length(active))
for c = 1:length(active)
    active_ = active{c};
    if size(active_,3) == 3
    [dehazed,psnrs] = showresults(active_, batch(:,:,1:3,:), gt);
    end
end
%figure(1); imshow([gt(:,:,:,1), hazyimgs(:,:,:,1), active_(:,:,:,1)])
fprintf('PSNR: %d\n',psnrs);
end