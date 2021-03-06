function Monitors=getMonitors()
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
  R=get(groot(),'MonitorPositions');
  nbMonitors=size(R,1);
  for i=1:nbMonitors
    Monitors(i)=struct('x',R(i,1),'y',R(i,2),'w',R(i,3),'h',R(i,4));
  end
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
    R(i,:)=S.getScreen(i-1)'; % w h x y
  end
  maxY=max(R(:,4)+R(:,2));
  for i=1:nbMonitors
    Monitors(i)=struct('x',R(i,3)+1,'y',maxY-R(i,4)-R(i,2)+1,'w',R(i,1),'h',R(i,2));
  end
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
  Mon=reshape(R,4,nbMonitors)';  % x y w h
  minX=min(Mon(:,1));
  minY=min(Mon(:,2));
  for i=1:nbMonitors
    % Octave/Matlab position, (x,y)=(1,1) is the lower left virtual screen
    Monitors(i)=struct('x',Mon(i,1),'y',Mon(i,2),'w',Mon(i,3),'h',Mon(i,4));
  end
end

function Monitors=getMonitors_linux()
  cmd='xrandr --listactivemonitors';
  [status,result]=system(cmd);
%    result =
%      'Monitors: 2
%        0: +*DP-3 1920/382x1080/215+0+1080  DP-3
%        1: +DP-5 3840/953x2160/543+1920+0  DP-5
%      '
%   or
%      'Monitors: 3
%        0: +*VGA-0 1920/521x1080/293+1920+0  VGA-0
%        1: +DP-0 1920/521x1080/293+3840+0  DP-0
%        2: +DP-3 1920/350x1080/190+0+189  DP-3
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
    for i=1:nbMonitors
      % Octave/Matlab position, (x,y)=(1,1) is the lower left virtual screen
      Monitors(i)=struct('x',Mon(i,1)+1,'y',H-(Mon(i,2)+Mon(i,4))+1,'w',Mon(i,3),'h',Mon(i,4));
    end
  else
    error('Command failed:\n  %s\n%s',cmd,result);
  end
end


%wmic path Win32_VideoController get CurrentHorizontalResolution,CurrentVerticalResolution

% Get-CimInstance -Namespace root\wmi -ClassName WmiMonitorBasicDisplayParams | select Active
