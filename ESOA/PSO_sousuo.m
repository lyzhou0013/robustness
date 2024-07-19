clc;clear;close all;

N = 50;
d = 1;                        
ger = 50;                          
limit = [0.5 2];               
vlimit = [-0.1,0.1]; 
lambda=9.99;AA=65;m=12;
w = 0.8;                     
c1 = 0.5;                     
c2 = 0.5;                     
for i = 1:d
    x(:,i) = limit(i, 1) + (limit(i, 2) - limit(i, 1)) * rand(N, 1);
end
v = rand(N, d);                 
xm = zeros(N, d);               
ym = zeros(1, d);                
fxm = zeros(N, 1);               
fxm(:,1)=inf;
fym = inf;                       
fx=zeros(N,1);

iter = 1;
record = zeros(ger, 1);          
while iter <= ger
    
    for k=1:N
            fx(k) =-lingyu_G([m,x(k)],lambda,AA);
    end
    for i = 1:N
        if (fxm(i,:) > fx(i,:))
            fxm(i,:) = fx(i,:);    
            xm(i,:) = x(i,:);   
        end
    end
    if fym > min(fxm)
        [fym, nmin] = min(fxm);  
        ym = xm(nmin, :);     
    end
    for i=1:d
        for i=1:d
            v(:,i) = v(:,i) * w + c1 * rand *(xm(:,i) - x(:,i)) + c2 * rand *(repmat(ym(i),N,1) - x(:,i));%速度更新
        end
    end
    
    for i=1:d
        for j=1:N
            if  v(j,i)>vlimit(i,2)
                v(j,i)=vlimit(i,2);
            end
            if  v(j,i) < vlimit(i,1)
                v(j,i)=vlimit(i,1);
            end
        end
    end
    x = x + v;          
    for i=1:d           
        for j=1:N
            if  x(j,i)>limit(i,2)
                x(j,i)=limit(i,2);
            end
            if  x(j,i) < limit(i,1)
                x(j,i)=limit(i,1);
            end
        end
    end
    record(iter) = fym;
    

    disp(['In iteration ' num2str(iter) ' : the optimal value is ' num2str(fym)]);
    iter = iter+1;
end

disp(['End iteration, the optimal working point is ' num2str(ym) ' : the optimal robust radius is ' num2str(fym)])           % Final result output
%% Drawing
plot(record)
grid on
hold on
box on
xlabel('iteration')
ylabel('error')

% save data_T_0.001.mat record ym fym           % Save date
