function [] = DisplayFunctionalPolicy(Policy, StateNames, ActionNames)
[~, index] = max(Policy,[],2);
index = sub2ind(size(Policy), 1:length(Policy) , index');
Policy(index) = 1;
Policy(find(Policy~=1)) = 0;
for s = 1:length(Policy)
  for a = 1:length(Policy(1,:))
    if Policy(s,a) == 1
	    disp(strcat('Policy(',StateNames(s,:),')=',ActionNames(a,:)))
    end
  end
end

end
