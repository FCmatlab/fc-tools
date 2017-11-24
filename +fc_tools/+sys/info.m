function varargout=info()
  Sout='';
  Sout=[Sout,sprintf('%15s: %s\n','hostname',fc_tools.sys.getComputerName())];
  Sout=[Sout,sprintf('%15s: %s\n','username',fc_tools.sys.getUserName())];
  Sout=[Sout,sprintf('------ SOFTWARE\n')];
  Sout=[Sout,sprintf('%15s: %s\n','name',fc_tools.sys.getSoftware())];
  Sout=[Sout,sprintf('%15s: %s\n','version',fc_tools.sys.getRelease())];
  Sout=[Sout,sprintf('------ SYSTEM\n')];
  Sout=[Sout,print_struct(fc_tools.sys.getOSinfo())];
  Sout=[Sout,sprintf('------ CPU\n')];
  Sout=[Sout,print_struct(fc_tools.sys.getCPUinfo())];
  Sout=[Sout,sprintf('------ RAM\n')];
  Sout=[Sout,sprintf('%15s: %.2f\n','in Go',fc_tools.sys.getRAM())];
  Sout=[Sout,sprintf('------ GRAPHIC\n')];
  if fc_tools.comp.isOctave()
    Sout=[Sout,sprintf('%15s: %s\n','Graphics Toolkit',graphics_toolkit())];
  else
    Sout=[Sout,print_struct(opengl('data'),'%30s')];
  end
  if nargout==0, fprintf(Sout);end
  if nargout==1, varargout{1}=Sout;end
end

function Sout=print_struct(S,format)
  Sout='';
  if nargin==1,format='%15s';end
  F=fieldnames(S);
  for i=1:length(F)
    V=getfield(S,F{i});
    if ~fc_tools.comp.isOctave() && isdatetime(V) % Only under Windows!
      Sout=[Sout,sprintf([format,': %s\n'],F{i},datestr(getfield(S,F{i})))];
    elseif ischar(V)
      Sout=[Sout,sprintf([format,': %s\n'],F{i},getfield(S,F{i}))];
    elseif isscalar(V)
      Sout=[Sout,sprintf([format,': %g\n'],F{i},getfield(S,F{i}))];
    end
  end
end

function Sout=print_struct_old(S,format)
  Sout='';
  if nargin==1,format='%15s';end
  F=fieldnames(S);
  for i=1:length(F)
    V=getfield(S,F{i});
    if ischar(V)
      Sout=[Sout,sprintf([format,': %s\n'],F{i},getfield(S,F{i}))];
    elseif isscalar(V)
      Sout=[Sout,sprintf([format,': %g\n'],F{i},getfield(S,F{i}))];
    else
    end
  end
end
