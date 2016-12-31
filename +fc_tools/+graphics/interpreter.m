function S=interpreter(TeXstring)
if fc_tools.comp.isOctave()
  S=strrep(TeXstring,'$','');
  S=strrep(S,'\varphi','\phi');
  S=strrep(S,'\|','||');
else
  S=TeXstring;
end
