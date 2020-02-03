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
  G=fc_tools.graphics.screen.setGrid(m,n,varargin{:});
  if isempty(R.positions)
    R.positions=1:length(R.figures);
  else
    assert(length(R.positions)==length(R.figures))
  end
  I=repmat(1:m,n,1);I=I(:)';
  %I=repmat(1:m,1,n);
  %J=repmat(1:n,m,1);J=J(:)';
  J=repmat(1:n,1,m);
  for s=1:length(R.figures)
    numfig=R.figures(s);
    k=R.positions(s);
    assert(ismember(k,1:m*n))
    i=I(k);j=J(k);
    hdl=figure(numfig);
    set(hdl,'outerposition',G(:,i,j)')
  end
end

function [i,j]=bij(k,m)
  % k=(i-1)*m+j
  j=rem(k-1,m)+1;
  i=(k-j)/m+1;
end
