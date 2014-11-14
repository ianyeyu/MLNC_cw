function [GreedyPolicy] =  GreedyPolicyFromV(V, T, R, Absorbing, gamma)

S = length(T);
A = length(T(1,1,:));
GreedyPolicy = zeros(S, A); % each row has A possible actions each has an assigned probability

for priorState = 1:S
    if Absorbing(priorState)
        continue
    end
    tmpQs = zeros(A, 1);
    for action =1:A
        tmpQ = 0;
        for postState=1:S
            tmpQ = tmpQ + T(postState,priorState,action)*(R(postState,priorState,action) + gamma*V(postState));
        end
        tmpQs(action) = tmpQ;
    end
    [value, index] = max(tmpQs);
    GreedyPolicy(priorState, index) = 1;
end







