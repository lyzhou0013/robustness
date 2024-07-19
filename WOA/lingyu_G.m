function r_best = lingyu_G(x)
r1=0.2;n=0.05;r_best=100;AA=60;
xx=x;
pa=roundn(pi,-3);
lambda=19.99;
if G_ms(xx(1),xx(2),lambda)<AA||lambda/(xx(1)*xx(2))>1
    r_best=0;
else
while abs(r1-r_best)>0.00001 || n > 0.00001
    r_best=r1;
    i=1;
    for angle=pa/1000:pa/1000:2*pa
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
        xi(i,:)=[j1,j2];
        G(i)=G_ms(j1,j2,lambda);
        i=i+1;
    end
        f4=G;
        [f5,mm]=min(f4);
        if f5>AA
            r1=r1+n;
        elseif r1-n>0
            r1=r1-n;
        else
            n=0.5*n;
        end
        n=n*0.95;
end
end
end