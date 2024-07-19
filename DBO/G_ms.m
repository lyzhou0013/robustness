function G=G_ms(m,s,lambda)
a=10;delta=0.1;alpha=2.8;P=2;xi=9.4192;D=1;beta=1.5;
if lambda/(m*s)<1
    G=lambda.*a.*(1-exp(-m.*s.*(1-(lambda./(m.*s))).*D)./(sqrt(2*pi.*m).*...
        (1-(lambda./(m.*s))).*(exp((lambda./(m.*s)))./(exp(1).*(lambda./(m.*s)))).^m+1))-(m.*beta+delta.*lambda.*xi.*s.^(alpha-1)+delta.*P);
else
    G=NaN;
end
end