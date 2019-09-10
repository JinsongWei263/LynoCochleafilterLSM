function x = normalized(x, mu, sigma)
    x=bsxfun(@minus,x,mu);
	x=bsxfun(@rdivide,x,sigma);
end
