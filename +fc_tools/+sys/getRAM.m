function RAM = getRAM()
% getRAM returns the RAM in Go of the machine
% RAM = getRAM()
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
  RAM=str2num(strtrim(result))/(1024^2);
end

function RAM=getRAM_Windows()
  [status,result]=fc_tools.sys.sec_system('wmic ComputerSystem get  TotalPhysicalMemory');
  RAM=str2num(strtrim(result))/(1024^2);
end