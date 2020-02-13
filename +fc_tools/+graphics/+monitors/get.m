function Monitors=get()
  % 
  %  for i-th monitor,  x y w h are in Monitors(i,:)
  if fc_tools.comp.isOctave()
    try
      Monitors=getMonitors_java();return  % failed if Octave compiled with JAVA disabled
    catch
      if ismac(), Monitors=getMonitors_mac();return;end
      if isunix(), Monitors=getMonitors_linux();return;end
      warning('not yet implemented')
    end
  else
    Monitors=getMonitors_Matlab();
  end
end

function Monitors=getMonitors_Matlab()
  Monitors=get(groot(),'MonitorPositions');
end

function Monitors=getMonitors_java()
  filename=mfilename('fullpath');
  idx=strfind(filename,filesep);
  directory=filename(1:idx(end));
  jarfile=sprintf('%sMonitors.jar',directory);
  javaaddpath(jarfile);
  S = javaObject ('Monitors');
  nbMonitors=S.getNb();
  R=zeros(nbMonitors,4);
  for i=1:nbMonitors
    Si=S.getScreen(i-1)';
    R(i,:)=Si(1:4); % w h x y
  end
  maxY=max(R(:,4)+R(:,2));
  Monitors=zeros(nbMonitors,4);
  for i=1:nbMonitors
    Monitors(i,:)=[R(i,3)+1,maxY-R(i,4)-R(i,2)+1,R(i,1),R(i,2)]; % x y w h
  end
  clear S;
  javarmpath(jarfile)
end

function Monitors=getMonitors_mac()
  filename=mfilename('fullpath');
  idx=strfind(filename,filesep);
  directory=filename(1:idx(end));
  cmd=sprintf('osascript %smonitors.osx',directory);
  [status,result]=system(cmd);
  R=strsplit(result,',');
  R=cellfun(@str2num,R);
  assert(rem(size(R,2),4)==0)
  nbMonitors=size(R,2)/4;
  Monitors=reshape(R,4,nbMonitors)';  % x y w h
end

function Monitors=getMonitors_linux()
  cmd='xrandr --listactivemonitors';
  [status,result]=system(cmd);
%    result =
%      'Monitors: 2
%        0: +*DP-3 1920/382x1080/215+0+1080  DP-3
%        1: +DP-5 3840/953x2160/543+1920+0  DP-5
%       '
%    =>  N: <connect> W/?xH/?+X+Y
%     N, screen number
%     (X,Y)=(0,0) is the upper left virtual screen
  if status==0
    R=strsplit(result,'\n');
    R={R{cellfun(@(x) ~isempty(x),R)}}; % suppression cellule vide
    N=strsplit(R{1},' ');  % R{1}: 'Monitors: 2'
    nbMonitors=str2num(N{2});
    Mon=[];
    for i=1:nbMonitors
      M=textscan(R{i+1},' %d: %s %d/%dx%d/%d+%d+%d %s');
      Mon=[Mon;[M{7},M{8},M{3},M{5}]]; % x y w h   (linux)
    end
    H=max(Mon(:,2)+Mon(:,4));
    Monitors=zeros(nbMonitors,4);
    for i=1:nbMonitors
      % Octave/Matlab position, (x,y)=(1,1) is the lower left virtual screen
      Monitors(i,:)=[Mon(i,1)+1,H-(Mon(i,2)+Mon(i,4))+1,Mon(i,3),Mon(i,4)];
    end
  else
    error('Command failed:\n  %s\n%s',cmd,result);
  end
end


%wmic path Win32_VideoController get CurrentHorizontalResolution,CurrentVerticalResolution

% Get-CimInstance -Namespace root\wmi -ClassName WmiMonitorBasicDisplayParams | select Active
