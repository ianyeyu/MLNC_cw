function [S, A, T, R, StateNames, ActionNames, Absorbing] = GridWorld1()

% Number of states
S = 11; 
StateNames =  ['s01'; 's02'; 's03'; 's04'; 's05'; 's06'; 's07'; 's08'; 's09'; 's10'; 's11'];
% States are laid out as follows:
%  index          name
% 1 2 3 4       S1 S2 S3  S4
% 5 # 6 7   --> S5 #  S6  S7
% 8 9 10 11     S8 S9 S10 S11 

% Number of actions
A = 4; 
ActionNames = ['N'; 'E'; 'S'; 'W'];
% Actions are as follows: 
%index       name
% 1    -->   N
% 2    -->   E
% 3    -->   S
% 4    -->   W

% Matrix indicating absorbing states
Absorbing = [
%1  2   3   4   5   6   7   8   9   10  11 STATE 
0   0   0   1   0   0   1   0   0   0   0
];

% load transition
T = transition_matrix()

% load reward matrix
R = reward_matrix(S,A)

%--------------------------------------------------------------------------

% get the transition matrix (defined as local function)
function T = transition_matrix()
%
% 1 2 3 4       S1 S2 S3  S4
% 5 # 6 7   --> S5 #  S6  S7
% 8 9 10 11     S8 S9 S10 S11
%
TN = [
%1  2   3   4   5   6   7   8   9   10  11 FROM STATE 
0.9 0.1 0   0   0.8 0   0   0   0   0   0  ; % 1 TO STATE
0.1 0.8 0.1 0   0   0   0   0   0   0   0  ; % 2
0   0.1 0.8 0   0   0.8 0   0   0   0   0  ; % 3
0   0   0.1 1   0   0   0   0   0   0   0  ; % 4
0   0   0   0   0.2 0   0   0.8 0   0   0  ; % 5
0   0   0   0   0   0.1 0   0   0   0.8 0  ; % 6
0   0   0   0   0   0.1 1   0   0   0   0.8; % 7
0   0   0   0   0   0   0   0.1 0.1 0   0  ; % 8
0   0   0   0   0   0   0   0.1 0.8 0.1 0  ; % 9
0   0   0   0   0   0   0   0   0.1 0   0.1; % 10
0   0   0   0   0   0   0   0   0   0.1 0.1; % 11
];
%
TE = [
%1  2   3   4   5   6   7   8   9   10  11 
0.1 0   0   0   0.1 0   0   0   0   0   0  ; % 1 
0.8 0.2 0   0   0   0   0   0   0   0   0  ; % 2
0   0.8 0.1 0   0   0   0   0   0   0   0  ; % 3
0   0   0.8 1   0   0.1 0   0   0   0   0  ; % 4
0.1 0   0   0   0.8 0   0   0.1 0   0   0  ; % 5
0   0   0.1 0   0   0   0   0   0   0.1 0  ; % 6
0   0   0   0   0   0.8 1   0   0   0   0.1; % 7
0   0   0   0   0.1 0   0   0.1 0   0   0  ; % 8
0   0   0   0   0   0   0   0.8 0.2 0   0  ; % 9
0   0   0   0   0   0.1   0   0   0.8 0.1 0  ; % 10
0   0   0   0   0   0 0   0   0   0.8 0.9; % 11
];    
%
TS = [
%1  2   3   4   5   6   7   8   9   10  11
0.1 0.1 0   0   0   0   0   0   0   0   0  ; % 1
0.1 0.8 0.1 0   0   0   0   0   0   0   0  ; % 2
0   0.1 0   0   0   0   0   0   0   0   0  ; % 3
0   0   0.1 1   0   0   0   0   0   0   0  ; % 4
0.8 0   0   0   0.2 0   0   0   0   0   0  ; % 5
0   0   0.8 0   0   0.1 0   0   0   0   0  ; % 6
0   0   0   0   0   0.1 1   0   0   0   0  ; % 7
0   0   0   0   0.8 0   0   0.9 0.1 0   0  ; % 8
0   0   0   0   0   0   0   0.1 0.8 0.1 0  ; % 9
0   0   0   0   0   0.8 0   0   0.1 0.8 0.1; % 10
0   0   0   0   0   0   0   0   0   0.1 0.9; % 11
];    
%
TW = [
%1  2   3   4   5   6   7   8   9   10  11
0.9 0.8 0   0   0.1 0   0   0   0   0   0  ; % 1
0   0.2 0.8 0   0   0   0   0   0   0   0  ; % 2
0   0   0.1 0   0   0.1 0   0   0   0   0  ; % 3
0   0   0   1   0   0   0   0   0   0   0  ; % 4
0.1 0   0   0   0.8 0   0   0.1 0   0   0  ; % 5
0   0   0.1 0   0   0.8 0   0   0   0.1 0  ; % 6
0   0   0   0   0   0   1   0   0   0   0.1; % 7
0   0   0   0   0.1 0   0   0.9 0.8 0   0  ; % 8
0   0   0   0   0   0   0   0   0.2 0.8 0  ; % 9
0   0   0   0   0   0.1 0   0   0   0.1 0.8; % 10
0   0   0   0   0   0   0   0   0   0   0.1; % 11
];
%
% T(3,6,4) = 0.1 % i.e. 4th matrix tW, 3rd row, 6th column (postState,priorState, action)
T = cat(3, TN, TE, TS, TW); % transition probabilities for each action 

%--------------------------------------------------------------------------

% the reward function (defined as a local function - subfunction)
function rew = reward_function(priorState, a, postState) % reward function (defined locally)
if ((priorState == 3) && (postState == 4))
    rew = 10;
elseif ((priorState == 6) && (postState == 7))
    rew = -10;
elseif ((priorState == 11) && (postState == 7))
    rew = -10;
else
    rew = -1;
end

% get the reward matrix (defined as a local function - subfunction)
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

