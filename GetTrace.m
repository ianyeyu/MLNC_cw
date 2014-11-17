%%This function experience whole process according to probability

%T is transition matrix
%R is reward matrix
%Initial is initial state probability distribution
%trace is [reward,postState,postAction]
function [trace] = GetTrace(T,R,Initial,Absorbing,Policy) 

priorState = DrawFromDist(Initial); %find the most possible state
priorAction = DrawFromDist(Policy(priorState,:)); % get action
reward = 0;
step = [ reward, priorState, priorAction ]; % first reward is a dummy reward
trace = step; 

%only if reach absorbing step the loop will stop
while( true )    %find locates the index of agent

	%find the most possible post state depends on prior state and action
    postState = DrawFromDist(T(:,priorState,priorAction));
    reward = R(postState,priorState,priorAction); %search for corresponding reward
    if Absorbing(postState) ~= 1
        postAction = DrawFromDist(Policy(postState,:)); %pick one again
    else
        step = [reward, postState, 0]; % last action is a dummy action
        trace = [ trace; step ];
        break; 
    end
    step = [ reward, postState, postAction ]; %use step to record reward
    trace = [ trace; step ]; %update trace matrix

    priorState = postState;
    priorAction = postAction;
end


end

