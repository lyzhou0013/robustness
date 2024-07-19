
function [Alpha_score,Alpha_pos,Convergence_curve,Archive_costs]=MOGWO(SearchAgents_no,Max_iter,lb,ub,dim,fobj,alpha,nGrid,beta,gamma,Archive_size)
global initial_flag
Alpha_pos=zeros(1,dim);
Alpha_score=inf; %change this to -inf for maximization problems

GreyWolves=CreateEmptyParticle(SearchAgents_no);
for i=1:SearchAgents_no
    GreyWolves(i).Velocity=0;
    GreyWolves(i).Position=zeros(1,dim);
    for j=1:dim
        GreyWolves(i).Position(1,j)=unifrnd(lb(j),ub(j),1);
    end
    GreyWolves(i).Cost=fobj(GreyWolves(i).Position')';
    GreyWolves(i).Best.Position=GreyWolves(i).Position;
    GreyWolves(i).Best.Cost=GreyWolves(i).Cost;
end
[R,Dim]=size(GreyWolves(i).Cost);
Convergence_curve=zeros(Max_iter,Dim);

GreyWolves=DetermineDomination(GreyWolves);

Archive=GetNonDominatedParticles(GreyWolves);

Archive_costs=GetCosts(Archive);
G=CreateHypercubes(Archive_costs,nGrid,alpha);

for i=1:numel(Archive)
    [Archive(i).GridIndex Archive(i).GridSubIndex]=GetGridIndex(Archive(i),G);
end

% MOGWO main loop
minsore = [0;0];
drawing_flag = 1;

for it=1:Max_iter
    a=2-it*((2)/Max_iter);
    for i=1:SearchAgents_no
        clear rep2
        clear rep3
        
        % Choose the alpha, beta, and delta grey wolves
        Delta=SelectLeader(Archive,beta);
        Beta=SelectLeader(Archive,beta);
        Alpha=SelectLeader(Archive,beta);
        Alpha_pos=Alpha.Position;
        Alpha_score=Alpha.Cost;
        if size(Archive,1)>1
            counter=0;
            for newi=1:size(Archive,1)
                if sum(Delta.Position~=Archive(newi).Position)~=0
                    counter=counter+1;
                    rep2(counter,1)=Archive(newi);
                end
            end
            Beta=SelectLeader(rep2,beta);
        end
        if size(Archive,1)>2
            counter=0;
            for newi=1:size(rep2,1)
                if sum(Beta.Position~=rep2(newi).Position)~=0
                    counter=counter+1;
                    rep3(counter,1)=rep2(newi);
                end
            end
            Alpha=SelectLeader(rep3,beta);
        end
        c=2.*rand(1, dim);
        D=abs(c.*Delta.Position-GreyWolves(i).Position);
        A=2.*a.*rand(1, dim)-a;
        X1=Delta.Position-A.*abs(D);
        c=2.*rand(1, dim);
        D=abs(c.*Beta.Position-GreyWolves(i).Position);
        A=2.*a.*rand()-a;
        X2=Beta.Position-A.*abs(D);
        c=2.*rand(1, dim);
        D=abs(c.*Alpha.Position-GreyWolves(i).Position);
        A=2.*a.*rand()-a;
        X3=Alpha.Position-A.*abs(D);
        GreyWolves(i).Position=(X1+X2+X3)./3;
        GreyWolves(i).Position=min(max(GreyWolves(i).Position,lb),ub);
        GreyWolves(i).Cost=fobj(GreyWolves(i).Position')';
    end
    
    GreyWolves=DetermineDomination(GreyWolves);
    non_dominated_wolves=GetNonDominatedParticles(GreyWolves);
    
    Archive=[Archive
        non_dominated_wolves];
    
    Archive=DetermineDomination(Archive);
    Archive=GetNonDominatedParticles(Archive);
    
    for i=1:numel(Archive)
        [Archive(i).GridIndex Archive(i).GridSubIndex]=GetGridIndex(Archive(i),G);
    end
    
    if numel(Archive)>Archive_size
        EXTRA=numel(Archive)-Archive_size;
        Archive=DeleteFromRep(Archive,EXTRA,gamma);
        
        Archive_costs=GetCosts(Archive);
        G=CreateHypercubes(Archive_costs,nGrid,alpha);
        
    end
    
    disp(['In iteration ' num2str(it) ': Number of solutions in the archive = ' num2str(Alpha_score(1))]);
    save results
    costs=GetCosts(GreyWolves);
    Archive_costs=GetCosts(Archive);
    
%     if drawing_flag==1
%         hold off
% %         plot(costs(1,:),costs(2,:),'k.');
% %         hold on
%         plot(Archive_costs(1,:),Archive_costs(2,:),'bp');
%         hold on 
%         legend('Grey wolves','Non-dominated solutions');
%         drawnow
%     end
    if Alpha_score(1) < minsore
        minsore = Alpha_score;
        minPos = Alpha_pos;
    end
    Convergence_curve(it,:)=minsore(1);
end

Alpha_score = minsore;
Alpha_pos = minPos;



