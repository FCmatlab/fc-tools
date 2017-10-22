function name = getComputerName()
% GETCOMPUTERNAME returns the name of the computer (hostname)
% name = getComputerName()
%
% output string is converted to lower case
 name='unknow';
 if isunix() && ~ismac()
   name=get_Unix();
 elseif ismac()
   name=get_macOS();
 elseif ispc()
   name=get_Windows();
 end
end

function name=get_Unix()
  [status,result]=fc_tools.sys.sec_system('hostname -s');
  if status==0, name=strtrim(result);else name='unkown';end
end

function name=get_macOS()
  [status,result]=fc_tools.sys.sec_system('hostname -s');
  if status==0, name=strtrim(result);else name='unkown';end
end

function name=get_Windows()
  [status,result]=fc_tools.sys.sec_system('hostname');
  if status==0, name=strtrim(result);else name='unkown';end
end
