function res=is_fcPackage(shortname,varargin)
% Check if a fc_<shortname> package/toolbox is present
% As example, shortname='hypermesh'
  p = inputParser; 
  p.addParamValue('verbose',false,@islogical); % use default colors
  p.parse(varargin{:});
  res=true;
  try
    eval(['fc_',shortname,'.version();']);
  catch 
    res=false;  
  end
  if p.Results.verbose && ~res
    if fc_tools.comp.isOctave(), name='package';else, name='toolbox';end
    warning('Unable to load fc_%s %s',shortname,name)
  end
end
