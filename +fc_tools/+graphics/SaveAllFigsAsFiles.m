function SaveAllFigsAsFiles(file,varargin)
% FUNCTION fc_tools.graphics.SaveAllFigsAsFiles
%   Save all figures in files
%   format can be 'pdf', 'epsc', 'png'
%
% <COPYRIGHT>
  p = inputParser;
  p.addParamValue('format','epsc',@(x) ismember(x,{'epsc','pdf','png'}));
  p.addParamValue('showtitle',true,@islogical);
  p.addParamValue('verbose',false,@islogical);
  p.addParamValue('dir','.',@ischar);
  p.addParamValue('pdfcrop',false,@islogical);
  p.addParamValue('tag',false,@islogical);
  p.parse(varargin{:});
  R=p.Results;
  if R.tag, [Softname,Release]=fc_tools.sys.getSoftware();end
  %if isOctave, more off;end  
  figHandles = get(0,'Children');
  for i=1:length(figHandles)
    if strcmp(class(figHandles(1)),'matlab.ui.Figure')
      nfig=figHandles(i).Number;
    else % old version
      nfig=figHandles(i);
    end
    h=figure(nfig); % utiliser le label...
    if ~R.showtitle
      Title=get(gca(),'Title');
      set(Title,'Visible','off')
    end
    set(h,'Color',[1,1,1]) % white backgroup for print
    if R.tag
      filename=[R.dir,filesep,file,'_fig',num2str(nfig),'_',Softname,strrep(Release,'.',''),'.',R.format];
    else
      filename=[R.dir,filesep,file,'_fig',num2str(nfig),'.',R.format];
    end
    if fc_tools.comp.isOctave()
      if str2num(strrep(version,'.',''))>=420 % version 4.2.0
        print(h,['-d',R.format],filename)
      else % Don't print "LaTeX" so snapshot
        set(h,'position',[100,50,800,600])
        SaveOctaveFigure(nfig,filename)
        set(h,'visible','off') % BUG1: ajout car la derniere figure reste en avant plan avec Octave 4.2.0!
      end
    else
    %export_fig(file,'-transparent',['-',R.format])
      %figuresize( 800 , 600 , 'points' )
      print(h,['-d',R.format],filename)
    end
    if ~R.showtitle
      set(Title,'Visible','on')
    end
    if R.pdfcrop
      if ~fc_tools.comp.isOctave()
      system(sprintf('pdfcrop %s %s',filename,filename));   
      end
    end
    if R.verbose
      fprintf('  Save figure %d in %s\n',nfig,filename);
    end
  end
  if fc_tools.comp.isOctave() %BUG1:
    for i=1:length(figHandles)
      %nfig=figHandles(i);
      %h=figure(nfig); % utiliser le label...
      set(figHandles(i),'visible','on') 
    end
  end
end

function SaveOctaveFigure(nfig,filename)
  h=figure(nfig);
  %drawnow
  %S=get(0,'screensize')
  %h=gcf();%figure(fignum)
  set(h,'menubar','none')
  %set(h,'position',[100,50,800,600]);
  P=get(h,'position');
  if ismac()
  %command=sprintf('screencapture -R %d,%d,%d,%d %s',P(1),P(2)+50,P(3),P(4)-50,filename);
  %command=sprintf('screencapture -R %d,%d,%d,%d %s',P(1),P(2)+80,P(3),P(4)-50,filename);
  command=sprintf('screencapture -R %d,%d,%d,%d %s',P(1),P(2)+100,P(3),P(4)-50,filename);
  else
  %command=sprintf('import -window root -crop %dx%d+%d+%d %s',P(3)-2,P(4)-2-40,P(1)+1,S(4)-P(4)-P(2)+1-10+39,filename)
  command=sprintf('import -window root -gravity SouthWest -crop %dx%d+%d+%d %s',P(3)-2,P(4)-30,P(1)+1,P(2)+1,filename)
  end
  %set(h,'Visible','off')
  %set(h,'Visible','on')
  drawnow
  %gcf
  % %0.5
  pause(2);
  system(command)
  pause(2);
  %import -window root -crop 800x600+76+480 test.png
  set(h,'menubar','figure')
end

function figuresize( fighandle, varargin )
p = inputParser;
p.addParamValue('scale',1,@(x) isscalar(x) )

p.parse( varargin{:});
scale = p.Results.scale;
set(fighandle,'visible','off')
screenpos = get(fighandle,'Position');

set(fighandle,'Position',[screenpos(1:2) scale*screenpos(3:4)]);
set(fighandle,'visible','on')
end