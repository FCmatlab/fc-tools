function mfc_tools_configure(varargin)
%  FUNCTION  mfc_tools_configure
%    automaticaly configure the fc-tools toolbox in current directory
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
  pkg_version='0.0.24'; % automaticaly written by setpackages.py script
  
  ff=mfilename('fullpath');
  I=strfind(ff,filesep);
  lpath=ff(1:I(end));
  
  p = inputParser; 
  p.addParamValue('dir', [lpath,'fc-',pkg,'-',pkg_version], @ischar );
  p.addParamValue('verbose', 1, @(x) ismember(x,0:2) ); % level of verbosity 
  p.parse(varargin{:});
  verbose=p.Results.verbose;
  
  fc_pkg_dir=[p.Results.dir,filesep,'fc_',pkg,'-',pkg_version];
  
  currentdir=pwd;
  cd(fc_pkg_dir)
  vprintf(verbose,1,['1- Setting the <fc-',pkg,'> toolbox\n']);
  for i=1:length(pkgs)
    VarArgin{2*i-1}=['fc_',pkgs{i},'_dir'];
    VarArgin{2*i}=[p.Results.dir,filesep,'fc_',pkgs{i},'-',pkgs_version{i}];
  end
  eval(['fc_',pkg,'.configure(VarArgin{:});']);
  cd(currentdir)
  
  vprintf(verbose,1,'3- Using toolboxes :\n')
  for i=1:length(pkgs)
    vprintf(verbose,1,'   -> %20s : %s\n',['fc-',pkgs{i}],pkgs_version{i})
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
