function RAM = getRAM()
%  FUNCTION RAM=fc_tools.sys.getRAM()
%    Return the RAM in GB of the computer
%
%  USAGE
%    RAM = fc_tools.sys.getRAM();
%
% <COPYRIGHT>
  RAM=[];
  if isunix() && ~ismac()
    RAM=getRAM_Unix();
  elseif ismac()
    RAM=getRAM_macOS();
  elseif ispc()
    RAM=getRAM_Windows();
  end
end

function RAM=getRAM_Unix()
  [status,result]=fc_tools.sys.sec_system('grep MemTotal: /proc/meminfo');
  RAM=str2num(result(regexp(strtrim(result),['\d'])))/(1024^2);
end

function RAM=getRAM_macOS()
  [status,result]=fc_tools.sys.sec_system('sysctl -n hw.memsize');
  RAM=str2num(strtrim(result))/(1024^3);
end

function RAM=getRAM_Windows()
  [status,result]=fc_tools.sys.sec_system('wmic ComputerSystem get  TotalPhysicalMemory /value');
  Lines = textscan( result, '%s', 'Delimiter', '\n' );Lines=Lines{1};
  RAM=str2num(fc_tools.sys.find_keyvalue('TotalPhysicalMemory','=',Lines))/(1024^3);
end
