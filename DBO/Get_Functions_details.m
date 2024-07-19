

function [lb,ub,dim,fobj] = Get_Functions_details(F)


switch F
    case 'F1'
        fobj = @F1;
        lb=0.5;
        ub=2;
        dim=1;
        
    case 'F2'
        fobj = @F2;
        lb=[6,0.4];
        ub=[26,2.1];
        dim=2;
        
    case 'F3'
        fobj = @F3;
        lb=[6,0.4];
        ub=[20,2];
        dim=2;
        
    case 'F4'
        fobj = @F4;
        lb=[16.825,1.31255];
        ub=[16.826,1.3127];
        dim=2;
end

end

% F1

function o = F1(x)
r1=0.01;
xx=[14,x];
pa=roundn(pi,-4);
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
            f5=roundn(f4,-4);
            if     abs(f5-55)<=0.05   
                o=-r1; 
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

% F2

function o = F2(x)
r1=0.01;
pa=roundn(pi,-3);
lambda=9.99;
if x(1)>20||x(1)<6||x(2)<0.5||x(2)>20||G_ms(x(1),x(2))<55||lambda/(x(1)*x(2))>1
    o=0;
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
        r1=r1+0.002;
    end
end
end

% F3

function o = F3(x)
r1=2;n=0.2;r_best=100;AA=0.1;lambda=19.99;
xx=x;
pa=roundn(pi,-3);
if T_ms(xx(1),xx(2),lambda)>AA || lambda/(xx(1)*xx(2))>1
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
o=-r_best;
end

function o = F4(x)
r1=0.2;n=0.05;r_best=100;AA=60;lambda=11.99;
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
o=-r_best;
end