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
  if isempty(G),fprintf('fc_tools.graphics.monitors.%s: function disabled\n',mfilename());return;end
  if isempty(R.positions)
    R.positions=1:length(R.figures);
  else
    assert(length(R.positions)==length(R.figures))
  end
  
  if fc_tools.comp.isOctave(), ho=113;wo=0;else, wo=0;ho=0; end
    
  dispatch(m,n,R,G,wo,ho)
  drawnow;
  if fc_tools.comp.isOctave() % Bug with MacOS: 1st figure not inplace 
    pause(0.5)
    dispatch(m,n,R,G,wo,ho)
    drawnow;pause(0.5)
  end
end

function dispatch(m,n,R,G,wo,ho)
  I=repmat(1:m,n,1);I=I(:)';
  J=repmat(1:n,1,m);
  for s=1:length(R.figures)
    numfig=R.figures(s);
    k=R.positions(s);
    assert(ismember(k,1:m*n))
    i=I(k);j=J(k);
    if fc_tools.comp.isOctave() % BUG: 'outerposition' Octave option not as in Matlab
      outerposition=G(:,i,j)';
      position=G(:,i,j)'-[0,0,wo,ho];
      hdl=figure(numfig);
      drawnow
      set(hdl,'position',position,'outerposition',outerposition);%,'visible','off') % 'visible' used to put figures in foreground
    else
      hdl=figure(numfig);
      drawnow
      set(hdl,'outerposition',G(:,i,j)')
    end
    %drawnow
  end  
end
