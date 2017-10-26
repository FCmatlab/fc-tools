function Path=get_path()
  fullname=mfilename('fullpath');
  I=strfind(fullname,filesep);
  Path=fullname(1:(I(end-1)-1));
end