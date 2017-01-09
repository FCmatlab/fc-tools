function S=interpreter(TeXstring)
if fc_tools.comp.isOctave()
  S=strrep(TeXstring,'$','');
  S=strrep(S,'\varphi','\phi');
  S=strrep(S,'\|','||');
  S=strrep(S,'\mathbf','');
else
  S=TeXstring;
end
