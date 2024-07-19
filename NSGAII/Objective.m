
function [Output,Boundary] = Objective(Operation,Problem,M,Input)

persistent K; 


Boundary = NaN;
switch Operation  
    
    %0£º
    case 0
        D = 2; 
        MaxValue   = [20,2];
        MinValue   = [6,0.5];
        Population = rand(Input,D);  
        Population = Population.*repmat(MaxValue,Input,1)+(1-Population).*repmat(MinValue,Input,1);
        
        Output   = Population;
        Boundary = [MaxValue;MinValue];
        
       
    case 1
        Population    = Input;  
        FunctionValue = zeros(size(Population,1),M);
        switch Problem
            case 'DTLZ1'
                g = 100*(K+sum((Population(:,M:end)-0.5).^2-cos(20.*pi.*(Population(:,M:end)-0.5)),2));
                for i = 1 : M  
                    FunctionValue(:,i) = 0.5.*prod(Population(:,1:M-i),2).*(1+g);
                    if i > 1
                        FunctionValue(:,i) = FunctionValue(:,i).*(1-Population(:,M-i+1));
                    end
                end
            case 'DTLZ2'
                g = sum((Population(:,M:end)-0.5).^2,2);
                for i = 1 : M
                    FunctionValue(:,i) = (1+g).*prod(cos(0.5.*pi.*Population(:,1:M-i)),2);
                    if i > 1
                        FunctionValue(:,i) = FunctionValue(:,i).*sin(0.5.*pi.*Population(:,M-i+1));
                    end
                end
            case 'DTLZ3'
                g = 100*(K+sum((Population(:,M:end)-0.5).^2-cos(20.*pi.*(Population(:,M:end)-0.5)),2));
                for i = 1 : M
                    FunctionValue(:,i) = (1+g).*prod(cos(0.5.*pi.*Population(:,1:M-i)),2);
                    if i > 1
                        FunctionValue(:,i) = FunctionValue(:,i).*sin(0.5.*pi.*Population(:,M-i+1));
                    end
                end
            case 'DTLZ4'
                Population(:,1:M-1) = Population(:,1:M-1).^100;
                g = sum((Population(:,M:end)-0.5).^2,2);
                for i = 1 : M
                    FunctionValue(:,i) = (1+g).*prod(cos(0.5.*pi.*Population(:,1:M-i)),2);
                    if i > 1
                        FunctionValue(:,i) = FunctionValue(:,i).*sin(0.5.*pi.*Population(:,M-i+1));
                    end
                end
            case 'DTLZ5'
                g = sum((Population(:,M:end)-0.5).^2,2);
                
                for i = 1 : M
                    theta =(pi./(4*(1+g))).*(1+2.*g.*Population(:,1:M-i));
                    FunctionValue(:,i) = (1+g).*prod(cos(0.5.*pi.*theta),2);
                    if i > 1
                        FunctionValue(:,i) = FunctionValue(:,i).*sin(0.5.*pi.*(pi./(4*(1+g))).*(1+2.*g.*Population(:,M-i+1)));
                    end
                end
            case 'D1'
                [K,~] = size(Population);
                for i=1:K
                    if (9.99/(Population(i,1)*Population(i,2)))>1 || G_ms(Population(i,1),Population(i,2))<60|| T_ms(Population(i,1),Population(i,2))>0.1
                        FunctionValue(i,1)=inf;
                        FunctionValue(i,2)=inf;
                    else
                        r11=dgm(Population(i,1),Population(i,2));
                        r22=dtm(Population(i,1),Population(i,2));
                        FunctionValue(i,1)=abs(r11-r22);
                        FunctionValue(i,2)=-(r11+r22);
                    end
                end
        end
        Output = FunctionValue;
end
end