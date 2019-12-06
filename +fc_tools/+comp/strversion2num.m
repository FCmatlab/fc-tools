function ver=strversion2num(strv)
% convert version string 'x.y.z' in x*10^6+y*10^3+z
% convert version string 'x.y' in x*10^6+y*10^3
% convert version string 'x' in x*10^6
  S=strsplit(strv,'.');
  assert(ismember(length(S),1:3));
  x=str2num(S{1});assert(x<10^3);
  ver=10^6*x;
  if length(S)==1, return;end
  y=str2num(S{2});assert(y<10^3);
  ver=ver+10^3*y;
  if length(S)==2, return;end  
  z=str2num(S{3});assert(z<10^3);
  ver=ver+z;
end
