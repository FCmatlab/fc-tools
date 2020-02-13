function show(varargin)
%
  Monitors=fc_tools.graphics.monitors.get();
  nS=size(Monitors,1);
%  figure()
  hold on
  for i=1:nS
    x=Monitors(i,1);y=Monitors(i,2);
    w=Monitors(i,3);h=Monitors(i,4);
    fill([x,x+w,x+w,x],[y,y,y+h,y+h],fc_tools.graphics.xcolor.val2rgb('LightGray'),'edgecolor','k')
    ht=text(x+w/2,y+h/2,num2str(i),'HorizontalAlignment','center');
    res=sprintf('%dx%d',w,h);
    text(x+w/10,y+h/10,res,'Fontsize',get(ht,'FontSize')-2,'FontAngle','italic');
  end
  axis off;axis image
  if nargin==0, return;end
  
  assert(nargin>=2);
  m=varargin{1};n=varargin{2};
  varargin={varargin{3:end}};
  G=fc_tools.graphics.monitors.setGrid(m,n,varargin{:});
  p = inputParser; 
  p.KeepUnmatched=true; 
  p.addParameter('figures',1:m*n);
  p.addParameter('positions',[]);
  p.parse(varargin{:});
  R=p.Results;
  if isempty(R.positions)
    R.positions=1:length(R.figures);
  else
    assert(length(R.positions)==length(R.figures))
  end
  Color=fc_tools.graphics.xcolor.val2rgb('olive');
  I=repmat(1:m,n,1);I=I(:)';
  J=repmat(1:n,1,m);
  for s=1:length(R.figures)
    numfig=R.figures(s);
    k=R.positions(s);i=I(k);j=J(k);
    assert(ismember(k,1:m*n))
    x=G(1,i,j);y=G(2,i,j);w=G(3,i,j);h=G(4,i,j);
    fill([x,x+w,x+w,x],[y,y,y+h,y+h],Color,'edgecolor',Color,'facecolor','none')
    ht=text(x+w/2,y+h/2,num2str(k),'color',Color,'HorizontalAlignment','center');
  end
end
