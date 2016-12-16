function varargout=LegendPanel(axlegend,h,str,ncol)
axes(axlegend)
hh=copyobj(h,axlegend);
set(hh,'Visible','Off')

nblines=length(str);
nbpercolumn=ceil(nblines/ncol);

XData=[0.,0.05];
YDataUpper=[0.9,0.9];

k=1;i=0;j=0;
while k<=nblines
  if strcmp(get(hh(k),'Type'),'line')
    set(hh(k),'XData',XData+[0.3*j,0.3*j],'YData',YDataUpper-[0.2*i,0.2*i],'Visible','on','Clipping','Off')
    %tt(k)=text(XData(2)+0.3*j+0.01,YDataUpper(1)-0.2*i,str{k});
  elseif strcmp(get(hh(k),'Type'),'text')
    set(hh(k),'Position',[XData(1)+0.3*j,YDataUpper(1)-0.2*i,0],'Visible','on')
  elseif strcmp(get(hh(k),'Type'),'patch')  
    set(hh(k),'Visible','on','Clipping','Off')
    
    V=get(hh(k),'Vertices');
    N=size(V,1);
    V(:,1)=V(:,1)*0.04;
    V(:,2)=V(:,2)*0.1;
    V(:,3)=V(:,3)*0.1;N=size(V,1);
    axis([0,1,0,1])
    set(hh(k),'Vertices',V+ones(N,1)*[XData(1)+0.3*j,YDataUpper(1)-0.2*i,0])
    
  end
  tt(k)=text(XData(2)+0.3*j+0.01,YDataUpper(1)-0.2*i,str{k});
  i=i+1;
  if i>=nbpercolumn,i=0;j=j+1;end
  k=k+1;
end

axis auto
if nargout>=1, varargout{1}=hh;end
if nargout==2, varargout{2}=tt;end