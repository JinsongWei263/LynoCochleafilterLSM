%% quantize: function description
function [y] = quantize(x, k)
	n = 2^k - 1;
	y = double(round(x*n))/n;
end	