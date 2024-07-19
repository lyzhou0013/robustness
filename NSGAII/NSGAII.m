%NSGA-II
clc;
clear;
close all
Problem='D1';
format compact;
tic;
Generations = 25;  
M = 2; 
N = 50; 


[Population,Boundary] = Objective(0,Problem,M,N);
FunctionValue = Objective(1,Problem,M,Population);

FrontValue = NonDominateSort(FunctionValue,0);
CrowdDistance = CrowdDistances(FunctionValue,FrontValue);


for Gene = 1 : Generations
    
    MatingPool = Mating(Population,FrontValue,CrowdDistance); 
    Offspring = NSGA_Gen(MatingPool,Boundary,N); 
    
    Population = [Population;Offspring];  
    
    FunctionValue = Objective(1,Problem,M,Population);
    [FrontValue,MaxFront] = NonDominateSort(FunctionValue,1); 
    CrowdDistance = CrowdDistances(FunctionValue,FrontValue);
    
    
    
    Next = zeros(1,N);
    NoN = numel(FrontValue,FrontValue<MaxFront);
    Next(1:NoN) = find(FrontValue<MaxFront);
    
    
    Last = find(FrontValue==MaxFront);
    [~,Rank] = sort(CrowdDistance(Last),'descend');
    Next(NoN+1:N) = Last(Rank(1:N-NoN));
    
   
    Population = Population(Next,:);
    FrontValue = FrontValue(Next);
    CrowdDistance = CrowdDistance(Next);
    
    FunctionValue = Objective(1,Problem,M,Population);
    cla;
    
   
    for i = 1 : MaxFront
        FrontCurrent = find(FrontValue==i);
        DrawGraph(FunctionValue(FrontCurrent,:));
        hold on;
        switch Problem  %
            case 'DTLZ1'
                if M == 2
                    pareto_x = linspace(0,0.5);
                    pareto_y = 0.5 - pareto_x;
                    plot(pareto_x, pareto_y, 'r');
                elseif M == 3
                    [pareto_x,pareto_y]  = meshgrid(linspace(0,0.5));
                    pareto_z = 0.5 - pareto_x - pareto_y;
                    axis([0,1,0,1,0,1]);
                    mesh(pareto_x, pareto_y, pareto_z);
                end
            otherwise
                if M == 2
                    pareto_x = linspace(0,1);
                    pareto_y = sqrt(1-pareto_x.^2);
                    plot(pareto_x, pareto_y, 'r');
                elseif M == 3
                    [pareto_x,pareto_y,pareto_z] =sphere(50);
                    axis([0,1,0,1,0,1]);
                    mesh(1*pareto_x,1*pareto_y,1*pareto_z);
                end
        end
        pause(0.01);
    end
    clc;
    disp(['In iteration ' num2str(Gene)]);
end

% save data_gai.mat FrontValue FunctionValue Population
FrontCurrent = find(FrontValue==1);
    figure(2)
    hold on
        DrawGraph(Population(FrontCurrent,:));
        % hold on
yy3=[y22(177:407)];
xx3=[x22(177:407)];
n=length(yy3);
for i=1:n
    yz(i)=yy3(n+1-i);
    xz(i)=xx3(n+1-i);
end
yx3=[y2(8:236),yz];
xy3=[x2(8:236),xz];
hold on 
h1=fill(xy3,yx3,[.0,.0,.0],'FaceAlpha',0.1);
        h2=plot(x22,y22,'LineWidth',2,'Color',[0.43 0.71 0.92]);
        h3=plot(x2,y2,'LineWidth',2,'Color',[0.95 0.35 0.21]);
        h4=plot(x4,y4,'--k');
        legend([h2,h3,h4],{'G=65','D=0.001','\rho=1'},'Location','southwest')
        grid on
        hold on
        xlim([6 20])
        ylim([0.5 2])
        
    figure(3)
        hold on
        plot(FunctionValue(FrontCurrent,1),FunctionValue(FrontCurrent,2),'*')
        xlabel('r_1')
        ylabel('r_2')
        grid on
        box on