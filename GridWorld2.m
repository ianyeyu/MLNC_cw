function [S, A, T, R, StateNames, ActionNames, Initial, Absorbing, Locs, Shape ] = GridWorld2()
% The simple GridWorld1 by another method
%
Shape = [3,4];
action_effects = [ 0.8, 0.1, 0.0, 0.1];
obstacles = [[2,2];];
absorbing_locs = [[1,4];[2,4];];
default_reward = -1;
special_rewards = [[1,4,10];[2,4,-100]];
starting_loc = [3,1];
%
[ S, A, T, R, StateNames, ActionNames, Absorbing, Locs ] = BuildGridWorld(Shape,obstacles,absorbing_locs,action_effects,default_reward,special_rewards);
ActionNames = ['N'; 'E'; 'S'; 'W'];

% construct starting state distribution
starting_state = LocToState(starting_loc,Locs);
Initial = zeros(1,length(Locs));
Initial(starting_state) = 1;
end

%--------------------------------------------------------------------------
