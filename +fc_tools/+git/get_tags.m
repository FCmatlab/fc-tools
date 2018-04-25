function tags=get_tags(rep)
% to get all the tags of the repository: last tag is tags{end} 
  if nargin==0,rep='';end;
  if ~isempty(rep),oldpwd=cd(rep);end
  [status,GITtag]=system('git tag');
  if status == 0
    tags=strsplit(GITtag,'\n');
    if length(tags{end})==0, tags={tags{1:end-1}};end
  else
    tags='';
  end
  if ~isempty(rep);  cd(oldpwd);end;
end
