function name = getComputerName()
% GETCOMPUTERNAME returns the name of the computer (hostname)
% name = getComputerName()
%
% WARN: output string is converted to lower case
%
%
% See also SYSTEM, GETENV, ISPC, ISUNIX
%
% m j m a r i n j (AT) y a h o o (DOT) e s
% (c) MJMJ/2007
%
if fc_tools.comp.isOctave()
  name=lower(gethostname());
else
  [ret, name] = system('hostname');   

  if ret ~= 0,
    fprintf(' hostname command return : <%s>\n',name);
    if ispc
	name = getenv('COMPUTERNAME');
    else      
	name = getenv('HOSTNAME');      
    end
  end
  name = lower(name);
  I=strfind(name,'.');
  if ~isempty(I)
    name=name(1:I(1)-1);
  end
  I=strfind(name,char(10));
  if ~isempty(I)
    name=name(1:I(1)-1);
  end
  %if ( name(end) == 10 )
  %  name=name(1:end-1);
  %end
end


