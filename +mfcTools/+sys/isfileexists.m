function bool=isfileexists(file)
  [fid,message]=fopen(file,'r');
  if ( fid == -1 ), bool=false;return;else bool=true; end
  fclose(fid);
end