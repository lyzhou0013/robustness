function non_dom=quick_sort(pop)
    npop=size(pop,1);
    K=10;
    pop(:,K+3)=0;
    for i=1:npop
        pop(i,K+3)=0;
        for j=1:i-1
            if pop(j,K+3)==0
                if Dominates(pop(i,K+1:K+2)',pop(j,K+1:K+2)')
                    pop(j,K+3)=1;
                elseif Dominates(pop(j,K+1:K+2)',pop(i,K+1:K+2)')
                    pop(i,K+3)=1;
                    break;
                end
            end
        end
    end
   ind=find(pop(:,K+3)==0);
   non_dom=pop(ind,1:K+2);
end


