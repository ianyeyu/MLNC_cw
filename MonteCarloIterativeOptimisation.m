function [OptimalPolicy] = MonteCarloIterativeOptimisation( T, R, Initial, Absorbing, gamma, epsilon, alpha, numtraces)
%% Every visit updates (simpler than first visit updates)
%% takes:
%%      transition matrix T;
%%      reward matrix, R;
%%      initialising distribution, Initial;
%%      matrix of absorbing states, Absorbing;
%%      geometric discount, gamma;
%%      level of e-Greedy policy randomness, epsilon;
%%      number of traces per batch, numtraces;
%%      number of batches, numbatches;
%%
%% returns: Estimate for Optimal Policy.

%
S = length(T(:,1,1)); % number of states - introspecting transition matrix
A = length(T(1,1,:)); % number of actions - introspecting transition matrix
Q = zeros(S, A); % i.e. state-action value function estimate
Policy = GetUnbiasedPolicy(Absorbing, A);

for i=1:numtraces

    trace = GetTrace(T,R,Initial,Absorbing,Policy);
    tracelength = length(trace(:,1));
    return_t = trace(tracelength,1); % get last reward as return for penultimate state and action.
    
    for t=tracelength-1:-1:1       %Step through time-steps in reverse order
        s = trace(t,2); % get state index from trace at time t
        a = trace(t,3); % get action index
        Q(s,a) = (1-alpha)*Q(s,a) + alpha*return_t; % update Q.
        return_t = return_t*gamma + trace(t,1); % return for time t-1 in terms of return and reward at t
    end
    Policy = eGreedyPolicyFromQ(Q, Absorbing, epsilon);
end
OptimalPolicy = GreedyPolicyFromQ(Q, Absorbing);
end


