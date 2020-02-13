function demo03()
  close all
  nM=fc_tools.graphics.monitors.number(); 
  figure(1)
  fc_tools.graphics.monitors.show(3,3,'monitor',1,'covers',1)
  if nM>=2
    figure(2)
    fc_tools.graphics.monitors.show(4,3,'monitor',2, 'location','east','covers',3/4)
  end
  if nM>=3
    figure(3)
    fc_tools.graphics.monitors.show(3,2,'monitor',3, 'location','topleft','covers',3/4)
  end
  fc_tools.graphics.monitors.onGrid(2,2,'figures',1:min([nM,3]))
  pause(5)
  basename=sprintf('monitors%d_demo03',nM);
  fc_tools.graphics.SaveAllFigsAsFiles([basename,'_crop'],'format','pdf','pdfcrop',true,'cropmargin',5, 'dir',[fc_tools.path,'/doc/figures'],'tag',true,'verbose',true)
  fc_tools.graphics.SaveAllFigsAsFiles(basename,'format','pdf','dir',[fc_tools.path,'/doc/figures'],'tag',true,'verbose',true)
end
