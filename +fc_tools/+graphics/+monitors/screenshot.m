function screenshot(i,varargin)
  if isunix()
    p = inputParser; 
    p.KeepUnmatched=true; 
    p.addParameter('file',sprintf('snapshot-%d.png',i),@ischar);
    p.addParameter('import_cmd','import'); % location ImageMagick import command. 
    p.addParameter('verbose',true,@islogical);
    p.parse(varargin{:});
    R=p.Results;
    import_cmd=R.import_cmd; 
    
    cmd=sprintf('%s --version',import_cmd);
    [status,result]=system(cmd);
    if status~=0, warning('Unable to find ImageMagick import command');return;end
    
    Monitors=fc_tools.graphics.monitors.get();
    nM=size(Monitors,1);
    if ~ismember(i,1:nM)
      warning('Unable to find monitor %d, only %d monitor(s) found',i,nM)
      return
    end
    
    ymax=max(Monitors(:,2)+Monitors(:,4));
    xmin=min(Monitors(:,1));
    Monitors(:,1)=Monitors(:,1)-xmin;
    Monitors(:,2)=-(Monitors(:,2)+Monitors(:,4))+ymax;
    
    M=Monitors(i,:);
    cmd=sprintf('import -silent -window root -crop %dx%d+%d+%d "%s"',M(3),M(4),M(1),M(2),R.file);
    [status,result]=system(cmd);
    if status~=0
    end
    if R.verbose
      fprintf('Creating screenshot of the monitor %d :\n   -> %s\n',i,R.file);
    end
  end
end
