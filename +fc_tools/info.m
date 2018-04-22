function info(verbosity)
% FUNCTION fc_tools.info(): Displays some information on the package/toolbox.
%
%    <COPYRIGHT>
%
  if nargin==0, verbosity=1;end
  assert(ismember(verbosity,[1,2]) , '[fc_tools.info] Input parameter must be 1 or 2')
  fprintf('Using %s\n',fc_tools.utils.fcpackagestr('fc_tools',verbosity))
end
