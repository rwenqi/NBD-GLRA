% DEMO_TEST.m


% add your caffe path
addpath(genpath('/home/caffe-dilate/'))


% add your test image path
img_path = ('/home/data/bsd100gaublur1.2saturatednoise1/');

% if using pad, the output size equals to the input size, but needs more
% GPU memory.
pad = 0;



%% test synthetic datasets
% [mpsnr, mssim]= demo_testpsnr(200000, img_path, pad);



%% test single image

% given the input image name and the kernel name

% blurimg = im2double(imread(img_name));
% ker = im2double(imread(ker_name));
% deblurred = demo_testreal(200000, blurimg, ker, pad);