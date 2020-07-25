%% fw: function description
function [y] = fw(x, bitW)
 	if bitW == 32
 		y = x;
 	elseif bitW == 1
 		E = mean(abs(x)+0.00001);
 		y = sign(x./E).*E;
 	else
 		x = x./max(abs(x(:))+0.00001)*0.5 + 0.5;
 		y = 2 * quantize(x, bitW) - 1;
 	end
 end