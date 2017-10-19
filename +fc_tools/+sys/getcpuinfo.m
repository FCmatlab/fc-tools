function cpu = getcpuinfo()
ncoreperproc = getncoreperproc();
nproc = getnproc();
proc = getproc();
nthreadspercore = getnthreadspercore();
cpu =struct('Processor',proc,'ncoresperproc',ncoreperproc,'nprocs',nproc,'nthreadspercore',nthreadspercore);
end

function proc = getproc()
% getproc returns the machine characteristics
%
if isunix() && ~ismac()
    [status,proc]=system('cat /proc/cpuinfo|grep -m1 ^model\ name|cut -d: -f2');
    proc=strtrim(proc);
end
if ismac()
    [status,proc]=system('sysctl -a machdep.cpu.brand_string|cut -d: -f2');
    proc=strtrim(proc);
end
end

function ncore = getncoreperproc()
% getncoreperproc returns the number of cores per physical processor
%
if isunix() && ~ismac()
    [status,ncore]=system('lscpu|grep ''\(^Core(s) per socket\|^Cœur(s) par socket\)''|awk ''{print $4}''');
    ncore=str2num(strtrim(ncore));
end
if ismac()
    nphysproc=getnproc();
    [status,nc]=system('system_profiler SPHardwareDataType|grep "Total Number of Cores"|cut -d: -f2');
    nc=str2num(strtrim(nc));
    ncore=nc/nphysproc;
end
end

function nproc = getnproc()
%
if isunix() && ~ismac()
    [status,nproc]=system('lscpu|grep ^Socket|awk ''{print $2}''');
    nproc=str2num(strtrim(nproc));
end
if ismac()
    [status,nproc]=system('system_profiler SPHardwareDataType|grep "Number of Processors"|cut -d: -f2');
    nproc=str2num(strtrim(nproc));
end
end

function nthreads = getnthreads()

if isunix() && ~ismac()
    [status,nthreads]=system('lscpu|grep ''\(^Processeur(s)\|^CPU(s)\)''|awk ''{print $2}''');
    nthreads=str2num(strtrim(nthreads));
end
if ismac()
    [status,nthreads]=system('sysctl -a hw.logicalcpu|cut -d: -f2');
    nthreads=str2num(strtrim(nthreads));
end
end

function nthreads = getnthreadspercore()
if isunix() && ~ismac()
    [status,nthreads]=system('lscpu|grep ''\(^Thread(s) per core\|^Thread(s) par cœur\)''|cut -d: -f2');
    nthreads=str2num(strtrim(nthreads));
end
if ismac()
    nthreadstot=getnthreads();
    [status,nctot]=system('sysctl -a hw.physicalcpu|cut -d: -f2');
    %nb total of cores
    nctot=str2num(strtrim(nctot));
    nthreads=nthreadstot/nctot;
end

end