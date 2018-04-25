function bool=isrepository(rep)
% check if rep directory is a git repository
  if nargin==0,rep='';end;
  bool=~isempty(fc_tools.git.get_name(rep));
end
