function g = germination_integral(s,t)
% Hand-made Gauss-Legendre quadrature with 3 nodes
% t is "local time", that is 0<=t<=L

global cat_lengths cat_centers m PD 

   cat_lengths(1)   = t ;
   cat_centers(1)   = -t/2 ;
   
%     cat_centers_rep  = repmat(cat_centers,m,1) ;
%     cat_lengths_rep  = repmat(cat_lengths,m,1) ;
   
% reemplazo por esto:
       idx=(1:size(cat_centers,1))';    %[1:size(cat_centers,1)]';
       rmpt=idx(:,ones(m,1));
       cat_centers_rep = cat_centers(rmpt(:),:);  %rmpt(:);
   
       idx=(1:size(cat_lengths,1))';    %[1:size(cat_lengths,1)]';
       rmpt=idx(:,ones(m,1));
       cat_lengths_rep = cat_lengths(rmpt(:),:);  %rmpt(:);
 
      
   g    = s .* PD.bc_seeds(cat_centers_rep+t) * 0.8888888888888889 ; 
   u    = cat_lengths_rep*0.3872983346207417 ; % magic factor=sqrt(3/5)/2
   g    = g + 0.5555555555555556*(s.*PD.bc_seeds(cat_centers_rep+u+t));
   g    = g + 0.5555555555555556*(s.*PD.bc_seeds(cat_centers_rep-u+t));
  
   g    = g * 0.5 ;
   
end
