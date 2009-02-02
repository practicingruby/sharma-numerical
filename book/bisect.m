function [c,err,yc] = bisect(f, a, b, delta)

% Bisection Method
%   To approximate the root of the equation f(x) = 0 in the interval [a,b].
%   Use this method only if f(x) is continuous and f(a) and f(b) have
%   opposite signs.
%
% FUNCTION SIGNATURE: [c,yc,err] = bisect(f,a,b,delta)
%  
%   input  - f is an inline function or reference to an mfile
%          - a and b are the left and right endpoints
%          - delta is the tolerance
%
%   output - c is the zero
%          - yc = f(c)
%          - err is error est. for c
% 
% USAGE:
%  Via an inline function:
%  [c,yc,err] = bisect(@(x) x*sin(x) - 1, 0, 2, 0.001)
%
%  Via an mfile (example.m):
%  [c,yc,err = bisect(@example, 0, 2, 0.0001)
%
%  NOTE:
%  If f(a)*f(b) is positive, function will raise an error and exit.
%
ya = f(a);
yb = f(b);

if ya * yb > 0, error('no match: f(a)*f(b) is positive'), end

max1= 1 + round((log(b-a) - log(delta))/log(2));

for k = 1:max1
  c  = (a + b) / 2;
  yc = f(c);
  if yc == 0
    a = c;
    b = c;
  elseif yb * yc > 0
    b  = c;
    yb = yc;
  else
    a  = c;
    ya = yc;
  end
  if b - a < delta, break, end
end

c = (a + b) / 2;
err = abs( b - a );
yc = f(c);
