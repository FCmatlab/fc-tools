function infoobject(self,varargin)
% FUNCTION info, method function of a class.
%   Displays informations on an object.
%
% <COPYRIGHT>
  p = inputParser; 
  p.addParamValue('maxlevel',3);
  p.addParamValue('currentlevel',1);
  p.addParamValue('tab',4);
  p.parse(varargin{:});
  currentlevel=p.Results.currentlevel;
  maxlevel=p.Results.maxlevel;
  tab=p.Results.tab;
  if currentlevel==1,fprintf('  %s with properties:\n',class(self));end
  warning off
  names = fieldnames(self);
  maxnamelen=max(cellfun(@numel,names));
  S=repmat(' ',1,tab*currentlevel);
  for i=1:length(names)
    value=getfield(self,names{i});N=size(value);
    fprintf('%s[%d] %s : [%s] %s\n',S,currentlevel,names{i},num2str(N),class(value))
    
    if currentlevel<maxlevel && prod(N)>0,printProperty(value,currentlevel+1,maxlevel,tab);end
  end
  warning on
end

function S=fillwith(name,c,nmax)
  n=numel(name);
  S=[repmat(c,1,nmax-n),name];
end

function printProperty(Value,currentlevel,maxlevel,tab)
  S=repmat(' ',1,tab*currentlevel);
  type=class(Value);
  if strcmp(type,'struct')
    names = fieldnames(Value);
    for i=1:length(names)
      value=getfield(Value,names{i});N=size(value);
      fprintf('%s[%d] %s : [%s] %s\n',S,currentlevel,names{i},num2str(N),class(value))
      if currentlevel<maxlevel && prod(N)>0,printProperty(value,currentlevel+1,maxlevel,tab);end
    end
   end

end
