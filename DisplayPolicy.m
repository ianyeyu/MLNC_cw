function DisplayPolicy(Policy,Locs,Shape,ActionNames)
temp = sum(Policy,2);
for i = 1:length(temp)
    if temp(i) == 1
        [~, index] = max(Policy(i,:));
        Policy(i,:) = 0;
        Policy(i,index) = 1;
    end
end

for s = 1:length(Policy)
  for a = 1:length(Policy(1,:))
    if Policy(s,a) == 1
        PolicyDisp(s) = ActionNames(a,:);
        break;
    end
    if a == 4
        PolicyDisp(s) = '0';
    end
  end
end

DisplayGrid(PolicyDisp,Locs,Shape);
end

