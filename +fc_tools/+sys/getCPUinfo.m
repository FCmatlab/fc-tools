function cpu = getCPUinfo()

 cpu=[];
 if isunix() && ~ismac()
   cpu=getCPUinfo_Unix();
 elseif ismac()
   cpu=getCPUinfo_macOS();
 elseif ispc()
   cpu=getCPUinfo_Windows();
 end
%  typ = getOStype();
%  distrib = getOSdistrib();
%  arch = getOSarch();
%  OS =struct('type',typ,'distrib',distrib,'arch',arch);
end

function cpu=getCPUinfo_Unix()
  [status,result]=fc_tools.sys.sec_system('grep ''model name'' /proc/cpuinfo');
  Lines = textscan( result, '%s', 'Delimiter', '\n' );
  Lines=Lines{1}{1}; % All lines supposed to be equal 
%    cpu.thread=length(Lines);
%    Lines=Lines{1};
  i=strfind(Lines,':');
  cpu.name=strtrim(Lines(i+1:end));
  [status,result]=fc_tools.sys.sec_system('LANGUAGE=English lscpu');
  Lines = textscan( result, '%s', 'Delimiter', '\n' );Lines=Lines{1};
  cpu.nthreadspercore=int32(str2num(fc_tools.sys.find_keyvalue('Thread(s) per core',':',Lines)));
  cpu.ncoreperproc=int32(str2num(fc_tools.sys.find_keyvalue('Core(s) per socket',':',Lines)));
  cpu.nprocs=int32(str2num(fc_tools.sys.find_keyvalue('Socket(s)',':',Lines)));
end

function cpu=getCPUinfo_Windows()
  [status,result]=fc_tools.sys.sec_system('wmic cpu get /value');
  Lines = textscan( result, '%s', 'Delimiter', '\n' );
  Lines=Lines{1};
  cpu.name=fc_tools.sys.find_keyvalue('Name','=',Lines);
  
  cpu.ncoreperproc=int32(str2num(fc_tools.sys.find_keyvalue('NumberOfCores','=',Lines)));
  NumberOfLogicalProcessors=int32(str2num(fc_tools.sys.find_keyvalue('NumberOfLogicalProcessors',':',Lines)));
  cpu.nthreadspercore=NumberOfLogicalProcessors/cpu.ncoreperproc;
  [status,result]=fc_tools.sys.sec_system('wmic computersystem get numberofprocessors /value');
  Lines = textscan( result, '%s', 'Delimiter', '\n' );
  Lines=Lines{1};
  cpu.nprocs=int32(str2num(fc_tools.sys.find_keyvalue('NumberOfProcessors','=',Lines)));
end

function cpu=getCPUinfo_macOS()
  [status,result]=fc_tools.sys.sec_system('sysctl -a machdep.cpu.brand_string |cut -d: -f2');
  cpu.name=strtrim(result);
  [status,result]=fc_tools.sys.sec_system('sysctl hw');
  Lines = textscan( result, '%s', 'Delimiter', '\n' );
  Lines=Lines{1};
  cpu.ncoreperproc=int32(str2num(fc_tools.sys.find_keyvalue('hw.physicalcpu',':',Lines)));
  NumberOfLogicalProcessors=int32(str2num(fc_tools.sys.find_keyvalue('hw.logicalcpu',':',Lines)));
  cpu.nthreadspercore=NumberOfLogicalProcessors/cpu.ncoreperproc;
  
  [status,result]=fc_tools.sys.sec_system('system_profiler SPHardwareDataType');
  Lines = textscan( result, '%s', 'Delimiter', '\n' );
  Lines=Lines{1};
  cpu.nprocs=int32(str2num(fc_tools.sys.find_keyvalue('Number of Processors',':',Lines)));
end