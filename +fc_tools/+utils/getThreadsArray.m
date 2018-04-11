function threads=getThreadsArray()
  cpu = fc_tools.sys.getCPUinfo();
  maxThreads=double(cpu.nprocs*cpu.ncoreperproc*cpu.nthreadspercore);
  threads=[];
  if maxThreads==12
    threads=[1,2,4,6,8,10,12];
  elseif maxThreads==14
    threads=[1,2,4,6,8,10,12,14];
  elseif maxThreads==16
    threads=[1,2,4,6,8,10,12,16];
  elseif maxThreads==18
    threads=[1,2,4,6,8,10,14,18];
  elseif maxThreads==20
    threads=[1,2,4,6,8,10,16,20];
  elseif maxThreads==22
    threads=[1,2,4,6,8,12,16,22];
  elseif maxThreads==24
    threads=[1,2,4,6,8,12,18,24];
  elseif maxThreads==28
    threads=[1,2,4,6,8,14,20,28];
  elseif maxThreads<=8
    threads=1:maxThreads;
  else
    error( 'not set for %s number of threads', maxThreads)
  end
end