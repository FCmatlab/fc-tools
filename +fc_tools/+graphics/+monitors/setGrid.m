function G=setGrid(m,n,varargin)
  % returns a m-by-n-by-4 array  (x,y,w,h) 
  L={'center','left','west','right','east','bottomright','southeast','bottom','south','bottomleft','southwest', ...
     'topleft','northwest','top','north','topright','northwest'};
  p = inputParser; 
  p.addParameter('monitor',1,@isscalar);
  p.addParameter('covers',3/4,@(x) isscalar(x) && (x>0) && (x<=1));
  p.addParameter('location','center',@(x) ismember(lower(x),L));
  p.addParameter('trans',[0,0],@(x) all(size(x)==[1,2])); % grid translation
  p.parse(varargin{:});
  R=p.Results;
  monitor=R.monitor;trans=R.trans;
  Monitors=fc_tools.graphics.monitors.get();
  if ~ismember(R.monitor,1:size(Monitors,1))
    R.monitor=1;
    warning('Force monitor number to 1')
  end
  G=zeros(4,m,n);
  X=Monitors(monitor,1);Y=Monitors(monitor,2);W=Monitors(monitor,3);H=Monitors(monitor,4);
  
  w=W*R.covers;h=H*R.covers;
  wl=fix(w/n);hl=fix(h/m);
  x=X;y=Y; % lowerleft
  switch lower(R.location)
    case 'center'
      x=X+(W-w)/2;
      y=Y+(H-h)/2;
    case {'left','west'}
      y=Y+(H-h)/2;
      x=X;
    case {'right','east'} % and 
      x=X+W-n*wl;  
      y=Y+(H-h)/2;
    case {'bottomright','southeast'} % and 
      x=X+W-n*wl;
      y=Y;
    case {'bottom','south'}
      x=X+(W-w)/2;
      y=Y;
    case {'bottomleft','southwest'}
      x=X;
      y=Y; 
    case {'topleft','northwest'}
      x=X;
      y=Y+H-m*hl;
    case {'top','north'}
      x=X+(W-w)/2;
      y=Y+H-m*hl;
    case {'topright','northeast'}  
      x=X+W-n*wl;
      y=Y+H-m*hl;
  end
  
  x=x+trans(1);y=y+trans(2);
  if x+w>X+W, x=X+W-w;end
  if y+h>Y+H, y=Y+H-h;end
  
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
