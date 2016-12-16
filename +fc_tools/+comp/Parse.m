function p=Parse(p,varargin)
% FUNCTION p=fc_tools.comp.Parse(p,varargin)
% Alternative function for parse - Suitable for Matlab and any Octave version
% To parse and validate input arguments.
%
% Input and output parameter:
% p : inputParser object
%
% <COPYRIGHT>
  if isOldParser()
    p=p.parse(varargin{:});
  else
    p.parse(varargin{:});
  end
end