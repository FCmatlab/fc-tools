function init(varargin)
  p = inputParser;
  p.KeepUnmatched=true;
  p.addParamValue('verbose', 1, @(x) ismember(x,0:2) ); % level of verbosity 
  p.parse(varargin{:});
  R=p.Results;verbose=R.verbose;
  [pkg,pkgs]=fc_tools.packages();
  if isOctave()
    warning('off','Octave:shadowed-function')
    more off
    tname='package';
  else
    tname='toolbox';
  end
  eval(['env=fc_',pkg,'.environment();']);
  
  for i=1:length(pkgs), init_package(pkgs{i},env,tname);end
  if verbose>0, eval(['fc_',pkg,'.info(verbose)']);end
end

function bool=isOctave()
  log=ver;bool=strcmp(log(1).Name,'Octave');
end

function init_package(strpkg,env,tname)
  pkgdir=eval(sprintf('env.fc_%s_dir',strpkg));
  if isdir(pkgdir), addpath(pkgdir);rehash path;end
  try
     eval(sprintf('fc_%s.init(''verbose'',0)',strpkg))
  catch ME
    fprintf('[fc-%s] Unable to load the <fc-%s> %s!\n',strpkg,strpkg,tname)
    fprintf('        directory: %s\n',pkgdir)
    rethrow(ME)
  end
end
