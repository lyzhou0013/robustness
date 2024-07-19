function r2=dtm(AA,BB)
% r2=-inf;
r1=0.01;
pa=roundn(pi,-4);

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
        if j1>=20||j1<=6||j2<=0.5||j2>=2||T_ms(j1,j2)>0.001
            continue
        end
        f4=10000*T_ms(j1,j2);
        
        if     abs(f4-10)<=0.05    
            r2=r1; 
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
