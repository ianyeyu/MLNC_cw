%N is the number of batches
%n is the number of traces for each barch
function OptimalPolicy = MonteCarloBatchOptimisation(T, R, Initial, Absorbing, gamma, epsilon, n, N)
A = size(T,3);
Policy = GetUnbiasedPolicy(Absorbing, A); %the initial policy is unbiased policy

for Batch = 1:N
	Q = MonteCarloEstimation(T, R, Initial, Absorbing, Policy, gamma, n);	
%     epsilon = 0.1 + (epsilon-0.1)*(1-Batch/N);
	Policy = eGreedyPolicyFromQ(Q, Absorbing, epsilon); %upgrade policy by eGreedyPolicyFromQ()
end
OptimalPolicy = Policy;
end