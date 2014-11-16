%n is the number of trace to sample
%T is transitions
%R is returns
%Initial and Absorbing are for states
%Policy is unbiased policy
%gamma is discount factor
function Q = MonteCarloEstimation(T, R, Initial, Absorbing, Policy, gamma, n)
	
%initialise
Q = zeros(length(Initial)*2,1);
for i = 1:length(Initial)
	Return{i}{1} = [];
	Return{i}{2} = []; 
end
Return = cell(length(Initial),2)

for m = 1:n
	trace = GetTrace(T,R,Initial,Absorbing,Policy); %randomly obtain one trace
	traceSize = size(trace,1);
	
	for i = 1:traceSize  %trace is a m*3 matrix, m is the number of steps
		tmp = 0;	
		for j = i:traceSize
			tmp = tmp + trace(j,1).*(gamma^(j-1));
		end
		
		Return{trace(i,2)}{trace(i,3)} = [Return{trace(i,2)}{trace(i,3)}, [trace(i,2),trace(i,3),tmp]];
	end
	
end
end