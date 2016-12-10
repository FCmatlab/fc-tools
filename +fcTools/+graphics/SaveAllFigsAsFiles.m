function SaveAllFigsAsFiles(file,varargin)
  % format can be 'pdf', 'eps', 'png'
  % Use of export_fig toolbox 
  p = inputParser;
  p=AddParamValue(p,'format','epsc',@(x) ismember(x,{'epsc','pdf','png'}));
  p=AddParamValue(p,'showtitle',true,@islogical);
  p=AddParamValue(p,'verbose',false,@islogical);
  p=AddParamValue(p,'dir','.',@ischar);
  p=AddParamValue(p,'pdfcrop',false,@islogical);
  p=AddParamValue(p,'tag',false,@islogical);
  p=Parse(p,varargin{:});
  R=p.Results;
  if R.tag, [Softname,Release]=getSoftware();end
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
    if isOctave()
      %fprintf('save figure handle:%g in %s \n',h,filename)
      set(h,'position',[100,50,800,600])
      %set(h,'visible','off')
      %figuresize( 800 , 600 , 'points' )
      %set(h,'visible','off')
      %figuresize(h,'scale',2)
      SaveOctaveFigure(h,filename)
      %pause
      set(h,'visible','off') % BUG1: ajout car la derniere figure reste en avant plan avec Octave 4.2.0!
%        ceval=sprintf('print -f%g  %s',h,filename);
%        eval(ceval)
%        eval(ceval) % doublé car soucis (parfois avec 3.8.2)
      %pause
      %print(h,filename,['-d',R.format]) % ne marche pas bien avec 3.8.2
    else
    %export_fig(file,'-transparent',['-',R.format])
      %figuresize( 800 , 600 , 'points' )
      
      print(h,['-d',R.format],filename)
    end
    if ~R.showtitle
      set(Title,'Visible','on')
    end
    if R.pdfcrop
      if ~isOctave()
      system(sprintf('pdfcrop %s %s',filename,filename));   
      end
    end
    if R.verbose
      fprintf('  Save figure %d in %s\n',nfig,filename);
    end
  end
  if isOctave() %BUG1:
    for i=1:length(figHandles)
      %nfig=figHandles(i);
      %h=figure(nfig); % utiliser le label...
      set(figHandles(i),'visible','on') 
    end
  end
end

function SaveOctaveFigure(h,filename)
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