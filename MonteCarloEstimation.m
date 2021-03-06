%n is the number of Trace to sample
%T is transitions
%R is returns
%Initial and Absorbing are for states
%Policy is unbiased policy
%gamma is discount factor
function [Q] = MonteCarloEstimation(T, R, Initial, Absorbing, Policy, gamma, n)
numOfStates = length(Initial);
A = size(T,3);
Return = cell(numOfStates,A);
% ZerosMatrix = zeros(size(Policy));
% Policy = ZerosMatrix;

for m = 1:n
	Trace = GetTrace(T,R,Initial,Absorbing,Policy); %randomly obtain one Trace
	TraceSize = size(Trace,1);
	
	%each Trace contains several rewards
	for i = 1:TraceSize-1  %Trace is a m*3 matrix, m is the number of steps
		states(i) = Trace(i,2);
		tmp = 0;
			
		%calculate the Returns for each (state, action) pair
		for j = i:TraceSize-1
			tmp = tmp + Trace(j+1,1).*(gamma^(j-i));
		end
		
		%upgrade the Return matrix for each state in episode
		%Return is a cell containing 7*2 numeric array 
		Return{Trace(i,2), Trace(i,3)} = [Return{Trace(i,2), Trace(i,3)}, tmp];
	end
	
	Q = cellfun(@mean,Return); %Q is 7*2 numeric matrix
    Q(isnan(Q)) = 0;
	
end
end