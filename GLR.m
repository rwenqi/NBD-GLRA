function [L,R] = GLR(A, D, iter)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A: original matrix
% D: dim of reduced matrix
% iter: num of iterations (default: 4)
% L: left matrix
% R: right matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

assert(size(A,1)==size(A,2),'A should be a square matrix');
N = size(A,3);  % number of kernels
Q = size(A,1);  % dim of original matrix

if(nargin==2)
    iter = 4;
end

L = [eye(D);zeros(Q-D,D)];

for i = 1:iter
    M = zeros(Q, Q);
    for n = 1:N
        M = M + A(:,:,n)'*L*L'*A(:,:,n);
    end
    [U,~,~] = svd(M);
    R = U(:,1:D);
    
    M = zeros(Q, Q);
    for n = 1:N
        M = M + A(:,:,n)*R*R'*A(:,:,n)';
    end
    [U,~,~] = svd(M);
    L = U(:,1:D);
end