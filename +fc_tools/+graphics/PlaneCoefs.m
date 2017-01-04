function P=PlaneCoefs(Q,V)
% FUNCTION PlaneCoefs 
%   Compute coefficients of a plan in dimension 3.
%
% USAGE
%   P=fctools.graphics.PlaneCoefs(Q,V) computes the coefficients P of the plane 
%   defined by 
%                       P(1)*x+P(2)*y+P(3)*z+P(4)=0
%   coming through point Q and orthogonal to vector V.
%
%
% SAMPLES
%   P=fc_tools.graphics.PlaneCoefs([0 0 1],[1 -1 1]);
%
%    <COPYRIGHT>
assert(size(Q,2)==3 & size(V,2)==3) 
No=V/norm(V,2);
P=[No, -Q*No'];