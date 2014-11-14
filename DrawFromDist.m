% res is more likely to be large weight
function [res] = DrawFromDist(weights)
%% draws an integer randomly between 1 and length(weights)
%% probility of choosing index i is proportional to weights(i)

cumul = 0.;
weightsum = sum(weights);
thresh = weightsum*rand();
res = length(weights);
for i=1:length(weights)
    cumul = cumul + weights(i);
    % as soon as cumul is greater than the random threshold
    % we return with the index of that element.
    if(cumul >= thresh)
        res = i;
        break;
    end
end
   
end

