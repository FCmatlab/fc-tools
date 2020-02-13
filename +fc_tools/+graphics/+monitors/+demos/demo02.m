function demo02(save)
  if nargin==0,save=false;end
  x=0:pi/100:2*pi;
  close all
  fc_tools.graphics.monitors.onGrid(2,3,'figures',[1,3], 'positions',[2,6],'covers',4/5)
  figure(1)
  plot(x,sin(x))
  figure(3)
  plot(x,cos(x))
  fc_tools.graphics.monitors.onGrid(2,3,'figures',[2,4], 'positions',[1,5],'covers',4/5)
  figure(2)
  plot(sin(x),cos(x))
  axis equal
  figure(4)
  plot(2*sin(x),cos(x))
  axis equal
  fprintf('waiting 2s ...\n');pause(2)
  if save
    [soft,Release]=fc_tools.sys.getSoftware();Release=strrep(Release,'.','');
    basename=sprintf('monitors1_demo02_before_%s%s.png',soft,Release);
    fc_tools.graphics.monitors.screenshot(1,'file',[fc_tools.path,'/doc/figures/',basename],'verbose',true)
  end
  fprintf('Moving the 4 figures on topleft/northwest and covers 2/3 of the screen\n')
  fc_tools.graphics.monitors.onGrid(2,2,'figures',1:4,'covers',4/5, 'location','NorthWest')
  fprintf('waiting 2s ...\n');pause(2)
  if save
    basename=sprintf('monitors1_demo02_after_%s%s.png',soft,Release);
    fc_tools.graphics.monitors.screenshot(1,'file',[fc_tools.path,'/doc/figures/',basename],'verbose',true)
  end
end
