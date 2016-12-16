function P=PlaneCoefs(Q,V)
% In R^3, Q is a point in the plane and V is a vector orthogonal to it. Then the plane equation is given by
%    P(1)*x+P(2)*y+P(3)*z+P(4)=0
assert(size(Q,2)==3 & size(V,2)==3) 
No=V/norm(V,2);
P=[No, -Q*No'];