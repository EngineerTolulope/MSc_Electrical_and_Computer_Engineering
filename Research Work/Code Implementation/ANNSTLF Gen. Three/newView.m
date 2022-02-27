function  outH = newView(net)
jframe = view(net);
%# create it in a MATLAB figure
hFig = figure('Menubar','none', 'Position',[100 100 565 166]);
jpanel = get(jframe,'ContentPane');
[~,h] = javacomponent(jpanel);
set(h, 'Parent', hFig, 'units','normalized', 'position',[0 0 1 1])
%# close java window
jframe.setVisible(false);
jframe.dispose();
% capture figure as a frame
F = getframe(hFig);
% close current figure
close(hFig)
% display the captured image data using imshow
hFig = figure('Menubar','none', 'Position',[100 100 565 166]);
axes('units','normalized', 'position',[0 0 1 1])
imshow(F.cdata)
axis off
% return handle if needed
if nargout == 1
    outH = hFig;
end
end