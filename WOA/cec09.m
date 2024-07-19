function fobj = cec09(name)

    switch name
        case 'UF1'
            fobj = @UF1;
        case 'UF2'
            fobj = @UF2; 
        case 'UF3'
            fobj = @UF3;  
        case 'UF4'
            fobj = @UF4;
        case 'UF5'
            fobj = @UF5;  
        otherwise
            fobj = @UF1;
    end
end

%%
function y = UF1(x)
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
        if j1>20||j1<8||j2<0.5||j2>1.7||G_ms(j1,j2)<65||lambda/(j1*j2)>1
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
    r1=r1+0.002;
end
end
end

function y = UF2(x)
% r2=-inf;
r1=0.01;
pa=roundn(pi,-3);
lambda=9.99;
if x(1)>20||x(1)<10||x(2)<0.5||x(2)>2|| T_ms(x(1),x(2),lambda) > 0.001||lambda/(x(1)*x(2))>1
    y=[0,0];
else
    AA=x(1);
    BB=x(2);
while r1<100
    flag1=0;
    for angle=pa/10:pa/1000:2*pa
        if angle<=0.5*pa
            j1=AA+r1.*cos(angle);   
            j2=BB+r1.*sin(angle);
        elseif pa/2<angle<=pa
            j1=AA-r1.*sin(angle-pa/2);   
            j2=BB+r1.*cos(angle-pa/2);
        elseif pa<angle<=3*pa/2
            j1=AA-r1.*cos(angle-pa);   
            j2=BB-r1.*sin(angle-pa);
        else
            j1=AA+r1.*sin(angle-3*pa/2); 
            j2=BB-r1.*cos(angle-3*pa/2);
            
        end
        if j1>=20||j1<=10||j2<=0.5||j2>=2||T_ms(j1,j2,lambda)>0.001
            continue
        end
        f4=10000*T_ms(j1,j2,lambda);
        
        if     abs(f4-10)<=0.05   
            y=[-r1,0]; 
            flag1=1;
            break
        end
    end
    if flag1==1
        break
    end
    r1=r1+0.002;
end
end
end

function y = UF3(x)
r1=0.2;n=0.05;r_best=100;AA=60;lambda=19.99;
xx=x;
pa=roundn(pi,-3);
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
y=[-r_best,0];
end

function y = UF4(x)
r1=1.9;n=0.5;r_best=100;AA=0.1;lambda=19.99;
xx=x;
pa=roundn(pi,-3);
if x(1)>45||x(1)<10||x(2)<0.5||x(2)>4.5||T_ms(xx(1),xx(2),lambda)>AA||lambda/(xx(1)*xx(2))>1
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
        T(i)=T_ms(j1,j2,lambda);
        i=i+1;
    end
        f4=T;
        [f5,mm]=max(f4);
        if f5<AA
            r1=r1+n;
        elseif r1-n>0
            r1=r1-n;
        else
            n=0.5*n;
        end
        n=n*0.95;
end
end
y=[-r_best,0];
end