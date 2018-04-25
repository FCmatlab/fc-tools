function tinfo=get_tagsinfo(rep)
% to get all the tags of the repository: last tag is tags{end} 
  if nargin==0,rep='';end;
  if ~isempty(rep),oldpwd=cd(rep);end
  [status,GIT]=system('git for-each-ref --format ''%(tag)|%(objectname)|%(taggerdate:raw)'' refs/tags  --sort=taggerdate | awk ''BEGIN { FS="|" } ; { t=strftime("%Y-%m-%d|%H:%M:%S",$3); printf "%s|%s|%s\n",$1,$2,t}''');
  if status == 0
    tags=strsplit(GIT,'\n');
    if length(tags{end})==0, tags={tags{1:end-1}};end
    for i=1:length(tags)
      t=tags{i};t=strsplit(t,'|');
      S=struct('tag',t{1},'commit',t{2},'date',t{3},'time',t{4});
      tinfo(i)=S;
    end
    
  else
    tinfo=[];
  end
  if ~isempty(rep);  cd(oldpwd);end;
end
