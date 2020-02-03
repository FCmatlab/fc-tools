function show()
  Monitors=fc_tools.graphics.monitors.get();
  nS=size(Monitors,1);
  figure()
  hold on
  for i=1:nS
    x=Monitors(i,1);y=Monitors(i,2);
    w=Monitors(i,3);h=Monitors(i,4);
    fill([x,x+w,x+w,x],[y,y,y+h,y+h],fc_tools.graphics.xcolor.val2rgb('LightGray'),'edgecolor','k')
    ht=text(x+w/2,y+h/2,num2str(i));
    res=sprintf('%dx%d',w,h);
    text(x+w/10,y+h/10,res,'Fontsize',get(ht,'FontSize')-2,'FontAngle','italic');
  end
  axis off;axis image
end
