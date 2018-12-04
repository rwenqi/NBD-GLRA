function [psnrs, ssims] = V5_showresults(active, gtimg)
r = double(active);
start_x = (size(gtimg, 1) - size(active, 1))/2 + 1;
end_x = start_x + size(active, 1) -1;

start_y = (size(gtimg, 2) - size(active, 2))/2 + 1;
end_y = start_y + size(active, 2) -1;

g = double(gtimg(start_x:end_x, start_y:end_y, :,:));

bz = size(r,4);
psnrs = zeros(1,bz);
ssims = zeros(1,bz);
% if flag
%    o = o + 0.5;
% end

for m = 1:bz

    psnrs(m) = psnr(r(:,:,:,m),g(:,:,:,m));
    ssims(m) = ssim(r(:,:,:,m),g(:,:,:,m));
    
end
%mean_psnr = mean(psnrs);
% A = cat(2,o,r);
% out = cat(2,A,g);
%if flag
%   out = out + 0.5;
%end
