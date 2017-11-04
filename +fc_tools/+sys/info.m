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
  fprintf('------ GRAPHIC\n')
  if fc_tools.comp.isOctave()
    fprintf('%15s: %s\n','Graphics Toolkit',graphics_toolkit())
  else
    print_struct(opengl('data'),'%30s')
  end
end

function print_struct(S,format)
  if nargin==1,format='%15s';end
  F=fieldnames(S);
  for i=1:length(F)
    V=getfield(S,F{i});
    if ~fc_tools.comp.isOctave() && isdatetime(V) % Only under Windows!
      fprintf([format,': %s\n'],F{i},datestr(getfield(S,F{i}))) 
    elseif ischar(V)
      fprintf([format,': %s\n'],F{i},getfield(S,F{i}))
    elseif isscalar(V)
      fprintf([format,': %g\n'],F{i},getfield(S,F{i}))
    end
  end
end

function print_struct_old(S,format)
  if nargin==1,format='%15s';end
  F=fieldnames(S);
  for i=1:length(F)
    V=getfield(S,F{i});
    if ischar(V)
      fprintf([format,': %s\n'],F{i},getfield(S,F{i}))
    elseif isscalar(V)
      fprintf([format,': %g\n'],F{i},getfield(S,F{i}))
    else
    end
  end
end