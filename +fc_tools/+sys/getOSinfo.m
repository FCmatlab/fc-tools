function OS = getOSinfo()
%  FUNCTION OS=fc_tools.sys.getOSinfo()
%    Return a structure with OS informations: 
%      * distributor 
%      * description  
%      * release      
%      * codename   
%      * arch        
%      * shortname
%
%  USAGE
%    OS = fc_tools.sys.getOSinfo()
%
% <COPYRIGHT>
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
  [status,result]=system('lsb_release -a 2> /dev/null');
  if status==0
    Lines = textscan( result, '%s', 'Delimiter', '\n' );
    Lines=Lines{1};
    OS.distributor=fc_tools.sys.find_keyvalue('Distributor ID',':',Lines);
    OS.description=fc_tools.sys.find_keyvalue('Description',':',Lines);
    OS.release=fc_tools.sys.find_keyvalue('Release',':',Lines);
    OS.codename=fc_tools.sys.find_keyvalue('Codename',':',Lines);
  elseif exist('/etc/os-release','file')
      fid=fopen('/etc/os-release','r');
      Lines = textscan( fid, '%s', 'Delimiter', '\n' );
      fclose(fid);
      Lines=Lines{1};
      OS.distributor=fc_tools.sys.find_keyvalue('ID','=',Lines);
      OS.description=suppress_string_delimiter(fc_tools.sys.find_keyvalue('PRETTY_NAME','=',Lines));
      OS.release=fc_tools.sys.find_keyvalue('VERSION_ID','=',Lines);
      %OS.codename=fc_tools.sys.find_keyvalue('Codename',':',Lines);
      OS.codename='Unknow';
  else
      %fprintf('[fc-tools] Unable to guess Unix system name\n');
      OS.distributor='UNIX';
      OS.description='Unknow';
      OS.release='Unknow';
      OS.codename='Unknow';
  end
  [status,result]=fc_tools.sys.sec_system('uname -m');
  OS.arch=strtrim(result);
  OS.shortname=OS.distributor;
end

function OS=getOSinfo_Windows()
  [status,result]=fc_tools.sys.sec_system('wmic os get /value');
  lines = textscan( result, '%s', 'Delimiter', '\n' );
  lines=lines{1};
  OS.distributor=fc_tools.sys.find_keyvalue('Manufacturer','=',lines);
  OS.description=fc_tools.sys.find_keyvalue('Caption','=',lines);
  OS.codename=fc_tools.sys.find_keyvalue('BuildNumber','=',lines);
  OS.release=fc_tools.sys.find_keyvalue('Version','=',lines);
  OS.arch=fc_tools.sys.find_keyvalue('OSArchitecture','=',lines);
  OS.shortname='Windows';
end

function OS=getOSinfo_macOS()
  [status,result]=fc_tools.sys.sec_system('sw_vers');
  % Try also  'system_profiler SPSoftwareDataType'
  %[status,result]=fc_tools.sys.sec_system('sysctl -ea');
  Lines = textscan( result, '%s', 'Delimiter', '\n' );
  Lines=Lines{1};
  OS.distributor='Apple Inc.';%find_keyvalue('Manufacturer=*',lines);
  OS.description=fc_tools.sys.find_keyvalue('ProductName',':',Lines);
  OS.codename=fc_tools.sys.find_keyvalue('BuildVersion',':',Lines);
  OS.release=fc_tools.sys.find_keyvalue('ProductVersion',':',Lines);
  OS.shortname='macOS';
  
%    [status,result]=fc_tools.sys.sec_system('uname -s -r -m');
%    S=strsplit(strtrim(result),' ');
%    OS.codename=S{1};
%    OS.release=S{2};
%    OS.arch=S{3};
  [status,result]=fc_tools.sys.sec_system('uname -m');
  OS.arch=strtrim(result);
end

%  function value=find_keyvalue(key,sep,Lines)
%  % key='Distributor ID' sep=':'
%    %C=regexp(lines,key,'split');
%    %idx=find(cellfun(@(x) length(x)==2,C));
%    fkey=[key,sep];
%    idx=find(strncmp(Lines,fkey,length(fkey)));
%    assert(length(idx)<=1)
%    if ~isempty(idx)
%      is=strfind(Lines{idx},sep);
%      value=strtrim(Lines{idx}(is+1:end));
%    else
%      warning('Unable to find key: ''%s''',key);
%    end
%  end

function str=suppress_string_delimiter(str)
  if str(1)=='"' && str(end)=='"'
    str=str(2:end-1);
  end
end
