function varsin=color_varargin(varsin,ColorListArgs,varargin)
  L=intersect(lower(ColorListArgs),lower({'EdgeColor','FaceColor','Color','BackgroundColor','MarkerFaceColor','MarkerEdgeColor'}));
  idx=cellfun(@(x) ismember(lower(x),L),{varsin{1:2:end}},'UniformOutput',false);
  idx=find([idx{:}]);
  for i=idx
    if ischar(varsin{2*i})
      if ~strcmp(varsin{2*i},'None')
         varsin{2*i}=fc_tools.graphics.xcolor.val2rgb(varsin{2*i},varargin{:}); 
      end
    else
      varsin{2*i}=fc_tools.graphics.xcolor.val2rgb(varsin{2*i},varargin{:}); 
    end
  end
end
