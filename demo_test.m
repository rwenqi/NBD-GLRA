% DEMO_TEST.m


% add your caffe path
addpath(genpath('/home/caffe-dilate/'))


% add your test image path
img_path = ('/home/data/bsd100gaublur1.2saturatednoise1/');

% if using pad, the output size equals to the input size, but needs more
% GPU memory.
pad = 0;

[mpsnr, mssim]= demo_testpsnr(200000, img_path, pad);