function y = dgm(x)
% r2=-inf;
r1=0.01;
pa=roundn(pi,-3);
lambda=9.99;
if x(1)>24||x(1)<6||x(2)<0.5||x(2)>1.7||G_ms(x(1),x(2))<65||lambda/(x(1)*x(2))>1
    y=[0,0];
else
while r1<100
    flag1=0;
    for angle=pa/10:pa/1000:2*pa
        if angle<=0.5*pa
            j1=x(1)+r1.*cos(angle);  
            j2=x(2)+r1.*sin(angle);
        elseif pa/2<angle<=pa
            j1=x(1)-r1.*sin(angle-pa/2);  
            j2=x(2)+r1.*cos(angle-pa/2);
        elseif pa<angle<=3*pa/2
            j1=x(1)-r1.*cos(angle-pa);   
            j2=x(2)-r1.*sin(angle-pa);
        else
            j1=x(1)+r1.*sin(angle-3*pa/2);  
            j2=x(2)-r1.*cos(angle-3*pa/2);
            
        end
        if j1>24||j1<6||j2<0.5||j2>1.7||G_ms(j1,j2)<65||lambda/(j1*j2)>1
            continue
        end
        f4=G_ms(j1,j2);
        f5=roundn(f4,-3);
        if     abs(f5-65)<=0.05   
            y=[-r1,0]; 
            flag1=1;
            break
        end
    end
    if flag1==1
        break
    end
    r1=r1+0.005;
end
end
end