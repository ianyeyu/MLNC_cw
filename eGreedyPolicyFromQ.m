%epsilon is the probability of randomly picking action
function [eGreedyPolicy] = eGreedyPolicyFromQ(Q, Absorbing, epsilon)
A = size(Q,2);
GreedyPolicy = GreedyPolicyFromQ(Q, Absorbing);
cor_act = 1-epsilon;
eGreedyPolicy = cor_act .* GreedyPolicy + epsilon/A;
eGreedyPolicy(find(Absorbing),:) = 0;
end