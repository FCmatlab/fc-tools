function S=gitinfo()
% FUNCTION fc_tools.gitinfo(): returns some informations on the package/toolbox.
%
%    <COPYRIGHT>
%
  tag='';
  commit='';
  strdate='';
  strtime='';
  S=struct('tag',tag,'commit',commit,'date',strdate,'time',strtime);
end
