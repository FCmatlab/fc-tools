function tag=get_tag(rep)
% to get the first tag of the current local branch (empty string if no tag)
  if nargin==0,rep='';end;
  if ~isempty(rep), oldpwd=cd(rep);end
  [status,Res]=system('git log -1 --pretty="format:%d"');
  if status==0
    %Res=strtok(Res);
    I=strfind(Res,'tag:') ;
    if isempty(I)
      tag='';
    else
      C=strsplit(Res(I(1)+4:end),',')
      tag=strtrim(C{1});
    end
  else
    tag='';
  end
  if ~isempty(rep);  cd(oldpwd);end;
end
