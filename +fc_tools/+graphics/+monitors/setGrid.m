function G=setGrid(m,n,varargin)
  % returns a m-by-n-by-4 array  (x,y,w,h) 
  p = inputParser; 
  p.addParameter('screen',1,@isscalar);
  p.addParameter('cover',3/4,@(x) isscalar(x) && (x>0) && (x<=1));
  p.addParameter('trans',[0,0],@(x) all(size(x)==[1,2])); % grid translation
  p.parse(varargin{:});
  R=p.Results;
  screen=R.screen;trans=R.trans;
  Screens=fc_tools.graphics.screen.get();
  if ~ismember(R.screen,1:size(Screens,1))
    R.screen=1;
    warning('Force screen number to 1')
  end
  G=zeros(4,m,n);
  X=Screens(screen,1);Y=Screens(screen,2);W=Screens(screen,3);H=Screens(screen,4);
  w=W*R.cover;h=H*R.cover;
  x=X+trans(1);y=Y+trans(2);
  if x+w>X+W, x=X+W-w;end
  if y+h>Y+H, y=Y+H-h;end
  wl=fix(w/n);hl=fix(h/m);
  yl=y+(m-1)*hl;
  for i=1:m
    xl=x;
    for j=1:n
      G(:,i,j)=[xl,yl,wl,hl];
      xl=xl+wl;
    end
    yl=yl-hl;
  end
end
