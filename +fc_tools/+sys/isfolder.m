function bool=isDir(x)
  if isOctave()
    if strversion2num(version)<strversion2num('5.1.0'), bool=isdir(x); else, bool=isfolder(x);end
  else % 9.3.0 == 2017b
    if  verLessThan('matlab','9.3.0'), bool=isdir(x); else, bool=isfolder(x);end
  end
end
