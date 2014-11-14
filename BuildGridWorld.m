function [ S, A, T, R, statenames, actionnames, absorbing, locs ] = BuildGridWorld(shape,obstacles,absorbing_locs,action_effects,default_reward,special_rewards)
[ locs, neighbours, absorbing ] = get_topology(shape,obstacles,absorbing_locs);
S = length(locs);
A = length(action_effects);

% build the transition matrix
T = zeros(S,S,A);
for action=1:A
  for effect=1:A
    outcome = mod(action+effect-1,A);
    if outcome == 0
      outcome = A;
    end
    prob = action_effects(effect);
    for priorState=1:S
      postState = neighbours(priorState,outcome);
      T(postState,priorState,action) = T(postState,priorState,action) + prob;
    end
  end  
end
statenames = num2str([1:S]');
actionnames = num2str([1:A]');

% build the reward matrix
R = default_reward*ones(S,S,A);
numspecials = length(special_rewards(:,1));
for s=1:numspecials
	row =special_rewards(s,:);
  postState = LocToState([row(1),row(2)],locs);
  R(postState,:,:) = row(3);
end
end

%--------------------------------------------------------------------------

function [ locs,neighbours,absorbing ] = get_topology(shape,obstacles,absorbing_locs)
% obstacles is a list of locations corresponding to locations that are not valid states
% absorbing_locs is a list of locations corresponding to absorbing states
height = shape(1);
width = shape(2);
locs = [];
neighbour_locs = [];
index = 1;
  for i=1:height
    for j=1:width
      loc = [i,j];
      if is_location(loc,shape,obstacles)
        locs = [ locs ; loc ];
        these_neighbours = [];
        these_neighbours = [ these_neighbours ; get_neighbour(loc,'nr',shape,obstacles) ];
        these_neighbours = [ these_neighbours ; get_neighbour(loc,'ea',shape,obstacles) ];
        these_neighbours = [ these_neighbours ; get_neighbour(loc,'so',shape,obstacles) ];
        these_neighbours = [ these_neighbours ; get_neighbour(loc,'we',shape,obstacles) ];
        neighbour_locs = cat(3, neighbour_locs , these_neighbours );
      else
        continue
      end
    end
  end

  % translate neighbour lists from locations to states
  numstates = length(locs(:,1));
  neighbours = zeros(numstates,4);
  for s=1:numstates
    for dir=1:4
      % find neighbour location
      nloc = neighbour_locs(dir,:,s);
      % turn location into a state number
      nstate = LocToState(nloc,locs);
      % insert into neighbour matrix
      neighbours(s,dir) = nstate;
      end
  end

  % translate absorbing locations into absorbing state indices
  absorbing = zeros(1,numstates);
  numabs = length(absorbing_locs(:,1));
  for a=1:numabs
    abstate = LocToState(absorbing_locs(a,:),locs);
    absorbing(abstate) = 1;
  end
end

function newloc = get_neighbour(loc,dir,shape,obstacles)
  i = loc(1);
  j = loc(2);
  nr = [i-1,j];
  ea = [i,j+1];
  so = [i+1,j];
  we = [i,j-1];
  if ( isequal(dir,'nr') & is_location(nr,shape,obstacles) )
    newloc = nr;
  elseif ( isequal(dir,'ea') & is_location(ea,shape,obstacles) )
    newloc = ea;
  elseif ( isequal(dir,'so') & is_location(so,shape,obstacles) )
    newloc = so;
  elseif ( isequal(dir,'we') & is_location(we,shape,obstacles) )
    newloc = we;
  else 
    % default is to return same location
    newloc = loc;
  end
end

function res = is_location(loc,shape,obstacles)
  if ( loc(1)<1 | loc(2)<1 | loc(1)>shape(1) | loc(2)>shape(2) )
    res = false;
  elseif ismember(loc,obstacles,'rows')
    res = false;
  else
    res = true;
  end
end


%--------------------------------------------------------------------------

