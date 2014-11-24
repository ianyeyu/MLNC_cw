function [OptimalPolicy] = Sarsa(T, R, Initial, Absorbing, gamma, epsilon, alpha, maxsteps, episodes)
%% takes:
%%      transition matrix T;
%%      reward matrix, R;
%%      Initialising distribution, Initial;
%%      matrix of Absorbing states, Absorbing;
%%      geometric discount, gamma;
%%      level of e-Greedy policy randomness, epsilon;
%%      fixed learning rate, alpha;
%%      maximum number of steps per epsiode, maxsteps;
%%      number of episodes, episodes;
%%
%% returns: Optimal Policy and Q-estimate.

%
S = length(T(:,1,1)); % number of states - introspecting transition matrix
A = length(T(1,1,:)); % number of actions - introspecting transition matrix
Q = -ones(S, A); % i.e. state-action value function estimate
Policy = eGreedyPolicyFromQ(Q, Absorbing, epsilon);

for i=1:episodes %sampling steps
    priorState = DrawFromDist(Initial);
    priorAction = DrawFromDist(Policy(priorState,:)); % get action

    %within each episode, run iteration - two stops-1.reach end; 2.reach maximum steps
    for j=1:maxsteps
        postState = DrawFromDist(T(:,priorState,priorAction)); %get post state under specific prior state and action
        reward = R(postState,priorState,priorAction);
        if Absorbing(postState) ~= 1 %if trace is not going to stop
            postAction = DrawFromDist(Policy(postState,:));
        else
            %if trace stops, update Q matrix (S*A size) and then quit loop
            %do not need to include Q for next step
            Q(priorState,priorAction) = (1-alpha)*Q(priorState,priorAction) + alpha*(reward);
            break;
        end

        %update Q values after each iteration
        Q(priorState,priorAction) = (1-alpha)*Q(priorState,priorAction) + alpha*(reward + gamma*Q(postState,postAction));
        priorState = postState;
        priorAction = postAction;
		Policy = eGreedyPolicyFromQ(Q, Absorbing, epsilon);
    end
Policy = eGreedyPolicyFromQ(Q, Absorbing, epsilon);
end
OptimalPolicy = Policy;
end

