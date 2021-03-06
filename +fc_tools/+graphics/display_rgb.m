function display_rgb(rgb,name)
%  FUNCTION fc_tools.graphics.display_rgb
%    displays colors of a n-by-3 RGB colors array with their names
%    if available.
%  USAGE
%    fc_tools.graphics.display_rgb(rgb)
%      displays colors given by rgb a n-by-3 RGB colors array. The i-th color
%      given by rgb(i,:) is identified by the number i. 
%    fc_tools.graphics.display_rgb(rgb,name)
%      displays colors given by rgb a n-by-3 RGB colors array. The i-th color
%      given by rgb(i,:) is identified by the number i and its name given by 
%      the string name{i}.
% SAMPLES
%   colors=fc_tools.graphics.selectColors(10);
%   display_rgb(colors)
%
% <COPYRIGHT>
  clf
  assert(size(rgb,2)==3)
  N=size(rgb,1);
  if nargin==1 
    name=[];
    funname=@(k) num2str(k);
    strname='index';
  else
    assert( iscell(name) && length(name)==N )
    funname=@(k) name{k};
    strname='name'; 
  end
  if fc_tools.comp.isOctave()
    fontsize=10;
  else
    fontsize=6;
  end
  n=round(sqrt(4*N/3));
  m=round(3/4*n);
  if (n*m)<N,m=m+1;end
  
  beta=0.3;alpha=0.3;
  aw=1/(n+alpha*(n+1));sw=alpha*aw;
  ah=1/(m+beta*(m+1));sh=beta*ah;
  if fc_tools.comp.isOctave()
    ColorRec=@(k,x,y) fill([x,x+aw,x+aw,x],[y,y,y+ah,y+ah],rgb(k,:),'tag',funname(k),'ButtonDownFcn', @(h) fprintf('%s=''%s'';color=[%.6f,%.6f,%.6f];\n',strname,get (h, 'tag'),get(h,'facecolor')));
  else
    ColorRec=@(k,x,y) fill([x,x+aw,x+aw,x],[y,y,y+ah,y+ah],rgb(k,:),'tag',funname(k),'ButtonDownFcn', {@ColorSelected, {strname,funname(k),rgb(k,:)}});
  end
  fig=gcf();
  set(fig,'visible','off')
  set(fig,'position',[100,50,800,600])
  hold on
  k=1;y=1-(ah+sh);
  for i=1:m
    x=sw;
    for j=1:n
      if k<=N
        ColorRec(k,x,y)
        if isempty(name)
          text(x+aw/2,y+ah/2,funname(k),'HorizontalAlignment','center','BackgroundColor','w','Margin',1,'FontSize',fontsize);
        end
        x=x+aw+sw;
      end
      k=k+1;
    end
    y=y-(ah+sh);
  end
  axis off
  title('Mouse clic on color ...') 
  set(gcf(),'visible','on')
end

function ColorSelected(ObjectH, EventData, H)
  fprintf('%s= ''%s'';rgb=[%.6f,%.6f,%.6f];\n',H{1},H{2},H{3})
end
