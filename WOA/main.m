% You can simply define your cost in a seperate file and load its handle to fobj
% The initial parameters that you need are:
%__________________________________________
% fobj = @YourCostFunction
% dim = number of your variables
% Max_iteration = maximum number of generations
% SearchAgents_no = number of search agents
% lb=[lb1,lb2,...,lbn] where lbn is the lower bound of variable n
% ub=[ub1,ub2,...,ubn] where ubn is the upper bound of variable n
% If all the variables have equal lower bound you can just
% define lb and ub as two single number numbers

% To run GWO: [Best_score,Best_pos,GWO_cg_curve]=GWO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj)
%__________________________________________

clear
clc
% for funcidx = 1:13
RUNS = 1;


drawing_flag = 1;
TestProblem='UF4';
dim=2;
[R,Dim]=size(TestProblem);
fobj = cec09(TestProblem);
TPF=xlsread('Case3.xls',TestProblem);
xrange = xboundary(TestProblem, dim);

% Lower bound and upper bound
lb=[5.00001,0.50001];
ub=[45.00001,4.50001];
VarSize=[1 dim];
SearchAgents_no=50;% Number of search agents
Max_iteration=200;  % Maximum Number of Iterations
Archive_size=150;   % Repository Size

alpha=0.1;  % Grid Inflation Parameter
nGrid=10;   % Number of Grids per each Dimension
beta=4; %=4;    % Leader Selection Pressure Parameter
gamma=2;    % Extra (to be deleted) Repository Member Selection Pressure

Best_scores = inf*ones(2,RUNS);
Best_poss = zeros(RUNS,dim);
GWO_cg_curves = inf*ones(RUNS,Max_iteration);
for i = 1:RUNS
    [Best_score,Best_pos,GWO_cg_curve,Archive_costs]=MOGWO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,alpha,nGrid,beta,gamma,Archive_size);
    [Xmin,Ymin] = BEST_POINT(Archive_costs);
    X(i) = Xmin;
    Y(i) = Ymin;
    Best_scores(:,i) = Best_score';
    Best_poss(i,:) = Best_pos;
    %         GWO_cg_curves(i,:) = GWO_cg_curve;
    hold on
end

plot(GWO_cg_curve)


%% save

%     save(fullfile(folder,sprintf('%s.mat',Function_name)),'GWO_cg_curves','Best_poss','Best_scores','meanGWO_cg_curve','meanBest_score','StdBest_score','minBest_score','minBest_pos');
% end


%%
% save date_T_19.99.mat Best_pos Best_score GWO_cg_curve