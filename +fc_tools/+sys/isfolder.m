function bool=isfolder(x)
  if fc_tools.comp.isOctave()
    if fc_tools.utils.strversion2num(version)<fc_tools.utils.strversion2num('5.1.0') 
      bool=isdir(x); 
    else 
      bool=isfolder(x);
    end
  else % 9.3.0 == 2017b
    if  verLessThan('matlab','9.3.0'), bool=isdir(x); else, bool=isfolder(x);end
  end
end
