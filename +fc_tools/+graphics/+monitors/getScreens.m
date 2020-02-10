function Screens=getScreens()
  if fc_tools.comp.isOctave()
    try
      Screens=getScreens_java();return  % failed if Octave compiled with JAVA disabled
    catch
      if ismac(), Screens=getScreens_mac();return;end
      if isunix(), Screens=getScreens_linux();return;end
      warning('not yet implemented')
    end
  else
    Screens=getScreens_Matlab();
  end
end

function Screens=getScreens_Matlab()
  Screens=get(groot(),'MonitorPositions');
end

function Screens=getScreens_java()
  filename=mfilename('fullpath');
  idx=strfind(filename,filesep);
  directory=filename(1:idx(end));
  jarfile=sprintf('%sScreens.jar',directory);
  javaaddpath(jarfile);
  S = javaObject ('Screens');
  nbScreens=S.getNb();
  R=zeros(nbScreens,4);
  for i=1:nbScreens
    R(i,:)=S.getScreen(i-1)'; % w h x y
  end
  maxY=max(R(:,4)+R(:,2));
  Screens=zeros(nbScreens,4);
  for i=1:nbScreens
    Screens(i,:)=[R(i,3)+1,maxY-R(i,4)-R(i,2)+1,R(i,1),R(i,2)];
  end
  javarmpath(jarfile)
end

function Screens=getScreens_mac()
  filename=mfilename('fullpath');
  idx=strfind(filename,filesep);
  directory=filename(1:idx(end));
  cmd=sprintf('osascript %smonitors.osx',directory);
  [status,result]=system(cmd);
  R=strsplit(result,',');
  R=cellfun(@str2num,R);
  assert(rem(size(R,2),4)==0)
  nbScreens=size(R,2)/4;
  Screens=reshape(R,4,nbScreens)';  % x y w h
end

function Screens=getScreens_linux()
  cmd='xrandr --listactivemonitors';
  [status,result]=system(cmd);
%    result =
%      'Screens: 2
%        0: +*DP-3 1920/382x1080/215+0+1080  DP-3
%        1: +DP-5 3840/953x2160/543+1920+0  DP-5
%       '
%    =>  N: <connect> W/?xH/?+X+Y
%     N, screen number
%     (X,Y)=(0,0) is the upper left virtual screen
  if status==0
    R=strsplit(result,'\n');
    R={R{cellfun(@(x) ~isempty(x),R)}}; % suppression cellule vide
    N=strsplit(R{1},' ');  % R{1}: 'Screens: 2'
    nbScreens=str2num(N{2});
    Mon=[];
    for i=1:nbScreens
      M=textscan(R{i+1},' %d: %s %d/%dx%d/%d+%d+%d %s');
      Mon=[Mon;[M{7},M{8},M{3},M{5}]]; % x y w h   (linux)
    end
    H=max(Mon(:,2)+Mon(:,4));
    Screens=zeros(nbScreens,4);
    for i=1:nbScreens
      % Octave/Matlab position, (x,y)=(1,1) is the lower left virtual screen
      Screens(i,:)=[Mon(i,1)+1,H-(Mon(i,2)+Mon(i,4))+1,Mon(i,3),Mon(i,4)];
    end
  else
    error('Command failed:\n  %s\n%s',cmd,result);
  end
end


%wmic path Win32_VideoController get CurrentHorizontalResolution,CurrentVerticalResolution

% Get-CimInstance -Namespace root\wmi -ClassName WmiMonitorBasicDisplayParams | select Active
