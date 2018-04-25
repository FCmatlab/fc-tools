function GITcommit=get_commit(rep)
% To get the SHAID (commit) of a directory
% With no input argument, current directory is treated.
%
% Input argument: path (default is current path)
  if nargin==0;rep='';end;
  if ~isempty(rep), oldpwd=cd(rep);
  end
    %[status,GITcommit]=system(sprintf('git log .| grep -m1 commit|awk ''{print $2}'''));
  [status,GITcommit]=system('git rev-parse HEAD');
  if status==0
    GITcommit=strtok(GITcommit);
  else
    GITcommit='';
  end
  
  if ~isempty(rep);  cd(oldpwd);end;
end