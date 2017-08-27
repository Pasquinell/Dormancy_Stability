function tt

m=2;
sigma=[0.0750    1.1224];
cat_centers=[0 1 1]';
sigmaMatrix=[];
for i=1:m
    sigmaMatrix = [sigmaMatrix ;repmat(sigma,size(cat_centers,1),1)];
end

sigmaMatrix

sigmaMatrix=[];
% for i=1:m
%     sigmaMatrix = [sigmaMatrix ;repmat(sigma,size(cat_centers,1),1)];
% end
sigmaMatrix = sigma(ones(size(cat_centers,1)*m,1),:);
    
sigmaMatrix

end