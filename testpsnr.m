function [mpsnr, mssim] = testpsnr(iter, testnum)

addpath(genpath('/home/vision/wren/caffe-dilate/'))
caffe.reset_all();

img_path = ('/home/vision/wren/data/deblur/GLR/test_pub/bsd100gaublur1.2noise1/');

blur_data = dir(fullfile(img_path, '*_batch.png'));
gt_data = dir(fullfile(img_path, '*_gt.png'));
ker_data = dir(fullfile(img_path, '*_kernel.png'));


model_path = 'models/';
%iter = 5000;

solver_file = fullfile(model_path, 'llight_solver_test.prototxt');
save_file = fullfile(model_path, 'llight_ps256_bs1.mat');


Solver = modelconfig_test(solver_file, save_file, iter);


if ~exist('testnum', 'var')
   testnum = length(blur_data);
end

% mkdir(strcat('SOTSindoor_results/results', num2str(iter)));
psnrs=0;
ssims=0;
load ('GSVDgaudisk.mat');
for i = 1:testnum %length(hazy_data)
    i
    clear batch active
    blurimg = im2double(imread(fullfile(img_path,blur_data(i).name)));
    gtimg = im2double(imread(fullfile(img_path, gt_data(i).name)));
    
    kernel = im2double(imread(fullfile(img_path, ker_data(i).name)));
    kernel = kernel / sum(kernel(:));
    kernelF = psf2otf(kernel, [151,151]);
    kernel = otf2psf(kernelF);
    IKernelF = conj(kernelF) ./ (conj(kernelF).*kernelF + 1/100);
    IKernel = otf2psf(IKernelF); 
    IKernel = L*L'*IKernel*R*R';    
    IKernel = IKernel / sum(IKernel(:));    %% estimated shrinked inverse kernel
    M = L'*IKernel*R;
    
    weights = Solver.Solver_.net.get_weights();
    for k = 1:50
        for j = 1:50
            weights(2).weights{1,1}(1,1,k,j) = M(k, j);
        end
    end
    Solver.Solver_.net.set_weights(weights);
    
    

    [row, col, cha] = size(blurimg);



    batchc1 = {single(blurimg(:,:,1))};
    batchc2 = {single(blurimg(:,:,2))};
    batchc3 = {single(blurimg(:,:,3))};
    
    Solver.Solver_.net.blobs('data').reshape([row, col, 1, 1]);

    tic
    activec(:,:,1) = Solver.Solver_.net.forward(batchc1);
    activec(:,:,2) = Solver.Solver_.net.forward(batchc2);
    activec(:,:,3) = Solver.Solver_.net.forward(batchc3);
    toc
    
%     num_output = length(activec);
    active(:,:,1)= activec{1};
    active(:,:,2)= activec{2};
    active(:,:,3)= activec{3};
    
%    figure(2);imshow(active)
    [psnr, ssim] = V5_showresults(active, gtimg);
    psnrs = psnrs + psnr;
    ssims = ssims + ssim;
%    imwrite(active, strcat('./syn_results/results',num2str(iter), '/', hazy_data(i).name(1:end-4),'_dehazed.png'))
end

mpsnr = psnrs/testnum;
mssim = ssims/testnum;

