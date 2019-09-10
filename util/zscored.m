function [x, mu, sigma] = zscored(x)
    mu=mean(x);	
    sigma=max(std(x),eps);
	x=bsxfun(@minus,x,mu);
	x=bsxfun(@rdivide,x,sigma);
end
