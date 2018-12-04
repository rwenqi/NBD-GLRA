function [mpsnr, mssim] = demo_testpsnr(iter,  img_path, pad, testnum)


caffe.reset_all();


blur_data = dir(fullfile(img_path, '*_batch.png'));
gt_data = dir(fullfile(img_path, '*_gt.png'));
ker_data = dir(fullfile(img_path, '*_kernel.png'));


model_path = 'models/';

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


pad_size = 55;
for i = 1: length(blur_data)
    clear batch
    blurimg_in = im2double(imread(fullfile(img_path,blur_data(i).name)));
    if pad
        blurimg = padarray(blurimg_in,[pad_size, pad_size],'replicate','both');
    else
        blurimg = blurimg_in;
    end
    
    
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


    for cha = 1:3
        batchc = {single(blurimg(:,:,cha))};
        Solver.Solver_.net.blobs('data').reshape([row, col, 1, 1]);
        tic
        activec = Solver.Solver_.net.forward(batchc);
        toc
        num_output = length(activec);
        active= activec{num_output};
        output (:,:,cha) = active;
    end
    [psnr, ssim] = V5_showresults(output, gtimg);
    psnrs = psnrs + psnr;
    ssims = ssims + ssim;
    clear output

end

mpsnr = psnrs/testnum;
mssim = ssims/testnum;

