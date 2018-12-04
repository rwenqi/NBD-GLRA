% parameters should be consistent with prototxt
% patchsize: width and height in caffe
% batchsize: num in caffe, can be changed accordingly
% supporting JPG and PNG only
function Solver = testdataconfig( Solver, img )
% Solver.height = size(img, 1);
% Solver.width = size(img, 2);
Solver.batchsize = 1;
Solver.patchsize = 384;
% if size(img, 1)<size(img, 2)
% 	Solver.patchsize = size(img, 1);
% else
% 	Solver.patchsize = size(img, 1);
% end

end