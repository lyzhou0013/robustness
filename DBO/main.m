% -----------------------------------------------------------------------------------------------------------
% Dung Beetle Optimizer: (DBO) (demo)
% Programmed by Jian-kai Xue    
% Updated 28 Nov. 2022.                     
%
% This is a simple demo version only implemented the basic         
% idea of the DBO for solving the unconstrained problem.    
% The details about DBO are illustratred in the following paper.    
% (To cite this article):                                                
%  Jiankai Xue & Bo Shen (2022) Dung beetle optimizer: a new meta-heuristic
% algorithm for global optimization. The Journal of Supercomputing, DOI:
% 10.1007/s11227-022-04959-6
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% qq»∫£∫439115722
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear 
clc

SearchAgents_no=50; % poputation size

Function_name='F4'; % Call the function name

Max_iteration=100; % maximum iteration

% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);
[fMin,bestX,DBO_curve]=DBO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj); %Call the DBO algorithm

%Drawing
semilogy(DBO_curve,'Color','g')
title('Objective space')
xlabel('Iteration');
ylabel('Best score obtained so far');
%axis tight
grid on
box on
legend('DBO')
display(['The best solution obtained by DBO is : ', num2str(bestX)]);
display(['The best optimal value of the objective funciton found by DBO is : ', num2str(fMin)]);
%Save data
% save data_T_15.99.mat bestX fMin DBO_curve




