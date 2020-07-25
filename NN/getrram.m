%% getrram: function description
function [warry] = getrram(arg)
	load rram;
	rram = rram';
	rram16=rram(1,1:end);
	warry = rram16'*rram16;
	warry = reshape(warry,[1,length(rram16)^2]);
	warry = sort(warry);
	j = 1;
	for i = 2 : length(warry)
		if warry(j)== warry(i)
			
		end
	end
