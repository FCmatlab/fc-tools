function info(verbosity)
% FUNCTION fc_tools.info: Returns information on package
%
%    <COPYRIGHT>
%
  if nargin==0, verbosity=1;end
  [pkg,pkgs]=fc_tools.packages();
  assert(ismember(verbosity,[1,2]) , ['[fc_',pkg,'.info] Input parameter must be 1 or 2'])
  if verbosity>1
  fprintf('Using %s\n',fc_tools.utils.fcpackagestr(['fc_',pkg],verbosity))
  n_pkgs=length(pkgs);
  if n_pkgs>1
    for i=1:n_pkgs-1
      fprintf('  %s\n',fc_tools.utils.fcpackagestr(['fc_',pkgs{i}],verbosity))
    end
    if n_pkgs>1, fprintf('  and ');end
    fprintf('  and %s\n',fc_tools.utils.fcpackagestr(['fc_',pkgs{end}],verbosity))
    else
      fprintf('Using %s with ',fc_tools.utils.fcpackagestr(['fc_',pkg],verbosity))
      for i=1:n_pkgs-1
        fprintf('%s, ',fc_tools.utils.fcpackagestr(['fc_',pkgs{i}],verbosity))
      end
      if n_pkgs>1, fprintf('  and ');end
      fprintf('%s.\n',fc_tools.utils.fcpackagestr(['fc_',pkgs{end}],verbosity))
    end
  end
end
