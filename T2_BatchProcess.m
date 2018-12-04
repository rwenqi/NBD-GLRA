function batch = T2_BatchProcess(batch)
% grad
%batch = batch(:,:,[3,2,1,4:end],:);
batch = {single(batch)};
%batch = {single(permute(batch,[2 1 3 4]))};
