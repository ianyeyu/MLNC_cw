function [] = DisplayFunctionalPolicy(Policy, StateNames, ActionNames)
for s = 1:length(Policy)
  for a = 1:length(Policy(1,:))
    if Policy(s,a) == 1
	    disp(strcat('Policy(',StateNames(s,:),')=',ActionNames(a,:)))
    end
  end
end

end
