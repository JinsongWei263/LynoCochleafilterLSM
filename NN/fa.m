%% fa: function description
function [y] = fa(x, bitA)
	if bitA == 32
		y = x;
	else
		y = quantize(x, bitA);
	end

end
