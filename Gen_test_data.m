function [batch, gt] = Gen_test_data(Solver, TEST_IMAGE)
% use gt folder
% revers gradients as a supervision info
img = imresize(im2double(TEST_IMAGE),[Solver.patchsize, Solver.patchsize]);
batch = zeros(Solver.patchsize, Solver.patchsize, 3, Solver.batchsize);
gt = zeros(Solver.patchsize, Solver.patchsize, 3, Solver.batchsize);

%    img = img(11:end-10, 11:end-10, :);


    
    batch(:,:,:) = img;


   
    gt(:,:,:) = img;

end
