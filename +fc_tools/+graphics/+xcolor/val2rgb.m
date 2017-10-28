function rgb=val2rgb(val,varargin)
  assert( isnumeric(val) || ischar(val) );
  themes=get_themes();
  p = inputParser; 
  p.addParamValue('theme','matlab',@(x) ismember(x,themes));
  p.addParamValue('all',true,@islogical);
  p.addParamValue('check',true,@islogical);
  p.parse(varargin{:});
  theme=p.Results.theme;
  all=p.Results.all;
  rgb=[];
  if isnumeric(val)
    assert(sum(size(val)==[1,3])==2);
    rgb=val;
    return;
  end
  name=val;
  if strcmp(upper(name),'NONE')
    rgb='None';
    return
  end
  if all
    for i=1:length(themes)
      rgb=str2rgb_theme(themes{i},name);
      if ~isempty(rgb),return;end
    end
  else
    rgb=str2rgb_theme(theme,name);
  end
  if p.Results.check
    assert(~isempty(rgb),'unknow color %s',name);
  end
  if isempty(rgb),rgb=val;end % ex val = 'interp', 'none' (for EdgeColor, FaceColor)
end

function themes=get_themes()
  themes={'matlab','svg','X11'};
end

function rgb=str2rgb_theme(theme,name)
  [names,rgbs]=eval(sprintf('fc_tools.graphics.xcolor.%s()',theme));
  idx = find(ismember(upper(names), upper(name)));
  if isempty(idx)
    rgb=[];
  else
    rgb=rgbs(idx,:);
  end
end