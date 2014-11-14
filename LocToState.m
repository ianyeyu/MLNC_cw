function state = LocToState(loc,locs)
  % takes list of locations and gives index corresponding to input loc
  state = find(ismember(locs,loc,'rows'));
end
