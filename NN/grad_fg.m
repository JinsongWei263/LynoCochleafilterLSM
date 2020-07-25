%% grad_fg: function description
function [y] = grad_fg(x, bitG)
	maxx = max(abs(x'))' + 0.00001;
    maxx = repmat(maxx,1,size(x,2));
	x = x./maxx * 0.5 + 0.5 + unifrnd(-0.5,0.5,size(x));
	x = quantize(x,bitG) - 0.5;
    y = x .* maxx * 2;
end
