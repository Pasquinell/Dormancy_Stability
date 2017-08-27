function dy = rhs(t,y)


%global adult_mortality dormant_mortality attack_rate handling_time efficiency K r

global L m ubicaBasales ubicaNoBasales ubicaEdadCero cat_centers 

global N 
global P PD TP
global iter

iter2       = iter;
time        = iter2*L + t;
%adults = y(1:m) ;
dormants    = y(m+1:end) ;

%sigmaMatrix = [];%NaNa(m*size(cat_centers,1),1) ; %creo una matrix vacia para guardar los elementos que van a ser multiplicados dentro de g

%ccsize      = size(cat_centers,1) ;

% for i=1:m
%     sigmaMatrix2 = [sigmaMatrix2 ;repmat(PD.sigma(i),ccsize,1)] ;
% end

% 
% reemplazo for y repmat:
xidx=(1:size(PD.sigma,1))';
xrm=xidx(:,ones(size(cat_centers,1),1))';
sigmaMatrix=PD.sigma(xrm(:),:);


%ph_germination: es la f(t) del pdf
g           = sigmaMatrix.*germination_integral(dormants, t); % Integral que hace el c�lculo de 
%los dormantes que estan listos para pasar a adutos seg�n la edad

%estaeslarazon = size(g,1)./size(cat_centers,1)
%[gg, pad]   = vec2mat(g, N) ;% gg es un vector de tama�o m*N que indica
% abunancia de dormante por (especie,edad) 
% reemplaza:
gg=reshape(g,N,m)';



FV          = flow_vector(P, PD,TP, y(1:m),gg,time) ;

FenoRec     =      PD.ICte_funR+ PD.ph_germination(time)+PD.IC_funR(y(1:m))+PD.IHD_funR(y(1:m),time)+PD.IHP_funR(y(1:m),time);
FenoDorm    =      PD.ICte_funD+PD.ph_production(time)+PD.IC_funD(y(1:m))+PD.IHD_funD(y(1:m),time)+PD.IHP_funD(y(1:m),time)  ;

dy = (FV.Self_Basals1 + FV.Self_Basals2)-FV.Outp_Basals+ FV.Self_Consumers - FV.Dead ...
    - FV.Consume_Out ...
    + (1-FenoDorm).*FV.Consume_In ;

%[max(FV.Consume_Out(:)) min(FV.Consume_Out(:))]
geraux1     = FenoRec;
geraux2     = [];
   
% ccsize=size(cat_centers,1);
% 
%  for i=1:m
%     geraux2 = [geraux2 ;repmat(geraux1(i),ccsize,1)];
%  end

% reemplazo:
xidx=(1:size(geraux1,1))';
xrm=xidx(:,ones(size(cat_centers,1),1))';
geraux2=geraux1(xrm(:),:);


ddormants   = -PD.mort.*dormants - g.*geraux2;


%ddormants(ubicaVec_noBasales) = -mort*dormants(ubicaVec_noBasales) - sigma*g(ubicaVec_noBasales) ;
FunctResp   = FenoDorm .*FV.Consume_In ;
prodAux     = FenoDorm ;


%D_1 (t,u=0)=??h_1(t)B_1(t) :
ddormants(...
    ubicaEdadCero(...
        ubicaBasales)-m)   = ddormants(ubicaEdadCero(ubicaBasales)-m) + ...
                                        FenoDorm(ubicaBasales).* PD.eta.*PD.beta(ubicaBasales)...
                                        .*y(ubicaBasales).*prodAux(ubicaBasales);
                                    
%D_2(t,u=0)=?*h_2(t)*X_2*Y_2*B_2(t)*F_21 :
ddormants(...
    ubicaEdadCero(...
        ubicaNoBasales)-m) = ddormants(ubicaEdadCero(ubicaNoBasales)-m) + ...
                                        FenoDorm(ubicaNoBasales).*PD.kappa.*FunctResp(ubicaNoBasales) ;



dy              = [dy ; ddormants];

end
