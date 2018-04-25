function name=get_name(rep)
% to get the basename of the repository
  if nargin==0,rep='';end;
  urlname=fc_tools.git.get_url(rep);
  urlname=strsplit(urlname,filesep);
  name=urlname{end};
end
