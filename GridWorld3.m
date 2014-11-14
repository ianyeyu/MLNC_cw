function [S, A, T, R, StateNames, ActionNames, Initial, Absorbing, Locs, Shape ] = GridWorld3()
% A more complex gridworld
%
Shape = [5,5];
action_effects = [ 0.8, 0.1, 0.0, 0.1];
obstacles = [[2,2];[3,2];[3,4]];
absorbing_locs = [[5,1];[5,2];[5,3];[5,4];[5,5];[3,5];];
default_reward = 0;
special_rewards = [[3,3,1];[3,5,10];[5,1,-10];[5,2,-10];[5,3,-10];[5,4,-10];[5,5,-10]];
starting_loc = [4,1];
%
[ S, A, T, R, StateNames, ActionNames, Absorbing, Locs ] = BuildGridWorld(Shape,obstacles,absorbing_locs,action_effects,default_reward,special_rewards);
ActionNames = ['N'; 'E'; 'S'; 'W'];

% construct starting state distribution
starting_state = LocToState(starting_loc,Locs);
Initial = zeros(1,length(Locs));
Initial(starting_state) = 1;
end

%--------------------------------------------------------------------------
