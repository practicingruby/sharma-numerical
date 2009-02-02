function [k,p,err,P]=fixpt(g,p0,tol,max1)

% Fixed-Point Iteration
%   To approximate a solution to the equation x = g(x) starting with the initial
%   guess p0 and iterating p_(n+1) = g(p_n).
%
%   FUNCTION SIGNATURE: [k,p,err,P]=fixpt(g,p0,tol,max1)
%   
%     input - g is an inline function or reference to an mfile
%           - p0 is the initial guess for the fixed point
%           - tol is the tolerance
%           - max1 is the maximum number of iterations
% 
%    output - k is the number of iterations that were carried out
%           - p is the approximation to the fixed point
%           - err is the error in the approximation
%           - P contains the sequence {pn}
% USAGE:
%  Via an inline function:
%  [k, p, err, P] = fixpt(@(x) 2*(x - 1).^(1/2), 1.5, 0.000001, 1000)
%  
%  Via an mfile (example.m):
%  [k, p, err, P] = fixpt(@example, 1.5, 0.000001, 1000)
%  
%  NOTE: A warning will be printed when the approximation exceeds the maximum
%  number of iterations, but the function will otherwise return normally.  This
%  means that tol represents a condition for stopping early, not a constraint
%  that the approximation must fulfill.
%
%  Additionally, the function will return not only if the absolute error falls
%  within the tolerance, but also when the relative error is within the
%  threshold.  For details, see 'Numerical Methods', pp49: "Absolute and
%  Relative Error Considerations"
%
P(1) = p0;
for k = 2:max1
  P(k)   = g(P(k-1));
  err    = abs(P(k) - P(k-1));
  relerr = err / (abs(P(k)) + eps);
  p = P(k);
  if (err < tol) | (relerr < tol), break, end
end

if k == max1
  disp('maximum number of iterations exceeded')
end

P=P';
