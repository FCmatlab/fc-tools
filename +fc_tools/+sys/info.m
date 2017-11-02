function info()
  fprintf('%15s: %s\n','hostname',fc_tools.sys.getComputerName())
  fprintf('%15s: %s\n','username',fc_tools.sys.getUserName())
  fprintf('------ SOFTWARE\n')
  fprintf('%15s: %s\n','name',fc_tools.sys.getSoftware())
  fprintf('%15s: %s\n','version',fc_tools.sys.getRelease())
  fprintf('------ SYSTEM\n')
  print_struct(fc_tools.sys.getOSinfo())
  fprintf('------ CPU\n')
  print_struct(fc_tools.sys.getCPUinfo())
  fprintf('------ RAM\n')
  fprintf('%15s: %.2f\n','in Go',fc_tools.sys.getRAM())
end

function print_struct(S)
  F=fieldnames(S);
  for i=1:length(F)
    V=getfield(S,F{i});
    if ischar(V)
      fprintf('%15s: %s\n',F{i},getfield(S,F{i}))
    elseif isscalar(V)
      fprintf('%15s: %g\n',F{i},getfield(S,F{i}))
    else
    end
  end
end