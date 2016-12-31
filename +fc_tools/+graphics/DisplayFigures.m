function options=DisplayFigures(varargin)
p = inputParser; 
p.addParameter('nfig',0,@isscalar); 
p.parse(varargin{:});
R=p.Results;
%set(0,'Units','normalized')
Pos=get(0,'ScreenSize');
x=Pos(1);y=Pos(2);
w=min(1920,Pos(3)); % For multiscreen under Octave
h=min(1080,Pos(4));
if R.nfig>0
  for i=1:R.nfig,figure(i);end
end

figHandles = get(0,'Children');
nf=length(figHandles);

mFontSize=[8,6,6,6];oFontSize=[8,6,6,6];
if nf==1,return;end
if nf<=4, nrow=2;ncol=2;mFontSize=[10,8,8,8];oFontSize=[16,14,14,14];
elseif nf<=6, nrow=2;ncol=3;oFontSize=[12,10,10,10];
elseif nf<=9, nrow=3;ncol=3;mFontSize=[8,5,6,6];oFontSize=[12,10,10,10];
elseif nf<=12, nrow=3;ncol=4;
elseif nf<=16, nrow=4;ncol=4;
elseif nf<=20, nrow=4;ncol=5;
elseif nf<=25, nrow=5;ncol=5;
else, error('to many figures');end

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

w=3/4*w;h=3/4*h;
wp=w/ncol;
hp=h/nrow;
toolbar_height = 77;
if fc_tools.comp.isOctave(), toolbar_height=toolbar_height+60;end
window_border  = 5;

% To sort figures
  if strcmp(class(figHandles(1)),'matlab.ui.Figure')
    I={figHandles(:).Number};
    [~,J]=sort(cell2mat(I));
  else
    if fc_tools.comp.isOctave(),J=nf:-1:1;else, J=1:nf;end
  end

  num=1;yp=20;
  for i=1:nrow
    xp=100;
    for j=1:ncol
      if strcmp(class(figHandles(1)),'matlab.ui.Figure')
        nfig=figHandles(J(num)).Number;
      else % old version
        nfig=figHandles(J(num));
      end
      h=figure(nfig); 
      set(h,'position',[xp yp wp hp])
      PrevPos=get(h,'position');
      xp=PrevPos(1)+PrevPos(3)+window_border;
      num=num+1;
      if num>nf, return;end
    end
    yp=PrevPos(2)+PrevPos(4)+toolbar_height+window_border;
  end
  drawnow

