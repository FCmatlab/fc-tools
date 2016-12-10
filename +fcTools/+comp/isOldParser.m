function bool=isOldParser()
% function bool=fcTools.comp.isOldParser()
%   To determine if the parser is old or not for Octave
%   
% Return values:
%  bool: true for an old parser (package general strictly before 2.0.0) false otherwise
%
% <COPYRIGHT>
bool=false;
if isOctave()
  desc=pkg('list','general');
  NumVer=str2num(strrep(desc{1,1}.version,'.',''));
  if NumVer<200
    bool=true;
  end
end
