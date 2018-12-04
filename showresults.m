function [dehazed,psnrs] = showresults(active, batch, gt)
% o = double(batch) + 0.5;
o = double(batch);
g = double(gt);
dehazed = double(active);
bz = size(o,4); psnrs = zeros(1,bz);
for m = 1:bz
psnrs(m) = psnr(dehazed(:,:,:,m),g(:,:,:,m));
end
A = cat(2,o,dehazed);
out = cat(2,A,g);
end