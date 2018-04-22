function spkg=fcpackagestr(tbxname,verbosity)
  if nargin==1, verbosity=1;end
  
  if fc_tools.comp.isOctave(), name='package';else, name='toolbox';end
  gettbxwithver=@(tbxname) sprintf('%s[%s]',tbxname,eval(sprintf('%s.version()',tbxname)));
  spkg=gettbxwithver(tbxname);
  if verbosity==1, return;end
    
  spkg=sprintf('%18s %s in path %s',spkg,name, ...
                         eval(sprintf('%s.path()',tbxname)));
end
