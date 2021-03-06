function demo01(varargin)
  close all
  fc_tools.graphics.monitors.onGrid(2,3,'figures',1:6,'covers',4/5,varargin{:})
  fprintf('Creating 6 figures nicely centered and covers 4/5 of the screen\n')
  fprintf('waiting 2s ...\n');pause(2)
  fprintf('Moving the 6 figures on right/east and covers 2/3 of the screen\n')
  fc_tools.graphics.monitors.onGrid(2,3,'figures',1:6,'covers',2/3,'location','East',varargin{:})
  fprintf('waiting 2s ...\n');pause(2)
  fprintf('Moving the 6 figures on bottom/south and covers 4/5 of the screen\n')
  fc_tools.graphics.monitors.onGrid(2,3,'figures',1:6,'covers',4/5,'location','South',varargin{:})
  fprintf('waiting 2s ...\n');pause(2)
  fprintf('Moving the 6 figures on left/west and covers 2/3 of the screen\n')
  fc_tools.graphics.monitors.onGrid(2,3,'figures',1:6,'covers',2/3,'location','West',varargin{:})
  fprintf('waiting 2s ...\n');pause(2)
  fprintf('Moving the 6 figures on top/north and covers 4/5 of the screen\n')
  fc_tools.graphics.monitors.onGrid(2,3,'figures',1:6,'covers',4/5,'location','North',varargin{:})
end
