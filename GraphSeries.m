function [to_plotFlujos to_plotConsume] = GraphSeries(n_iter,varBif, to_plotAdults, to_plotDormants, y_all, dormantsFull  )
% Este

%global L
global M m ubicaBasales ubicaNoBasales
%global ubicaEdadCero
global cat_centers Limit_dormant_age
%global ET
global P PD TP 

A                   = M(:,1:end-1) ;
N                   = 2 ; %cuï¿½ntos estados tien cada dormante

%IntervalABund       = 24:n_iter;
IntervalFlux        = 1:n_iter;

Self_Basals1        = NaN(m,floor(n_iter));
Self_Basals2        = NaN(m,floor(n_iter));
Outp_Basals         = NaN(m,floor(n_iter));
Self_Consumers      = NaN(m,floor(n_iter));
Dead_Consumers      = NaN(m,floor(n_iter));
Consume_Out_mat     = NaN(m,m,floor(n_iter));   %%% Cambio a forma matricial
Consume_In_mat      = NaN(m,m,floor(n_iter));   %%% Cambio a forma matricial


for t=IntervalFlux
    
  
    FenoRec     =      PD.ICte_funR+ PD.ph_germination(t)+PD.IC_funR(to_plotAdults(:,t))+PD.IHD_funR(to_plotAdults(:,t),t)+PD.IHP_funR(to_plotAdults(:,t),t);
    FenoDorm    =      PD.ICte_funD+PD.ph_production(t)+PD.IC_funD(to_plotAdults(:,t))+PD.IHD_funD(to_plotAdults(:,t),t)+PD.IHP_funD(to_plotAdults(:,t),t) ;

   
    %treg(handler,32,'v:DORMFUL',dormantsFull{t});
    [gg, padded] = vec2mat(dormantsFull{t}, N) ;
    %gg              = reshape(dormantsFull{t}, N, m).';
    %treg(handler,32,'v:GG',gg);
    
    %     t=t
    %     size(dormantsFull{t})
    %     size(cat_centers)
    %     Limit_dormant_age
    %     size(repmat(PD.bc_seeds(cat_centers(1:(1+Limit_dormant_age)))',2,1))
    %     size(gg)
    %     t
    
    Calculo_cat         = size(gg,2)-1;
    
    % size(repmat(PD.bc_seeds(cat_centers(1:(Calculo_cat)))',2,1))
    % size(gg)
    % catcenterENTERO = cat_centers
    % catcenters = cat_centers(1:(1+t))
    % bcseeds = PD.bc_seeds(cat_centers(1:(1+t)))
    % repmatr=repmat(PD.bc_seeds(cat_centers(1:(1+t)))',2,1)
    % ggc = gg
    % PDepsilon = PD.epsilon
    % PR = P.R
    % PONES = P.ONES
    % TOPLOTADULTS = to_plotAdults(:,t)
    % PK = P.K
    % MUL_PR_X_OTROS = P.ONES-to_plotAdults(:,t).*P.K
    
    % sizecatcenters = size(cat_centers(1:(1+t)))
    % sizebcseeds = size(PD.bc_seeds(cat_centers(1:(1+t))))
    % sizerepmatr = size(repmat(PD.bc_seeds(cat_centers(1:(1+t)))',2,1))
    % ssizegg = size(gg)
    % SPONES = size(P.ONES-to_plotAdults(:,t).*P.K )
    % t=t
    
    % PH_GERMINSATION = PD.ph_germination(t)
    % PDepsilon = PD.epsilon
    % PDsigma_TRANSP = PD.sigma'
    %
    % repmatr_TRANSP=repmat(PD.bc_seeds(cat_centers(1:(1+t)))',m,1)
    % ggc = gg
    % SUMA_REPMAT_GG =  sum(gg.*repmat(PD.bc_seeds(cat_centers(1:(1+t)))',m,1),2)
    % TP_IGUAL_CERO = (TP==0)
    % SUMA_X_TP = sum(gg.*repmat(PD.bc_seeds(cat_centers(1:(1+t)))',m,1),2).*(TP==0)
    %
    % MUL_PHGER_X_PDEPSILON = PD.ph_germination(t).*PD.epsilon
    % MUL_PHGER_X_PDEPSILON_X_PD_SIGMA = PD.ph_germination(t).*PD.epsilon*PD.sigma'
    
    if t<= Limit_dormant_age
        
        Self_Basals1(:,t)       = (P.R .* (P.ONES - to_plotAdults(:,t).* P.K ).*  ...
            (1-FenoDorm) .* to_plotAdults(:,t)) .* (TP==0);
        
       
       
        Self_Basals2(:,t)       = (P.R .* (P.ONES - to_plotAdults(:,t) .* P.K ) .* (FenoRec ...
            .* PD.epsilon .* PD.sigma .* sum(gg .* ...
            repmat(PD.bc_seeds(cat_centers(1:(1 + t)))',m,1),2))) .* (TP==0);
        
        Outp_Basals(:,t)        = 0;%PD.beta .* PD.ph_production(t) .* to_plotAdults(:,t) .* (TP==0);
        
        Self_Consumers(:,t)     = PD.sigma .* FenoRec .* PD.epsilon .* ...
            sum(gg .* repmat(PD.bc_seeds(cat_centers(1:(1+t)))',m,1),2) .* (TP~=0);
        
        Dead_Consumers(:,t)     = P.T .* to_plotAdults(:,t) ; %tasa metabolica
        
%         Consume_Out(:,t)        = ((P.EC' * ((1./(A' * (to_plotAdults(:,t) .^ P.teta) .* P.alpha + P.Beta .^ ...
%             P.teta)) .* (P.alpha .* P.E_Jmax .* to_plotAdults(:,t)))) .* ...
%             to_plotAdults(:,t) .^ P.teta );

        Consume_Out_mat(:,:,t)      = ((P.EC.*(repmat(1./(A'*(to_plotAdults(:,t).^P.teta).*P.alpha+P.Beta.^P.teta),1,m).* ... 
                        repmat(P.alpha.*P.E_Jmax.*to_plotAdults(:,t),1,m)))'.*repmat(to_plotAdults(:,t).^P.teta,1,m ))';
        
        %Consume_In(:,t)         = PD.winter_punish(t) .* (1-PD.ph_production(t)) .* (A' * (to_plotAdults(:,t) .^ ...
           % P.teta) .* ((1./(A' * to_plotAdults(:,t) .^ P.teta .* P.alpha + P.Beta .^ ...
          %  P.teta)) .*  (P.alpha .* P.E_Jmax .* to_plotAdults(:,t)) ));

%          winter= PD.winter_punish(t)
%           phproduction = (PD.ph_production(t))
%          
%          to_plotAdult = to_plotAdults(:,t)
%          REPMAT_to_plotAdulttrans = repmat(to_plotAdults(:,t)',m,1)
%          multi_Atrans_REPMAT_TOPLOTtrans = A'.*(repmat(to_plotAdults(:,t)',m,1))
%          div_uno_Atrans_TOPLOT = 1./(A'*to_plotAdults(:,t))
%          REPMAT_div_uno_Atrans_TOPLOT = repmat(1./(A'*to_plotAdults(:,t).^P.teta.*P.alpha+P.Beta.^P.teta),1,m)
%          REPMAT_TOPLOT = repmat(P.alpha.*P.E_Jmax.*to_plotAdults(:,t),1,m)
%           REPMAT_PH_PROD = repmat(PD.ph_production(t)',m,1)
          
         Consume_In_mat(:,:,t)      = (1-repmat(PD.ph_production(t)',m,1)) .* (A'.*(repmat(to_plotAdults(:,t)',m,1).^P.teta).*(repmat(1./(A'*to_plotAdults(:,t).^P.teta.*P.alpha+P.Beta.^P.teta),1,m).* ...
                          repmat(P.alpha.*P.E_Jmax.*to_plotAdults(:,t),1,m)   ))';
        
        N = N+1;
    else
        Self_Basals1(:,t)       = (P.R .* (P.ONES - to_plotAdults(:,t) .* P.K ) .* ...
            (1 - FenoDorm) .* to_plotAdults(:,t)) .* (TP==0);
        
        
        
        Self_Basals2(:,t)       = (P.R .* (P.ONES - to_plotAdults(:,t) .* P.K ) .* (FenoRec .* ...
            PD.epsilon .* PD.sigma .* sum(gg .* repmat(PD.bc_seeds(cat_centers(1:(1 + ...
            Calculo_cat)))',m,1),2))) .* (TP==0);
        
        Outp_Basals(:,t)        = 0 ;%PD.beta .* FenoDorm .* to_plotAdults(:,t) .* (TP==0);
        
        Self_Consumers(:,t)     = PD.sigma .* FenoRec .* PD.epsilon .* sum(gg .* repmat(PD.bc_seeds( ...
            cat_centers(1:(1 + Calculo_cat)))',m,1),2) .* (TP~=0);
        
        Dead_Consumers(:,t)     = (P.T ).* to_plotAdults(:,t) ; %tasa metabolica
        
%         Consume_Out(:,t)        = ((P.EC' * ((1./(A' * (to_plotAdults(:,t) .^ P.teta) .* P.alpha + P.Beta .^ P.teta)) ...
%             .* (P.alpha .* P.E_Jmax .* to_plotAdults(:,t)))) .* to_plotAdults(:,t).^P.teta );

        Consume_Out_mat(:,:,t)      = ((P.EC'.*(repmat(1./(A'*(to_plotAdults(:,t).^P.teta).*P.alpha+P.Beta.^P.teta),1,m).* ... 
                        repmat(P.alpha.*P.E_Jmax.*to_plotAdults(:,t),1,m)))'.*repmat(to_plotAdults(:,t).^P.teta,1,m ))';
        
            %Consume_In(:,t)         = PD.winter_punish(t) .* (1 - PD.ph_production(t)) .* (A' * (to_plotAdults(:,t)...
                %.^ P.teta) .* ((1 ./ (A' * to_plotAdults(:,t) .^ P.teta .* P.alpha + P.Beta...
               % .^ P.teta)) .* (P.alpha .* P.E_Jmax .* to_plotAdults(:,t)) ));
    %        Consume_In_mat(:,:,t)   = PD.winter_punish(t) .* (1-PD.ph_production(t)) .* ...
    %            (A'.*(repmat(to_plotAdults(:,t)',m,1).^P.teta).*(repmat(1./(A'*to_plotAdults(:,t).^P.teta.*P.alpha+P.Beta.^P.teta),1,m).* ...
    %                           repmat(P.alpha.*P.E_Jmax.*to_plotAdults(:,t),1,m)   ))'; 
%                       
         Consume_In_mat(:,:,t)      = (1-repmat(FenoDorm',m,1)) .* (A'.*(repmat(to_plotAdults(:,t)',m,1).^P.teta).*(repmat(1./(A'*to_plotAdults(:,t).^P.teta.*P.alpha+P.Beta.^P.teta),1,m).* ...
                          repmat(P.alpha.*P.E_Jmax.*to_plotAdults(:,t),1,m)   ))';
    end
    
end



% Consume_in_mean = mean(Consume_In,2) ; % vect6or vertical que hay que reordenarlo a una matriz
% Agregar valores a posiciones dentro de matriz M(:,1:end-1)



% treg(handler, 0, 'N_ITER',n_iter);
% treg(handler, 0, 'CONS_IN',Consume_In);
% treg(handler, 0, 'XCONS_IN',mean(Consume_In,2));
% treg(handler, 0, 'XCONS_OU',mean(Consume_Out,2));
% treg(handler, 0, 'XDEADCON',mean(Dead_Consumers,2));
% treg(handler, 0, 'XSELFCON',mean(Self_Consumers,2));
% treg(handler, 0, 'XSELFBAS1',mean(Self_Basals1,2));
% treg(handler, 0, 'XSELFBAS2',mean(Self_Basals2,2));


Self_Basals1        = Self_Basals1(ubicaBasales,:);
Self_Basals2        = Self_Basals2(ubicaBasales,:);
Outp_Basals         = Outp_Basals(ubicaBasales,:);
Self_Consumers      = Self_Consumers(ubicaNoBasales,:);
Dead_Consumers      = Dead_Consumers(ubicaNoBasales,:);
% Consume_Out         = Consume_Out(ubicaBasales,:);
%Consume_In          = Consume_In(ubicaNoBasales,:);

% if 1==0
%     figure
%     plot(IntervalABund,to_plotAdults,IntervalABund,to_plotDormants)
%     legend('Active Algae','Active Rotifer','Dormant Algae', 'Dormant Rotifer')
%     xlabel('Time(Weeks)') ;
%     ylabel('AdultState') ;
%     
%     figure
%     plot(IntervalFlux,Self_Basals1,'b',IntervalFlux,Self_Basals2,'.-',IntervalFlux,Outp_Basals,IntervalFlux,Self_Consumers,IntervalFlux,Dead_Consumers,IntervalFlux,Consume_Out,IntervalFlux,Consume_In)
%     legend('Self Basal Parthenog','Self Basal Recruit','Outp. Basal','Self Consumer', 'Dead Consumer', 'Consumer Out', 'Consumer In')
%     xlabel('Time(Weeks)') ;
%     ylabel('Flux') ;
%     
%     figure
%     plot(IntervalFlux, winter_punish(:), IntervalABund,a(1,:),IntervalABund, a(2,:))
%     legend('Temperature', 'Basal Recruitment', 'Consumer Recruitment')
%     xlabel('Time(Weeks)') ;
%     ylabel('Phenologies') ;
% end
ag = 5;%años guardados
to_plotFlujos = [Self_Basals1(:,end-floor(ag*52.18):end)  ;       ...
    Self_Basals2(:,end-floor(ag*52.18):end)  ;       ...
    Outp_Basals(:,end-floor(ag*52.18):end) ;      ...
    Self_Consumers(:,end-floor(ag*52.18):end) ;  ...
    Dead_Consumers(:,end-floor(ag*52.18):end)  ];

to_plotConsume = struct('Consume_In_mat',Consume_In_mat,'Consume_Out_mat',Consume_Out_mat ) ; 
%to_plotConsume = struct('Consume_In_mat',Consume_In_mat(:,:,end-floor(ag*52.18):end),'Consume_Out_mat',Consume_Out_mat(:,:,end-floor(ag*52.18):end) ) ; 

% to_plotFlujos = [Self_Basals1  ;       ...
%     Self_Basals2  ;       ...
%     Outp_Basals ;      ...
%     Self_Consumers ;  ...
%     Dead_Consumers ;  ...
%     Consume_Out    ;  ...
%     Consume_In       ...
%     ];



end

