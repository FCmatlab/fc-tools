function p=path()
  fullname=mfilename('fullpath');
  I=strfind(fullname,filesep);
  p=fullname(1:(I(end-1)-1));
end
