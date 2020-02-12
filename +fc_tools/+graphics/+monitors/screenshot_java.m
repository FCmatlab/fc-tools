function screenshot_java(num,savename)
  filename=mfilename('fullpath');
  idx=strfind(filename,filesep);
  directory=filename(1:idx(end));
  jarfile=sprintf('%sMonitors.jar',directory);
  javaaddpath(jarfile);
  S = javaObject ('Monitors');

  S.screenshot(num-1,savename);
  javarmpath(jarfile)
end
