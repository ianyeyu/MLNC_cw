function [S, A, T, R, StateNames, ActionNames, Initial, Absorbing] = StairClimbingMDP()
% States are:  {P <-- s1 <=> s2 <=> s3 <=> s4 <=> s5 --> G];
S = 7; 
StateNames =  ['s1'; 's2'; 's3'; 's4'; 's5'; 's6'; 's7'];

% Actions are: {L,R} --> {1, 2 }
A = 2; 
ActionNames =  ['L'; 'R'];

% Matrix indicating absorbing states
Absorbing = [
%P  1   2   3   4   5   G   <-- STATES 
1   0   0   0   0   0   1
];

% Matrix indicating starting state distribution
Initial = [
%P  1   2   3   4   5   G   <-- STATES 
0   0   0   1   0   0   0
];

% load transition
T = transition_matrix();

% load reward matrix
R = reward_matrix(S,A);

%--------------------------------------------------------------------------

% the transition subfunction
function prob = transition_function(priorState, action, postState) % reward function (defined locally)
T = transition_matrix();
prob = T(postState,priorState,action);

% get the transition matrix
function T = transition_matrix()
TL = [
%P  1   2   3   4   5   G   <-- FROM STATE
1   1   0   0   0   0   0 ; % P TO STATE
0   0   1   0   0   0   0 ; % 1
0   0   0   1   0   0   0 ; % 2    
0   0   0   0   1   0   0 ; % 3
0   0   0   0   0   1   0 ; % 4
0   0   0   0   0   0   0 ; % 5
0   0   0   0   0   0   1 ; % G
];
TR = [
%P  1   2   3   4   5   G   <-- FROM STATE
1   0   0   0   0   0   0 ; % P TO STATE
0   0   0   0   0   0   0 ; % 1
0   1   0   0   0   0   0 ; % 2    
0   0   1   0   0   0   0 ; % 3
0   0   0   1   0   0   0 ; % 4
0   0   0   0   1   0   0 ; % 5
0   0   0   0   0   1   1 ; % G
];
T = cat(3, TL, TR); %transition probabilities for each action 


%--------------------------------------------------------------------------

% the locally defined reward function
function rew = reward_function(priorState, action, postState) % reward function (defined locally)
if ((priorState == 2) && (action == 1) && (postState == 1))
    rew = -10.0;
elseif ((priorState == 6) && (action == 2) && (postState == 7))
    rew = 10.0;
elseif (action == 1)
    rew = 1.0;
else
    rew = -1.0;
end

% get the reward matrix
function R = reward_matrix(S, A)
% i.e. 11x11 matrix of rewards for being in state s, performing action a and ending in state s'
R = zeros(S, S, A); 
for i = 1:S
   for j = 1:A
      for k = 1:S
         R(k, i, j) = reward_function(i, j, k);
      end
   end    
end


