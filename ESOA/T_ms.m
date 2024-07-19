function T=T_ms(m,s,lambda)
T=(exp(m).*((lambda./(m.*s)).^m))./(sqrt(2.*pi.*m).*exp(m.*(lambda./(m.*s))).*((1-(lambda./(m.*s))).^2).*...
    m.*s+(exp(m).*((lambda./(m.*s)).^(m))).*m.*s.*(1-(lambda./(m.*s))).^2);
end