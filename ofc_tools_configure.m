function ofc_tools_configure(varargin)
%  FUNCTION  ofc_tools_configure
%    automaticaly configure the fc-tools toolbox in current directory
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
  vprintf(verbose,1,['1- Setting the <fc-',pkg,'> package\n']);
  for i=1:length(pkgs)
    VarArgin{2*i-1}=['fc_',pkgs{i},'_dir'];
    VarArgin{2*i}=[p.Results.dir,filesep,'fc_',pkgs{i},'-',pkgs_version{i}];
  end
  eval(['fc_',pkg,'.configure(VarArgin{:});']);
  cd(currentdir)
  
  vprintf(verbose,1,'2- Using packages :\n')
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
