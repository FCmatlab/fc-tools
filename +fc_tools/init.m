function init(varargin)
  p = inputParser;
  p.KeepUnmatched=true;
  p.addParamValue('verbose', 1, @(x) ismember(x,0:2) ); % level of verbosity 
  p.addParamValue('without',{},@iscell);
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
  
  for i=1:length(pkgs)
    if ~ismember(pkgs{i},R.without) 
      init_package(pkgs{i},env,tname,pkgs);
    end
  end
  if verbose>0, eval(['fc_',pkg,'.info(verbose)']);end
end

function bool=isOctave()
  log=ver;bool=strcmp(log(1).Name,'Octave');
end

function init_package(strpkg,env,tname,exclude_pkgs)
  pkgdir=eval(sprintf('env.fc_%s_dir',strpkg));
  if isDir(pkgdir), addpath(pkgdir);rehash path;end % isDir function defined below
  try
     eval(sprintf('fc_%s.init(''verbose'',0,''without'',exclude_pkgs)',strpkg))
  catch ME
    fprintf('[fc-%s] Unable to load the <fc-%s> %s!\n',strpkg,strpkg,tname)
    fprintf('        directory: %s\n',pkgdir)
    rethrow(ME)
  end
end

function ver=strversion2num(strv)
  % convert version string 'x.y.z' in x*10^6+y*10^3+z
  S=strsplit(strv,'.');
  assert(length(S)==3);
  z=str2num(S{3});assert(z<10^3);
  ver=z;
  y=str2num(S{2});assert(y<10^3);
  ver=ver+10^3*y;
  x=str2num(S{1});assert(x<10^3);
  ver=ver+10^6*x;
end

function bool=isDir(x)
  if isOctave()
    if strversion2num(version)<strversion2num('5.1.0'), bool=isdir(x); else, bool=isfolder(x);end
  else % 9.3.0 == 2017b
    if  verLessThan('matlab','9.3.0'), bool=isdir(x); else, bool=isfolder(x);end
  end
end
