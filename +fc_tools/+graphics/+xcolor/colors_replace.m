function varargin=colors_replace(varargin)
  L=lower({'EdgeColor','FaceColor','Color','BackgroundColor','MarkerFaceColor','MarkerEdgeColor'});
  idx=cellfun(@(x) ismember(lower(x),L),{varargin{1:2:end}},'UniformOutput',false);
  idx=find([idx{:}]);
  for i=idx
    varargin{2*i}=fc_tools.graphics.xcolor.val2rgb(varargin{2*i}); 
  end
end
