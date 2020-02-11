function demo03()
  close all
  fc_tools.graphics.monitors.show(3,2,'monitor',3,'location','topleft','covers',3/4)
  fc_tools.graphics.monitors.show(4,3,'monitor',2,'location','east','covers',3/4)
  fc_tools.graphics.monitors.show(3,3,'monitor',1,'covers',1)
  fc_tools.graphics.monitors.onGrid(2,2,'figures',1:3)
  %fc_tools.graphics.SaveAllFigsAsFiles('monitors_demo03_crop','format','pdf','pdfcrop',true, 'dir',[fc_tools.path,'/doc/figures'],'tag',true,'verbose',true)
 % fc_tools.graphics.SaveAllFigsAsFiles('monitors_demo03','format','pdf','dir',[fc_tools.path,'/doc/figures'],'tag',true,'verbose',true)
end
