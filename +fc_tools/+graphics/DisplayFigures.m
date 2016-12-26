function DisplayFigures()
%set(0,'Units','normalized')
Pos=get(0,'ScreenSize');
x=Pos(1);y=Pos(2);
w=min(1920,Pos(3)); % For multiscreen under Octave
h=min(1080,Pos(4));
figHandles = get(0,'Children');
nf=length(figHandles);
if nf==1,return;end
if nf<=4, nrow=2;ncol=2;
elseif nf<=6, nrow=2;ncol=3;
elseif nf<=9, nrow=3;ncol=3;
elseif nf<=12, nrow=3;ncol=4;
elseif nf<=16, nrow=4;ncol=4;
elseif nf<=20, nrow=4;ncol=5;
elseif nf<=25, nrow=5;ncol=5;
else, error('to many figures');end
w=2/3*w;h=2/3*h;
wp=w/ncol;
hp=h/nrow;
toolbar_height = 77;
window_border  = 5;
% To sort figures
if strcmp(class(figHandles(1)),'matlab.ui.Figure')
  I={figHandles(:).Number};
  [~,J]=sort(cell2mat(I));
else
  J=1:nf;
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
    %if isOctave()
    %else
    set(h,'position',[xp yp wp hp])
    PrevPos=get(h,'position');
    xp=PrevPos(1)+PrevPos(3)+window_border;
    %end
    num=num+1;
    if num>nf, return;end
  end
  yp=PrevPos(2)+PrevPos(4)+toolbar_height+window_border;
end