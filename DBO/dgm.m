function y = dgm(x)
r1=0.01;
xx=[12,x];
pa=roundn(pi,-3);
lambda=9.99;
if xx(1)>26||xx(1)<6||xx(2)<0.4||xx(2)>2.1||G_ms(xx(1),xx(2))<55||lambda/(xx(1)*xx(2))>1
    o=0;
else
while r1<100
    flag1=0;
    for angle=pa/10:pa/1000:2*pa
        if angle<=0.5*pa
            j1=xx(1)+r1.*cos(angle);  
            j2=xx(2)+r1.*sin(angle);
        elseif pa/2<angle<=pa
            j1=xx(1)-r1.*sin(angle-pa/2);   
            j2=xx(2)+r1.*cos(angle-pa/2);
        elseif pa<angle<=3*pa/2
            j1=xx(1)-r1.*cos(angle-pa);  
            j2=xx(2)-r1.*sin(angle-pa);
        else
            j1=xx(1)+r1.*sin(angle-3*pa/2); 
            j2=xx(2)-r1.*cos(angle-3*pa/2);
            
        end
        if j1>26||j1<6||j2<0.4||j2>2.1||G_ms(j1,j2)<55||lambda/(j1*j2)>1
            continue
        end
        f4=G_ms(j1,j2);
        f5=roundn(f4,-3);
        if     abs(f5-55)<=0.05   
            o=-r1; 
            flag1=1;
            break
        end
    end
    if flag1==1
        break
    end
    r1=r1+0.05;
end
end
end