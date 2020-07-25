%% fw: function description
function [y] = fwrram_no(x, rram)

    L = length(rram);
    zl = rram(end)-rram(end:-1:1);
    zr = rram(1:end-1)-rram(end);
    z = [zr,zl];
    x = tanh(x);
    x = x./max(abs(x(:))+0.0001)*(L-1);
    x = round(x);
    y = z(x+L);
 	
 end
