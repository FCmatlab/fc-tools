function name=extractCurrentPath(fullname)
  PWD=pwd();
  name=strrep(fullname,pwd(),'.')
end
