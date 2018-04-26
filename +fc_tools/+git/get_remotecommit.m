function GITcommit=get_remotecommit(remote)
% To get the SHAID (commit) of a remote GIT server
% rep='ssh://servergit/directory'
%
  [status,GITcommit]=system(sprintf('git ls-remote %s | grep HEAD',remote));
  if status==0
    A=strsplit(GITcommit,'\n');
    I=strfind(A,'HEAD');
    i=find(cellfun(@isempty,I)==0);
    GITcommit=strtok(A{i});
  else
    GITcommit='';
  end
end
