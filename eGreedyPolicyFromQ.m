%epsilon is the probability of randomly picking action
function [eGreedyPolicy] = eGreedyPolicyFromQ(Q, Absorbing, epsilon)
GreedyPolicy = GreedyPolicyFromQ(Q, Absorbing);
cor_act = 1-epsilon;
eGreedyPolicy = cor_act .* GreedyPolicy + epsilon/2;
eGreedyPolicy(find(Absorbing),:) = 0;
end