function [UnbiasedPolicy] = GetUnbiasedPolicy(Absorbing, A)
UnbiasedPolicy = 1./A * ~Absorbing'*ones(1,A);
