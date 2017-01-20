function str=fun2str(f)
if fc_tools.utils.isfunhandle(f)
  if fc_tools.comp.isOctave()
    str=disp(f);str=str(1:end-1); % suppress '\n'
  else
    str=char(f);
  end
return;
end
if isscalar(f),str=num2str(f);return;end
str='unknow';
end
