function strtime=get_time(rep)
% to get the first tag of the current local branch (empty string if no tag)
  if nargin==0,rep='';end;
  if ~isempty(rep), oldpwd=cd(rep);end
  [status,Res]=system('git log -1 --pretty="format:%at" | awk ''BEGIN { FS="|" } ; { t=strftime("%H:%M:%S",$1); printf "%s\n", t}''');
  if status==0
    strtime=strtrim(Res);
  else
    strtime='';
  end
  if ~isempty(rep);  cd(oldpwd);end;
end
