function varargout=DisplayFiguresNew(varargin)
% FUNCTION fc_tools.graphics.DisplayFigures
%   Regularly distributes the figures on the screen.
% USAGE
%   fc_tools.graphics.DisplayFigures()
%   fc_tools.graphics.DisplayFigures(n)
%   fc_tools.graphics.DisplayFigures('nfig',n)
%
%   Without argument, all figures are regularly distributed on the screen.
%   Otherwise, empty figures with numbers 1 to n are created and regularly 
%   distributed on the screen.
%
% SAMPLES
%   fc_tools.graphics.DisplayFigures()
%   fc_tools.graphics.DisplayFigures(5)
%   fc_tools.graphics.DisplayFigures('nfig',5)
%
%    <COPYRIGHT> 
  if nargin==1 % Compatibilty with old version
    R.nfig=varargin{1};
  else
    p = inputParser; 
    p.addParameter('nfig',0,@isscalar); 
    p.addParameter('screen',1,@isscalar);
    p.addParameter('cover',3/4,@isscalar);
    p.parse(varargin{:});
    R=p.Results;
  end
  %set(0,'Units','normalized')
  screen=R.screen;cover=min(R.cover,1);
  mFontSize=[8,6,6,6];oFontSize=[8,6,6,6]; %default
  if R.nfig<=0 && nargin>0 
    options=BuildOptions(mFontSize,oFontSize);
    return;
  end
  M=fc_tools.graphics.screen.getMonitors();
  X=M(screen).x;Y=M(screen).y;W=M(screen).w;H=M(screen).h;
  
  for i=1:R.nfig
    hd(i)=figure(i);
    %set(hd(i),'visible','off'); % BUG with Octave under windows??
  end

  figHandles = get(0,'Children');
  nf=length(figHandles);

  if nf<=1,return;end
  if nf<=4, nrow=2;ncol=2;mFontSize=[10,8,8,8];oFontSize=[16,14,14,14];
  elseif nf<=6, nrow=2;ncol=3;oFontSize=[12,10,10,10];
  elseif nf<=9, nrow=3;ncol=3;mFontSize=[8,5,6,6];oFontSize=[12,10,10,10];
  elseif nf<=12, nrow=3;ncol=4;
  elseif nf<=16, nrow=4;ncol=4;
  elseif nf<=20, nrow=4;ncol=5;
  elseif nf<=25, nrow=5;ncol=5;
  elseif nf<=30, nrow=5;ncol=6;
  elseif nf<=36, nrow=6;ncol=6;
  else, error('to many figures');end
  options=BuildOptions(mFontSize,oFontSize);
  if nargout==1,varargout{1}=options;end

  w=cover*W;h=cover*H;
  toolbar_height = 77;
  if fc_tools.comp.isOctave(), toolbar_height=toolbar_height+60;end
  wp=w/ncol;
  hp=h/nrow-toolbar_height;
  window_border  = 5;
  % To sort figures
  if strcmp(class(figHandles(1)),'matlab.ui.Figure')
    I={figHandles(:).Number};
    [~,J]=sort(cell2mat(I));
  else
    if fc_tools.comp.isOctave(),J=nf:-1:1;else, J=1:nf;end
  end
  %get(figHandles(1),'position')
  num=1;yp=Y+20;
  for i=1:nrow
    xp=X+50;
    for j=1:ncol
      if strcmp(class(figHandles(1)),'matlab.ui.Figure')
        nfig=figHandles(J(num)).Number;
      else % old version
        nfig=figHandles(J(num));
      end
      h=figure(nfig);
      %set(h,'visible','off');
      set(hd(num),'position',[xp yp wp hp])
	  if ispc() && fc_tools.comp.isOctave() % !!! need under Windows with octave
	    %drawnow('expose')
	    pause(0.2);
		%set(hd(i),'visible','off');
		set(hd(num),'position',[xp yp wp hp])
		%set(hd(i),'visible','on');
		%refresh(hd(num))
	  end 
	  drawnow % need under MacOS with octave
	  PrevPos=get(hd(num),'position');
      xp=PrevPos(1)+PrevPos(3)+window_border;
      num=num+1;
      %set(h,'visible','on');
      if num>nf, return;end
    end
    yp=PrevPos(2)+PrevPos(4)+toolbar_height+window_border;
  end
  %drawnow
%  for i=1:R.nfig
%    if ispc() && fc_tools.comp.isOctave() % !!! need under Windows with octave%
%	  h=figure(i);
%	else
%      set(hd(i),'visible','on');
%	end
%  end
%  drawnow
end

function options=BuildOptions(mFontSize,oFontSize)
  if fc_tools.comp.isOctave()
    options.interpreter={'interpreter','tex'};
    options.title={'fontsize',oFontSize(1)};
    options.colorbar={'fontsize',oFontSize(2)};
    options.legend={'fontsize',oFontSize(3)};
    options.axes={'fontsize',oFontSize(4)};
    options.iso={'color','w'};
  else
    options.interpreter={'interpreter','latex'};
    options.title={'fontsize',mFontSize(1)};
    options.colorbar={'fontsize',mFontSize(2)};
    options.legend={'fontsize',mFontSize(3)};
    options.axes={'fontsize',mFontSize(4)};
    options.iso={};
  end
end
