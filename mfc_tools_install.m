function mfc_tools_install(varargin)
%  FUNCTION  mfc_tools_install
%    automaticaly install the fc-tools toolbox in current directory
%   
%  <LICENSE>
%  <COPYRIGHT>
%
  if  verLessThan('matlab','8.6.0') % 2015b
    error('Running MATLAB older than MATLAB 8.6.0 (R2015b)')
  end
  pkg='tools'; % automaticaly written by setpackages.py script
  pkgs={}; % automaticaly written by setpackages.py script
  pkgs_version={}; % automaticaly written by setpackages.py script
  pkg_version='0.0.28'; % automaticaly written by setpackages.py script
  
  p = inputParser; 
  p.addParamValue('dir', ['./fc-',pkg,'-full'], @ischar );
  p.addParamValue('verbose', 1, @(x) ismember(x,0:2) ); % level of verbosity 
  p.addParamValue('stage', 1) 
  n_pkgs=length(pkgs);
  for i=1:n_pkgs
    eval(sprintf('p.addParamValue(''fc_%s'',''%s'',@ischar);',pkgs{i},pkgs_version{i}));
  end
  p.parse(varargin{:});
  verbose=p.Results.verbose;
  
  vprintf(verbose,1,['Parts of the <fc-',pkg,'> Matlab toolbox.\n<COPYRIGHT>\n\n']);
  vprintf(verbose,1,'1- Downloading and extracting the toolboxes\n');
  for i=1:n_pkgs
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
  vprintf(verbose,1,['2- Setting the <fc-',pkg,'> toolbox\n']);
  VarArgin=cell(1,2*n_pkgs);
  for i=1:n_pkgs
    VarArgin{2*i-1}=['fc_',pkgs{i},'_dir'];
    VarArgin{2*i}=pkgs_dir{i};
  end
  eval(['fc_',pkg,'.configure(VarArgin{:});']);
  cd(currentdir)
  
  if n_pkgs>0
    vprintf(verbose,1,'3- Using toolboxes :\n')
    for i=1:n_pkgs
      vprintf(verbose,1,'   -> %20s : %s\n',['fc-',pkgs{i}],pkgs_version{i})
    end
    vprintf(verbose,1,' with %20s : %s\n',['fc-',pkg],pkg_version)
  end
  
  vprintf(verbose,1,'*** Using instructions \n');
  vprintf(verbose,1,['   To use the <fc-',pkg,'> toolbox:\n']);
  vprintf(verbose,1,'   addpath(''%s'')\n',fc_pkg_dir);
  vprintf(verbose,1,['   fc_',pkg,'.init()\n']);
  logfile=[currentdir,filesep,'mfc_',pkg,'_set.m'];
  vprintf(verbose,1,'\n   See %s\n',logfile);
  fid=fopen(logfile,'w');
  fprintf(fid,'addpath(''%s'')\n',fc_pkg_dir);
  fprintf(fid,['fc_',pkg,'.init()\n']);
  fclose(fid);
end

function vprintf(verbose,level,varargin)
  if verbose>=level, fprintf(varargin{:});end
end

function fulldir=get_inst_fc_gen(name,ver,dir)
  filename=sprintf('fc_%s-%s.tar.gz',name,ver);
  urlfile=sprintf('http://www.math.univ-paris13.fr/~cuvelier/software/codes/Matlab/fc-%s/%s/%s',name,ver,filename);
  try
    options=weboptions; options.CertificateFilename=(''); % Trouble with certificat and "old" Matlab
    outputfilename=websave(filename,urlfile,options);
    untar(outputfilename,dir);
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

function fulldir=get_install(name,ver,dir,varargin)
  mfile=sprintf('mfc_%s_install',name);
  urlfile=sprintf('http://www.math.univ-paris13.fr/~cuvelier/software/codes/Matlab/fc-%s/%s/%s.m',name,ver,mfile);
  try
    options=weboptions; options.CertificateFilename=(''); % Trouble with certificat and "old" Matlab
    outputfilename=websave([mfile,'.m'],urlfile,options);
    %urlwrite(urlfile,[mfile,'.m']);
  catch
    error('Unable to get :\n  -> %s\n',urlfile);
  end
  A=ls();% force to (re)read current directory (needed with Matlab <= R2015a)
  eval([mfile,'(''dir'',dir,varargin{:})']) % run installation 
  fulldir=fullfile(pwd,sprintf('%s%sfc_%s-%s',dir,filesep,name,ver));
end
