function OS = getOSinfo()
 OS=[];
 if isunix() && ~ismac()
   OS=getOSinfo_Unix();
 elseif ismac()
   OS=getOSinfo_macOS();
 elseif ispc()
   OS=getOSinfo_Windows();
 end
%  typ = getOStype();
%  distrib = getOSdistrib();
%  arch = getOSarch();
%  OS =struct('type',typ,'distrib',distrib,'arch',arch);
end

function OS=getOSinfo_Unix()
  [status,result]=fc_tools.sys.sec_system('lsb_release -a');
  lines = textscan( result, '%s', 'Delimiter', '\n' );
  lines=lines{1};
  OS.distributor=find_keyvalue('Distributor ID:*',lines);
  OS.description=find_keyvalue('Description:*',lines);
  OS.release=find_keyvalue('Release:*',lines);
  OS.codename=find_keyvalue('Codename:*',lines);
  [status,result]=fc_tools.sys.sec_system('uname -m');
  OS.arch=strtrim(result);
end

function OS=getOSinfo_Windows()
  [status,result]=fc_tools.sys.sec_system('wmic os get /value');
  lines = textscan( result, '%s', 'Delimiter', '\n' );
  lines=lines{1};
  OS.distributor=find_keyvalue('Manufacturer=*',lines);
  OS.description=find_keyvalue('Caption=*',lines);
  OS.codename=find_keyvalue('BuildNumber=*',lines);
  OS.release=find_keyvalue('Version=*',lines);
  OS.arch=find_keyvalue('OSArchitecture=*',lines);
end

function OS=getOSinfo_macOS()
  [status,result]=fc_tools.sys.sec_system('sw_vers');
  % Try also  'system_profiler SPSoftwareDataType'
  %[status,result]=fc_tools.sys.sec_system('sysctl -ea');
  lines = textscan( result, '%s', 'Delimiter', '\n' );
  lines=lines{1};
  OS.distributor='Apple Inc.';%find_keyvalue('Manufacturer=*',lines);
  OS.description=find_keyvalue('ProductName:*',lines);
  OS.codename=find_keyvalue('BuildVersion:*',lines);
  OS.release=find_keyvalue('ProductVersion:*',lines);
  
%    [status,result]=fc_tools.sys.sec_system('uname -s -r -m');
%    S=strsplit(strtrim(result),' ');
%    OS.codename=S{1};
%    OS.release=S{2};
%    OS.arch=S{3};
  [status,result]=fc_tools.sys.sec_system('uname -m');
  OS.arch=strtrim(result);
end

function value=find_keyvalue(key,lines)
% key='Distributor ID:*'
  C=regexp(lines,key,'split');
  idx=find(cellfun(@(x) length(x)==2,C));
  if ~isempty(idx)
    value=strtrim(C{idx(1)}{2});
  else
    warning('Unable to find key: ''%s''',key);
  end
end

function type = getOStype()
% getOSdistrib returns the type of the machine OS
% type = getOStype()
%
 type='unknow';
 if isunix() && ~ismac()
   type='Linux';
 elseif ismac()
   type='Mac';
 elseif ispc()
   type='Windows';
 end
end

function arch = getOSarch()
% getOSarch returns the architecture of the machine
% arch = getOSarch()
%
 if isunix()
   [status,arch]=system('uname -m');
   arch=strtrim(arch);
 end
end

function distrib = getOSdistrib()
% getOSdistrib returns the type of the machine OS distrib
% distrib = getOSdistrib()
%
%

 if isunix() && ~ismac()
   % vérifier si la distrib' est debian ou Ubuntu sinon pas de dpkg (yum)!!
   % test
   %% lsb is a string to check is lsb-release is installed
   %%[status,lsb]=system('dpkg -l lsb-release|grep ^ii');
   %
   % use of /etc/*release files
   if exist('/etc/os-release','file')
     [status,distrib]=system('a=`cat /etc/os-release|grep ^ID=|cut -d= -f2`;b=`cat /etc/os-release|grep ^VERSION=|cut -d\" -f2`;echo $a $b');
   elseif exist('/etc/redhat-release','file')
     [status,distrib]=system('cat /etc/redhat-release');
   else
   %%elseif regexp(lsb,'ii','start')
     % lsb_release is already installed
     [status,distrib]=system('lsb_release -a|grep ^Description|cut -d: -f2');
   end
   distrib=strtrim(distrib);
 else
   if ismac()
     [~,distrib]=system('sw_vers -productVersion');
     distrib=strtrim(distrib);
   else
     distrib='';
   end
 end
end
