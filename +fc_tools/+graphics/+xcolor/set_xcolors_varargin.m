function varsin=set_xcolors_varargin(varsin,ColorListName,varargin)
  if nargin==1,ColorListName='';end
  if isempty(ColorListName),  ColorListName={'EdgeColor','FaceColor','Color','BackgroundColor'};end
  idx=cellfun(@(x) ismember(lower(x),lower(ColorListName)),{varsin{1:2:end}},'UniformOutput',false);
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
