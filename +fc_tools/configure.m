function varargout=configure(varargin)
% FUNCTION fc_tools.configure()
%   Configures the toolbox/package .
%   Theses informations will be stored in ... file.
%
% <COPYRIGHT>
  [pkg,pkgs]=fc_tools.packages();
  n_pkgs=length(pkgs);
  for i=1:n_pkgs
    eval(sprintf('fc_%s_dir='''';',pkgs{i})); % empty if pkg or toolbox in path
  end
  
  eval(sprintf('[conffile,isFileExists]=fc_%s.getLocalConfFile();',pkg));
  if isFileExists
    run(conffile);
  end
  p = inputParser;
  p.KeepUnmatched=true;
  for i=1:n_pkgs
    eval(sprintf('p.addParamValue(''fc_%s_dir'',fc_%s_dir,@ischar);',pkgs{i},pkgs{i}));
  end
  p.addParamValue('verbose', 1, @(x) ismember(x,0:2) ); % level of verbosity 
  %p.addParamValue('force',false,@islogical); 
  p.parse(varargin{:});
  R=p.Results;verbose=R.verbose;
  
  for i=1:n_pkgs
    pkgs_dir{i}=eval(sprintf('get_tbxpath(''%s'',''%s'',R.fc_%s_dir);',pkgs{i},pkg,pkgs{i}));
  end
  A=sprintf(' ''%s'', ',pkgs{:});A(1)='{';A(end-1)='}';
  A=['pkgs=',A];
  
  fprintf('Write in %s ...\n',conffile);
  fid=fopen(conffile,'w');
  if (fid==0), error('Unable to open file :\n %s\n',conffile);end
  fprintf(fid,'%% Automaticaly generated with fc_%s.configure()\n',pkg);
  if n_pkgs>0
    for i=1:n_pkgs
      fprintf(fid,'fc_%s_dir=''%s'';\n',pkgs{i},pkgs_dir{i});
    end
    fprintf(fid,'%s;\n',A);
  end
  fclose(fid);
  if n_pkgs>0
    vprintf(verbose,2,'[fc-%s] configured with\n',pkg);
    for i=1:n_pkgs
      vprintf(verbose,2,'   -> fc_%s_dir=''%s'';\n',pkgs{i},pkgs_dir{i});
    end
  else
    vprintf(verbose,2,'[fc-%s] configured without other package\n',pkg);
  end
  vprintf(verbose,2,'[fc-%s] done\n',pkg);
  if nargout==1,varargout{1}=conffile;end
  rehash
end

%
% DO NOT MODIFY THIS FUNCTION: IT IS AUTOMATICALLY ADDED
%
function tbxpath=get_tbxpath(tbxname,tbxfrom,givenpath,varargin) % tbxname is the toolbox to 'include' in the toolbox <tbxfrom>
  p = inputParser;
  p.addParamValue('stop'   ,true,@islogical);
  p.addParamValue('verbose', 1, @(x) ismember(x,0:2) ); % level of verbosity 
  p.parse(varargin{:});
  stop=p.Results.stop;verbose=p.Results.verbose;
  tbxpath='';
  if ~isempty(givenpath) 
    if ~isDir(givenpath) % isDir function defined below
      vprintf(verbose,1,'[fc-%s] The given path does not exists for <fc-%s>:\n   -> %s\n',tbxfrom,tbxname,givenpath)
      vprintf(verbose,1,'[fc-%s] Use fc_%s.configure(''fc_%s_dir'',<DIR>) to correct this issue\n\n',tbxfrom,tbxfrom,tbxname)
      if stop
        error(sprintf('fc-%s::configure',tbxfrom),'step 0')
      else
        warning(sprintf('fc-%s::configure',tbxfrom),'step 0')
      end
    end
    tbxpath=givenpath;
    addpath(tbxpath);rehash path;
    failed=false;
    try % check if the toolbox can be found
      eval(sprintf('fc_%s.version();',tbxname))
    catch
      vprintf(verbose,2,'[fc-%s] Unable to load the fc-%s toolbox/package in given path:\n  %s\n',tbxfrom,tbxname,tbxpath)
      if stop
        error(sprintf('fc-%s::configure',tbxfrom),'step 1')
%        else
%          warning(sprintf('fc-%s::configure',tbxfrom),'step 1')
      end
      failed=true;
    end
    rmpath(tbxpath);rehash path;
    if ~failed, return;end
  end
  failed=false;
  try % check if the toolbox is in current Matlab path
    eval(sprintf('fc_%s.version();',tbxname))
  catch
    vprintf(verbose,2,'[fc-%s] Unable to load the fc-%s toolbox/package in current path\n',tbxfrom,tbxname)
    failed=true;
  end
  if ~failed, return;end
  failed=false;
  fullname=mfilename('fullpath');
  I=strfind(fullname,filesep);
  Path=fullname(1:(I(end-2)-1));
  
  lstdir=dir(Path); % try to guess directory. I don't use dir command due to trouble with octave
  C=arrayfun(@(x) x.name,lstdir, 'UniformOutput', false);
  I=strfind(C,['fc-',tbxname]);
  i=find(cellfun(@(x) ~isempty(x),I)==1);
  if ~isempty(i)
    k=1;
    while k<=length(i)
      tbxpath=[Path,filesep,C{i(k)}];
      addpath(tbxpath);rehash path;
      try % check if the toolbox is in new current Matlab path
        eval(sprintf('fc_%s.version();',tbxname))
      catch
        failed=true;
        vprintf(verbose,2,'[fc-%s] Unable to load the fc-%s toolbox/package in guess path\n  %s\n',tbxfrom,tbxname,tbxpath)
        vprintf(verbose,2,'[fc-%s] Use fc_%s.configure(''fc_%s_dir'',<DIR>) to correct this issue\n\n',tbxfrom,tbxfrom,tbxname)
        if stop
          error(sprintf('fc-%s::configure',tbxfrom),'step 2')
%          else
%            warning(sprintf('fc-%s::configure',tbxfrom),'step 2')
        end
      end
      rmpath(tbxpath);rehash path;
      if ~failed
        vprintf(verbose,2,'[fc-%s] Loading the fc-%s toolbox/package in guess path\n  %s\n',tbxfrom,tbxname,tbxpath)
        return;
      end
      k=k+1;
    end
  else
    vprintf(verbose,2,'[fc-%s] Guess path does not exists:\n   -> %s\n',tbxfrom,tbxname,tbxpath)
    vprintf(verbose,2,'[fc-%s] Use fc_%s.configure(''fc_%s_dir'',<DIR>) to correct this issue\n\n',tbxfrom,tbxfrom,tbxname);
    if stop
      error(sprintf('fc-%s::configure',tbxfrom),'step 3')
%      else
%        warning(sprintf('fc-%s::configure',tbxfrom),'step 3')
    end
    failed=true;
  end
  if failed
      tbxpath='';
  else
    vprintf(verbose,2,'[fc-%s] fc-%s toolbox/package found in path:\n   -> %s\n',tbxfrom,tbxname,tbxpath)
  end
end

function vprintf(verbose,level,varargin)
  if verbose>=level, fprintf(varargin{:});end
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

function bool=isOctave()
  log=ver;bool=strcmp(log(1).Name,'Octave');
end

function bool=isDir(x)
  if isOctave()
    if strversion2num(version)<strversion2num('5.1.0'), bool=isdir(x); else, bool=isfolder(x);end
  else % 9.3.0 == 2017b
    if  verLessThan('matlab','9.3.0'), bool=isdir(x); else, bool=isfolder(x);end
  end
end
