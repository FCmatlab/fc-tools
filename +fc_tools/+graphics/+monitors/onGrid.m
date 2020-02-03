function onGrid(m,n,varargin)
  p = inputParser; 
  p.KeepUnmatched=true; 
  %p.PartialMatching=false;
  p.addParameter('figures',1:m*n);
  p.addParameter('positions',[]);
  p.parse(varargin{:});
  R=p.Results;
  varargin=fc_tools.utils.deleteCellOptions(varargin,p.Parameters);
  nf=length(R.figures);
  assert(nf<=m*n,'Grid too small')
  G=fc_tools.graphics.monitors.setGrid(m,n,varargin{:});
  if isempty(R.positions)
    R.positions=1:length(R.figures);
  else
    assert(length(R.positions)==length(R.figures))
  end
  I=repmat(1:m,n,1);I=I(:)';
  if fc_tools.comp.isOctave()
    hh=figure();%set(hh,'visible','off');
    refresh(hh)
    drawnow
    pos=get(hh,'position');
    opos=get(hh,'outerposition');
    wo=opos(3)-pos(3);
    ho=opos(4)-pos(4);
    close(hh)
    ho=113;wo=0;
  else
    wo=0;ho=0;
  end
    
  %I=repmat(1:m,1,n);
  %J=repmat(1:n,m,1);J=J(:)';
  J=repmat(1:n,1,m);
  for s=1:length(R.figures)
    numfig=R.figures(s);
    k=R.positions(s);
    assert(ismember(k,1:m*n))
    i=I(k);j=J(k);
    hdl=figure(numfig);
    if fc_tools.comp.isOctave() % BUG: 'outerposition' Octave option not as in Matlab
      set(hdl,'position',G(:,i,j)'-[0,0,wo,ho]);%,'visible','off') % 'visible' used to put figures in foreground
      % -> BUG: Sometimes, some figures are not correctly drawn. So I add:
      refresh(hdl)
      shg()
      set(hdl,'position',G(:,i,j)'-[0,0,wo,ho]);%,'visible','on') % 
%        refresh(hdl)
%        shg()
%        pause(0.1) 
      % <-
    else
      set(hdl,'outerposition',G(:,i,j)')
    end
    drawnow
  end
end
