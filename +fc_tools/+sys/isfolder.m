function bool=isfolder(X)
% FUNCTION bool=isfolder(X)
%   Return true if the string X is a folder
%
% USAGE
%   bool=isfolder(X);
%
% <COPYRIGHT>
  if fc_tools.comp.isOctave()
    if fc_tools.utils.strversion2num(version)<fc_tools.utils.strversion2num('5.1.0') 
      bool=isdir(X); 
    else 
      bool=isfolder(X);
    end
  else % 9.3.0 == 2017b
    if  verLessThan('matlab','9.3.0'), bool=isdir(X); else, bool=isfolder(X);end
  end
end
