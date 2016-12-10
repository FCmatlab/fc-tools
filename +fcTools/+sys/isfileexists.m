function bool=isfileexists(file)
% FUNCTION fcTools.sys.isfileexists
%   Retuen true if if file exists, false otherwise.
%
% <COPYRIGHT>
  [fid,message]=fopen(file,'r');
  if ( fid == -1 ), bool=false;return;else bool=true; end
  fclose(fid);
end