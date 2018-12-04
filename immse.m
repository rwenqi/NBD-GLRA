function err = immse(x, y)
%IMMSE Mean-Squared Error.
%   ERR = IMMSE(X,Y) calculates the mean-squared error (MSE) between the
%   arrays X and Y. X and Y can be arrays of any dimension, and must be of
%   the same size and class.
%
%   Example
%   ---------
%   ref = imread('pout.tif');
%   A = imnoise(ref,'salt & pepper', 0.02);
% 
%   err = immse(A, ref);
% 
%   fprintf('\n The mean-squared error is %0.4f', err);
% 
%   Class Support 
%   ------------- 
%   Input arrays X and Y must be one of the following classes: uint8, int8,
%   uint16, int16, uint32, int32, single, or double. Both X and Y must be
%   of the same class. They must be nonsparse. ERR is a scalar of class
%   double, unless X and Y are of class single in which case ERR is a
%   scalar of class single.
%
%   See also MEAN, MEDIAN, PSNR, SSIM, SUM, VAR.

%   Copyright 2015 The MathWorks, Inc. 

validateattributes(x,{'uint8', 'int8', 'uint16', 'int16', 'uint32', 'int32', ...
    'single','double'},{'nonsparse'},mfilename,'A',1);
validateattributes(y,{'uint8', 'int8', 'uint16', 'int16', 'uint32', 'int32', ...
    'single','double'},{'nonsparse'},mfilename,'B',1);

if ~isa(x,class(y))
    error(message('images:validate:differentClassMatrices','A','B'));
end
    
if ~isequal(size(x),size(y))
    error(message('images:validate:unequalSizeMatrices','A','B'));
end

if isempty(x) % If x is empty, y must also be empty
    err = [];
    return;
end

if isinteger(x)     
    x = double(x);
    y = double(y);
end

err = (norm(x(:)-y(:),2).^2)/numel(x);
