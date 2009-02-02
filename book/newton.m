function [p0,err,k,y]=newton(f,df,p0,delta,epsilon,max1)

% Newton-Raphson Iteration (p.84)
%   To approximate a root of f(x) = 0 given one initial approximation p_0 and
%   using the iteration:
%
%      p_k = p_(k - 1) - ( f(p_(k-1)) / f'(p_(k - 1)) ) for k = 1, 2, ...
%
% FUNCTION SIGNATURE: [p0,err,k,y]=newton(f,df,p0,delta,epsilon,max1)
%
%    input  - f  is an inline function or reference to an mfile
%           - df is the derivative of f, as an inline function or mfile reference
%           - p0 is the initial approximation to a zero of f
%           - delta is the tolerance for p0
%           - epsilon is the tolerance for the function values y
%           - max1 is the maximum number of iterations
%
%    output - p0 is the Newton-Raphson approximation to the zero
%           - err is the error estimate for p0
%           - k is the number of iterations performed
%           - y is the function value f(p0)
%
% USAGE:
%   Via an inline function:
%     f = @(x) x.^(3) - 3*x + 2;
%     g = @(x) 3*x.^(2) - 3;
%     [p0,err,k,y] = newton(f,g,-2.4, 0.001, 0.001, 1000)
%
%   Via mfiles (example1.m, example2.m):
%     [p0,err,k,y] = newton(@example1, @example2,-2.4, 0.001, 0.001, 1000)
% 
% NOTE: This function will silently return values that may not be within the
% tolerance when the maximum iterations have been exhausted.  Inspect k to
% verify whether this may have occured.
%
for k = 1:max1
  p1     = p0 - f(p0) / df(p0);
  err    = abs(p1 - p0);
  relerr = 2*err/(abs(p1)+delta);
  p0     = p1;
  y      = f(p0);

  if (err < delta) | (relerr < delta) | (abs(y) < epsilon )
    break
  end
end
