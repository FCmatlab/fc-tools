function PrintLatexTabularArrayV2(Data,Header,Caption,DataFormat,ColumnFormat,RowFormat,RowHeaderFormat,LaTeXFilename,varargin)
% DataFormat={'$%d$','$%d$','%.3f','%.3f','%.3f'}
% ColumnFormat='|r|r||*{3}{c|}'
% RowFormat='\hline';
% RowHeaderFormat='\hline \hline';
% Header={'$N$','$n_q$','Matlab','Octave','FreeFEM++'}
% Data array
  p = inputParser;
  if isOctave()
    p=p.addParamValue('mode', 'w' , @ischar );
    p=p.addParamValue('comment', '% Generic Comment' , @ischar );
    p=p.addParamValue('fid', 1  , @isnumeric);
    p=p.parse(varargin{:});
  else
    p.addParamValue('mode', 'w' , @ischar );
    p.addParamValue('comment', '% Generic Comment' , @ischar );
    p.addParamValue('fid', 1  , @isnumeric);
    p.parse(varargin{:});
  end
  comment=p.Results.comment;
  [nR,nCG]=size(Data);
  nC=length(Header);
  if isempty(LaTeXFilename)
    fid=p.Results.fid;
  else
   fid=fopen(LaTeXFilename,p.Results.mode);
   if (fid == -1)
    error(['Cannot open file ',LaTeXFilename]);
   end
  end
  fprintf(fid,'%s\n',comment);
  if ~isempty(Caption)
    fprintf(fid,'\\ifdefined\\TabularWithCaption\n');
    fprintf(fid,'\\begin{table}[htbp]\n');
    fprintf(fid,'\\begin{center}\n');
    fprintf(fid,'\\noindent\\adjustbox{max width=\\textwidth}{\n');
    fprintf(fid,'\\fi\n');
  end
  fprintf(fid,'\\begin{tabular}{%s}\n',ColumnFormat);
  fprintf(fid,'  %s \n',RowFormat);
  
  % Header
  FFormat=DataFormat{1};
  for i=1:nC-1
    fprintf(fid,'  %s &',Header{i});
    FFormat=sprintf('%s & %s',FFormat,DataFormat{i+1});
  end
  fprintf(fid,'  %s ',Header{nC});
  fprintf(fid,' \\\\ %s\n',RowHeaderFormat);
  
  for i=1:nR
    fprintf(fid,FFormat,Data(i,:));
    fprintf(fid,'\\\\ %s\n',RowFormat);
  end
  
  fprintf(fid,'\\end{tabular}\n');
  if ~isempty(Caption)
    fprintf(fid,'\\ifdefined\\TabularWithCaption\n}\n');
    fprintf(fid,'\\end{center}\n');
    fprintf(fid,'\\caption{%s}\n', Caption);
    fprintf(fid,'\\end{table}\n');
    fprintf(fid,'\\fi\n');
  end
  if ~isempty(LaTeXFilename)
      fclose(fid);
      fprintf(' -> %s\n',LaTeXFilename);
  end
end
