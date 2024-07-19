clc;clear;close all;
load data_BFS_55_1.mat opt_cur
ym=opt_cur(1,1);
AA=55;lambda=9.99;
count=1;i=0;
    for m=13.68908:0.0000001:13.68910
        for mu=1.247948:0.0000001:1.247950
            record(count,:)=[m,mu];
            y(count)=lingyu_G([m,mu],AA,lambda);
            if y(count)>ym
                i=1;
                ym=y(count);
                opt_cur=[ym,m,mu];
            end
            count=count+1;
        end
        disp(['The iteration is : ', num2str(count),', m is : ', num2str(m), ', The best solution of m is : ',num2str(opt_cur) ]);
    end
[a,b]=max(y);
% save data_BFS_55_1.mat opt_cur




