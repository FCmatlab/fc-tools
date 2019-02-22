function h=display_colors()
  %[name,rgb]=fc_tools.graphics.xcolor.X11();
  [name,rgb]=fc_tools.graphics.xcolor.svg();
  clf
  N=length(name);
  % m~=3/4*n
  n=round(sqrt(4*N/3));
  m=round(3/4*n);
  % 8-by-10 
  %m=20; % rows number
  %n=30; % columns number
  beta=0.3;alpha=0.3;
  aw=1/(n+alpha*(n+1));sw=alpha*aw;
  ah=1/(m+beta*(m+1));sh=beta*ah;
  if fc_tools.comp.isOctave()
    ColorRec=@(k,x,y) fill([x,x+aw,x+aw,x],[y,y,y+ah,y+ah],rgb(k,:),'tag',name{k},'ButtonDownFcn', @(h) fprintf('name=''%s'';color=[%.6f,%.6f,%.6f];\n',get (h, 'tag'),get(h,'facecolor')));
  else
    ColorRec=@(k,x,y) fill([x,x+aw,x+aw,x],[y,y,y+ah,y+ah],rgb(k,:),'tag',name{k},'ButtonDownFcn', {@ColorSelected, {name{k},rgb(k,:)}});
  end
  
  set(gcf(),'visible','off')
  hold on
  k=1;y=1-(ah+sh);
  for i=1:m
    x=sw;
    for j=1:n
      %%h=annotation('textbox',[x,y,aw,ah],'String',name{k},'FitBoxToText','off','BackgroundColor',rgb(k,:));
      %h=annotation('rectangle',[x,y,aw,ah],'tag',name{k},'FaceColor',rgb(k,:));
      %h=fill([x,x+aw,x+aw,x],[y,y,y+ah,y+ah],rgb(k,:),'tag',name{k});
      %set(h, 'ButtonDownFcn', {ColorSel, {name{k},rgb(k,:)}})
      %h=fill([x,x+aw,x+aw,x],[y,y,y+ah,y+ah],rgb(k,:),'tag',name{k},'ButtonDownFcn', @(h) disp (get (h, 'tag')));
      if k<=N
        %h=fill([x,x+aw,x+aw,x],[y,y,y+ah,y+ah],rgb(k,:),'tag',name{k},'ButtonDownFcn', @(h) fprintf('name=''%s'';color=[%.6f,%.6f,%.6f];\n',get (h, 'tag'),get(h,'facecolor')));
        ColorRec(k,x,y)
        x=x+aw+sw;
      end
      k=k+1;
    end
    y=y-(ah+sh);
  end
  axis off
  set(gcf(),'visible','on')
end


function ColorSelected(ObjectH, EventData, H)
  fprintf('name= ''%s'';rgb=[%.6f,%.6f,%.6f];\n',H{1},H{2})
end
