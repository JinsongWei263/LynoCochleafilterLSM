%% fw: function description
function [y] = fwrram(x, rram)

	t = rram(2)-rram(1);

 	x = tanh(x);
 	x = x./max(abs(x(:)))*rram(end);
 	y = round(x/t)*t;
 	
 end
