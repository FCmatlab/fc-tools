function [status,result]=sec_system(command)
  [status,result]=system(command);
  if status~=0
    error('[fc_tools] error: system command failed\n  -> %s\nwith status %d\nand output:\n%s\n',command,status,result) 
  end
end