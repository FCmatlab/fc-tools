function ver=strversion2num(strv)
% convert version string 
%    'x.y.z' -> x*10^6+y*10^3+z
%    'x.y'   -> x*10^6+y*10^3
%    'x'     -> x*10^6
  S=strsplit(strv,'.');
  nS=length(S);
  assert(nS<=3);
  if nS==0, ver=str2num(strv)*10^6;return;end
  ver=0;p=6;  
  for i=1:nS
    ver=ver+str2num(S{i})*10^p;
    p=p-3;
  end
end
