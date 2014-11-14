%Q is the matrix of Q values(return of (s,a))
function [GreedyPolicy] =  GreedyPolicyFromQ(Q, Absorbing)

%Q is S*A size matrix
S = length(Q(:,1)); %row represents prior state
A = length(Q(1,:)); %column represents action

%initialise GreedyPolicy matrix with zeros
GreedyPolicy = zeros(S, A); % each row has A possible actions each has an assigned probability

for priorState = 1:S
    if Absorbing(priorState)
        continue
    end
    [value, index] = max(Q(priorState,:)); %find the maximum value among actions under state priorState
    GreedyPolicy(priorState, index) = 1; %assign the corresponding action into policy
end