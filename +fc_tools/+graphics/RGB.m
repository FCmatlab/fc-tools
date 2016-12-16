function val = RGB(t,cmap)
%bleu  = [ 0 0 1]
%vert  = [ 0 1 0]
%rouge = [1 0 0 ]
n=size(cmap,1);
nt=length(t);
val=zeros(nt,3);
x=0:1/(n-1):1;
for i=1:nt
  r = min(abs(interp1(x,cmap(:,1),t(i))),1);
  g = min(abs(interp1(x,cmap(:,2),t(i))),1);
  b = min(abs(interp1(x,cmap(:,3),t(i))),1);
  val(i,:) = [ r g b];
end
