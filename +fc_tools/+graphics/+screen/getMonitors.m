function Monitors=getMonitors()

  Monitors=getMonitors_linux();
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
