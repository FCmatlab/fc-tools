function snapshot(i)
  Monitors=fc_tools.graphics.monitors.get();
  M=Monitors(i,:);
  cmd=sprintf('import -silent -window root -crop %dx%d+%d+%d "snapshot-%d.png"',M(3),M(4),M(1)-1,M(2)-1,i)
  [status,result]=system(cmd);
end
