function S=get_info(rep)
% to get all the tags of the repository: last tag is tags{end} 
  if nargin==0,rep='';end;
  if fc_tools.git.isrepository(rep)
    S=struct('name',  fc_tools.git.get_name(rep), ...
             'tag',   fc_tools.git.get_tag(rep), ...
             'commit',fc_tools.git.get_commit(rep), ...
             'date',  fc_tools.git.get_date(rep), ...
             'time',  fc_tools.git.get_time(rep), ...
             'status',fc_tools.git.isup2date(rep));
  else
    tag='';
    commit='';
    strdate='';
    strtime='';
    S=struct('name','fc-bench','tag',tag,'commit',commit,'date',strdate,'time',strtime,'status',-1);
  end
end
