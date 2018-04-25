function GITurl=get_url(rep)
% To get the remote git url of a working directory
% With no input argument, current directory is treated.
%
% Input argument: path (default is current path)
%
% From G.Scarella
  if nargin==0,rep='';end;
  if ~isempty(rep),oldpwd=cd(rep);end
  [status,GITurl]=system('git config --get remote.origin.url');
  if status == 0
    GITurl=strtok(GITurl);
  else
    GITurl='';
  end
  if ~isempty(rep);  cd(oldpwd);end;
end
