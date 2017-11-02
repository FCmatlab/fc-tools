function res=is_fcPackage(shortname)
% Check if a fc_<shortname> package/toolbox is present
% As example, shortname='hypermesh'
  res=true;
  try
    eval(['fc_',shortname,'.version();']);
  catch 
    res=false;  
  end
end