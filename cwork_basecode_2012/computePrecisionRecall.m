function [p,r]=computePrecisionRecall(fileCategory)
    queryCategory=fileCategory(1);
    categoryTotal = 30;
    relevantTotal = 0;
    
    for i=1:length(fileCategory)
%         if(i~=1)   
            if(fileCategory(1,i) == queryCategory)
                 relevantTotal = relevantTotal + 1;
            end
            p(i) = relevantTotal/i;
            r(i) = relevantTotal/categoryTotal;
%         end
    end
end