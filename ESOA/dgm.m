function r2=dgm(AA,BB)

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
        if j1>20||j1<8||j2<0.5||j2>2||G_ms(j1,j2)<60
            r2=0;
            continue
        end
        f4=G_ms(j1,j2);
        f5=roundn(f4,-4);
        if     abs(f5-60)<=0.05   
            r2=r1; 
            flag1=1;
            break
        end
    end
    if flag1==1
        break
    end
    r1=r1+0.001;
end
end
