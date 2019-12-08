function savePlotWithinGUI(axesObject, legendObject)
%this function takes in two arguments
%axesObject is the axes object that will be saved (required input)
%legendObject is the legend object that will be saved (optional input)
 
%stores savepath for the phase plot
[filename, pathname] = uiputfile({ '*.emf','Enhanced Meta File (*.emf)';...
        '*.bmp','Bitmap (*.bmp)'; '*.fig','Figure (*.fig)'}, ... 
        'Save picture as','default');
 
%if user cancels save command, nothing happens
if isequal(filename,0) || isequal(pathname,0)
    return
end
%create a new figure
newFig = figure;
 
%get the units and position of the axes object
axes_units = get(axesObject,'Units');
axes_pos = get(axesObject,'Position');
 
%copies axesObject onto new figure
axesObject2 = copyobj(axesObject,newFig);
 
%realign the axes object on the new figure
set(axesObject2,'Units',axes_units);
set(axesObject2,'Position',[15 5 axes_pos(3) axes_pos(4)]);
 
%if a legendObject was passed to this function . . .
if (exist('legendObject'))
 
    %get the units and position of the legend object
    legend_units = get(legendObject,'Units');
    legend_pos = get(legendObject,'Position');
 
    %copies the legend onto the the new figure
    legendObject2 = copyobj(legendObject,newFig);
 
    %realign the legend object on the new figure
    set(legendObject2,'Units',legend_units);
    set(legendObject2,'Position',[15-axes_pos(1)+legend_pos(1) 5-axes_pos(2)+legend_pos(2) legend_pos(3) legend_pos(4)] );
 
end
 
%adjusts the new figure accordingly
set(newFig,'Units',axes_units);
set(newFig,'Position',[15 5 axes_pos(3)+30 axes_pos(4)+10]);
 
%saves the plot
saveas(newFig,fullfile(pathname, filename)) 
 
%closes the figure
close(newFig)