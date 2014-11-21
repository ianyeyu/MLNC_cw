%Values - vector of state values
%Locs - state to location mapping
%Shape - grid world shape
%finally, show the values within the grid - it could be return values, state values or any values corresponding to this grid
function [] = DisplayGrid(Values,Locs,Shape)
height = Shape(1);
width = Shape(2);
cvsep = '----------------';
vsep = '';
for j=1:width
  vsep = [vsep cvsep];
end
vsep = [vsep '-\n'];
fprintf(vsep)
for i = 1:height
  rowstr = '|';
  for j = 1:width
    state = LocToState([i,j],Locs);
    if length(state)
    value = Values(state);
    rowstr = horzcat(rowstr,'\t',num2str(value,3),'\t|');
    else
    rowstr = horzcat(rowstr,'\t','#','\t|');
    end
  end
    rowstr = horzcat(rowstr,'\n');
    fprintf(rowstr)
    fprintf(vsep)
end
end
