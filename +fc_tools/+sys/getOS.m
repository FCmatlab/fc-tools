function OS = getOS()
typ = getOStype();
distrib = getOSdistrib();
arch = getOSarch();
OS =struct('type',typ,'distrib',distrib,'arch',arch);
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
