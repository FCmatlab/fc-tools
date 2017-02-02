function varargin=color_varargin(varargin,ColorListArgs)
  L=intersect(lower(ColorListArgs),lower({'EdgeColor','FaceColor','Color'}));
  idx=cellfun(@(x) ismember(lower(x),L),{varargin{1:2:end}},'UniformOutput',false);
  idx=find([idx{:}]);
  for i=idx, varargin{2*i}=fc_tools.graphics.xcolor.val2rgb(varargin{2*i},'check',false); end
end