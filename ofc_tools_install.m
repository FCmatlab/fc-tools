function ofc_tools_install(varargin)
%  FUNCTION  ofc_tools_install
%    automaticaly install the fc-tools package in current directory
%   
%  <LICENSE>
%  <COPYRIGHT>
%
  if strversion2num(version)<strversion2num('4.2.0')
    error('Using Octave version %s. Version must be >= 4.2.0. ',version)
  end
  warning('off','Octave:shadowed-function');more off
  pkg='tools'; % automaticaly written by setpackages.py script
  pkgs={}; % automaticaly written by setpackages.py script
  pkgs_version={}; % automaticaly written by setpackages.py script
  pkg_version='0.0.24'; % automaticaly written by setpackages.py script
  
  p = inputParser; 
  p.addParamValue('dir', ['./fc-',pkg,'-full'], @ischar );
  p.addParamValue('verbose', 1, @(x) ismember(x,0:2) ); % level of verbosity 
  p.addParamValue('stage', 1)
  for i=1:length(pkgs)
    eval(sprintf('p.addParamValue(''fc_%s'',''%s'',@ischar);',pkgs{i},pkgs_version{i}));
  end
  p.parse(varargin{:});
  verbose=p.Results.verbose;
  
  vprintf(verbose,1,['Parts of the <fc-',pkg,'> Octave package.\n<COPYRIGHT>\n\n']);
  vprintf(verbose,1,'1- Downloading and extracting the packages\n');
  for i=1:length(pkgs)
    pkgs_version{i}=eval(['p.Results.fc_',pkgs{i}]);
    vprintf(verbose,2,'   -> <fc-%s>[%s] ...',pkgs{i},pkgs_version{i})
    pkgs_dir{i}=get_inst_fc_gen(pkgs{i},pkgs_version{i},p.Results.dir);
    vprintf(verbose,2,' OK\n');
  end
  vprintf(verbose,2,'   -> <fc-%s>[%s] ...',pkg,pkg_version)
  fc_pkg_dir=get_inst_fc_gen(pkg,pkg_version,p.Results.dir);
  vprintf(verbose,2,' OK\n');
  
  if p.Results.stage==0, return;end
  
  currentdir=pwd();
  cd(fc_pkg_dir)
  vprintf(verbose,1,['2- Setting the <fc-',pkg,'> package\n']);
  for i=1:length(pkgs)
    VarArgin{2*i-1}=['fc_',pkgs{i},'_dir'];
    VarArgin{2*i}=pkgs_dir{i};
  end
  eval(['fc_',pkg,'.configure(VarArgin{:})']);
  cd(currentdir)
  
  vprintf(verbose,1,'3- Using packages :\n')
  for i=1:length(pkgs)
    vprintf(verbose,1,'   -> %20s : %s\n',['fc-',pkgs{i}],pkgs_version{i})
  end
  
  vprintf(verbose,1,'*** Using instructions \n');
  vprintf(verbose,1,['   To use the <fc-',pkg,'> package:\n']);
  vprintf(verbose,1,'   addpath(''%s'')\n',fc_pkg_dir);
  vprintf(verbose,1,['   fc_',pkg,'.init()\n']);
  logfile=[currentdir,filesep,'ofc_',pkg,'_set.m'];
  vprintf(verbose,1,'\n   See %s\n',logfile);
  fid=fopen(logfile,'w');
  fprintf(fid,'warning(''off'',''Octave:shadowed-function'');more off\n');
  fprintf(fid,'addpath(''%s'')\n',fc_pkg_dir);
  fprintf(fid,['fc_',pkg,'.init()\n']);
  fclose(fid);
end

function fulldir=get_inst_fc_gen(name,ver,dir)
  file=sprintf('ofc-%s-%s.tar.gz',name,ver);
  urlfile=sprintf('http://www.math.univ-paris13.fr/~cuvelier/software/codes/Octave/fc-%s/%s/fc_%s-%s.tar.gz',name,ver,name,ver);
  urlwrite(urlfile,file);
  try
    untar(file,dir)
  catch
    error('Unable to get :\n  -> %s\n',urlfile);
  end
  if strncmp(dir,['.',filesep],2),dir=dir(3:end);end
  if dir(1)==filesep
    fulldir=sprintf('%s%sfc_%s-%s',dir,filesep,name,ver);
  else
    fulldir=fullfile(pwd,sprintf('%s%sfc_%s-%s',dir,filesep,name,ver));
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

function vprintf(verbose,level,varargin)
  if verbose>=level, fprintf(varargin{:});end
end
