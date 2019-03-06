function info(verbosity)
% FUNCTION fc_tools.info: Returns information on package
%
%    <COPYRIGHT>
%
  if nargin==0, verbosity=1;end
  [pkg,pkgs]=fc_tools.packages();
  assert(ismember(verbosity,[1,2]) , ['[fc_',pkg,'.info] Input parameter must be 1 or 2'])
  if verbosity==1,info1(pkg,pkgs); else, info2(pkg,pkgs);end
end

function info1(pkg,pkgs)
  n_pkgs=length(pkgs);
  fprintf('Using %s with ',fc_tools.utils.fcpackagestr(['fc_',pkg],1))
  for i=1:n_pkgs-1
    fprintf('%s, ',fc_tools.utils.fcpackagestr(['fc_',pkgs{i}],1))  
  end
  fprintf('%s.\n',fc_tools.utils.fcpackagestr(['fc_',pkgs{end}],1))  
end

function info2(pkg,pkgs)
  n_pkgs=length(pkgs);
  fprintf('Using %s with:\n',fc_tools.utils.fcpackagestr(['fc_',pkg],2))
  for i=1:n_pkgs-1
    fprintf('    %s,\n',fc_tools.utils.fcpackagestr(['fc_',pkgs{i}],2))  
  end
  fprintf('   %s.\n',fc_tools.utils.fcpackagestr(['fc_',pkgs{end}],2))  
end
