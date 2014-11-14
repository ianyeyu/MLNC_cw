%n is the number of trace to sample
%T is transitions
%R is returns
%Initial and Absorbing are for states
%Policy is unbiased policy
%gamma is discount factor
function Q = MonteCarloEstimation(T, R, Initial, Absorbing, Policy, gamma, n)
ZeroMatrix = zeros(length(Initial)*2,1);
Q = ZeroMatrix;
for j = 1:n
	trace = GetTrace(T,R,Initial,Absorbing,Policy);
	Return = ZeroMatrix;
	for i = 1:size(trace,1)-1
		Return(trace(i,2),trace(i,3)) = trace(i,1);
	end
	Return = mean(Return,2);
	Q = gamma .* Q + (1-gamma) .* Return;
end
end