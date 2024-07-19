function [Xmin,Ymin] = BEST_POINT(Archive_costs)

Archive_costs = Archive_costs';
[idx,C] = kmeans(Archive_costs,2);
s=1;
len1=length(Archive_costs);
 for i=1:len1
    if idx(i)==1
    l(s,:)=Archive_costs(i,:);
    s=s+1;
    end
 end
l=l';
x=l(1,:);
y=l(2,:);
plot(x,y,'.')
[m1,p1]= max(x);
[n1,q1] = min(x);
[m2,p2]= max(y);
[n2,q2]= min(y);
len2=length(x);
for i=1:len2
    x1(i)=(m1-x(i))/(m1-n1);
    y1(i)=(m2-y(i))./(m2-n2);
    J(i)=(x1(i)^2+y1(i).^2).^0.5;
end
[n3,q3]=min(J);
Xmin=x(q3)
Ymin=y(q3) 
end

