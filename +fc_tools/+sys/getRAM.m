function RAM = getRAM()
% getMemory returns the RAM in Mo of the machine
% RAM = getRAM()
%
%
%
if isunix() && ~ismac()
    [status,RAM] = system('free -m|grep "Mem:"|awk ''{print $2}''');
    RAM=str2num(RAM);
else if ismac()
        [status,RAM] = system('sysctl -n hw.memsize | awk ''{print $0/1073741824" GB RAM"}''');
        RAM=strtrim(RAM);
    else
        [user,sys]=memory(); % on Windows
        RAM=sys.PhysicalMemory/(1024^2);
    end
end
