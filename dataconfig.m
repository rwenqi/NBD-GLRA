% Solver:
% patchsize: width and height in caffe
% batchsize: num in caffe, can be changed accordingly
% supporting JPG and PNG only
function Solver = dataconfig( Solver, parm, train_path )
Solver.patchsize = parm.patchsize;
Solver.batchsize = parm.batchsize;
tdir = dir(fullfile(train_path.groundtruth, '*.jpg'));
num_jpg = length(tdir);
for m = 1:num_jpg
   Solver.trainlst{1,m}  = tdir(m).name;    
end
tdir = dir(fullfile(train_path.groundtruth, '*.PNG'));
num_png = length(tdir);
for m = num_jpg+1: num_jpg + num_png
   Solver.trainlst{1,m}  = tdir(m-num_jpg).name;    
end

Solver.train_num = num_png + num_jpg;
% Solver.train_folder = train_path;
Solver.folder{1} = train_path.groundtruth;
fprintf('Done with data config, obtain %d traning images.\n',Solver.train_num);
end