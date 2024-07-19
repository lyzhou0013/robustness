clc;clear;close all;
AA=55:5:65;
ym=zeros(3,1);
mu_opt=zeros(3,1);
m_opt=zeros(3,1);
opt=zeros(3,3);
for i=1:1:3
    AA=AA(i);
    for m=12:0.000001:14
        for mu=1:0.000001:1.3
            %             if lambda(i)/(mu*m)<1
            %                 y=Gg(m,mu,2,0.2,2,lambda);
            y=lingyu_G([m,mu],AA);
            if y>ym(i)
                ym(i)=y;
                opt(i,:)=[y,m,mu];
                %                 end
            end
        end
        display(['The best solution of m is : ', num2str(m)]);
    end
    display(['The number is : ', num2str(i)]);
end

save data_BFS_55.mat opt