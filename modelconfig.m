function Solver = modelconfig(model_path, save_file, mode)
if strcmp(mode,'train')
    solver_file = fullfile(model_path,'llight_solver.prototxt');
else
    solver_file = fullfile(model_path,'llight_solver_test.prototxt');
end
if ~exist(save_file, 'file')
    Solver = SolverParser(solver_file);
else
	fprintf('loading saved model.\n');
    Solver = SolverParser(solver_file, save_file);
end
if isfield(Solver, 'snapshot_prefix')
    if isfield(Solver, 'iter')
        Solver.state_file = [Solver.snapshot_prefix,sprintf('_iter_%d.solverstate', Solver.iter)];
        Solver.model_file = [Solver.snapshot_prefix, sprintf('_iter_%d.caffemodel', Solver.iter)];
    else
        Solver.state_file = [];
        fprintf('ALERT: no pretrained snapshot found.\n');
    end
end


%Solver.solver_type='ADAM';
Solver = caffe_init(Solver, solver_file);
Solver.matfile = save_file;

end