function bool=isup2date(rep)
% check if local branch is up-to-date with origin/master
%
  if nargin==0;rep='';end;
  if ~isempty(rep), oldpwd=cd(rep); end
  [status,GIT]=system('git ls-files -m');
  bool=isempty(GIT);
  if ~isempty(rep);  cd(oldpwd);end;
end
