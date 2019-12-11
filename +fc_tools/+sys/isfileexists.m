function bool=isfileexists(file)
% FUNCTION fc_tools.sys.isfileexists
%   Return true if file exists, false otherwise.
%
% USAGE
%   bool=fc_tools.sys.isfileexists(file)
%
% <COPYRIGHT>
  [fid,message]=fopen(file,'r');
  if ( fid == -1 ), bool=false;return;else bool=true; end
  fclose(fid);
end
