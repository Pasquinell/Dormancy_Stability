function FV = flow_vector(P, PD ,TP,y,gg,time) %es llamado en rhs
%FLOW_VECTOR Summary of this function goes here
%   Detailed explanation goes here

global  A AT
%P =aP;
% PD = aPD;
% TP = aTP;
% y= ay ;
% gg =agg;
% t = at;
 
FenoRec     =      PD.ICte_funR+ PD.ph_germination(time)+PD.IC_funR(y)+PD.IHD_funR(y,time)+PD.IHP_funR(y,time) ;
FenoDorm    =      PD.ICte_funD+PD.ph_production(time)+PD.IC_funD(y)+PD.IHD_funD(y,time)+PD.IHP_funD(y,time) ;


Self_Basals1    = (P.R.*(P.ONES-y.*P.K ).*((1-FenoDorm).*y)).*(TP==0);
Self_Basals2    = (P.R.*(P.ONES-y.*P.K ).*(FenoRec.*PD.epsilon.*sum(gg,2))).*(TP==0);

Outp_Basals     = 0;%PD.beta.*PD.ph_production(t).*y(1:m).*(TP==0);

Self_Consumers  = FenoRec.*PD.epsilon.*sum(gg,2).*(TP~=0);


Dead  = P.T.*(1+PD.winter_punish(time)).*y + .05*P.R.*PD.winter_punish(time).*y;  %tasa metabolica

%T       = aT.*BS.^(-0.25);% Ti(tasa de respiracion masa especifica)
%E_Jmax  = aJ.*BS.^(-0.25);% Jp(tasa de consumo asintótico de la presa j)
%R       = aR.*BS.^(-0.25);% Ri (razon intrinseca Produccion/Biomasa)
%P.alpha es la preferencia
%Beta            = ones(S,1)*0.1;%0.1; % valores de constante de saturación media.
                                      % se cambió el 26Dic2013 para calzar con 
                                      % las unidades
Consume_Out     = ((P.EC'*((1./(AT*(y.^P.teta).*P.alpha+P.Beta.^P.teta)).* ... 
                        (P.alpha.*P.E_Jmax.*y))).*y.^P.teta );

Consume_In      = (AT*(y.^P.teta).*((1./(AT*y.^P.teta.*P.alpha+P.Beta.^P.teta)).* ...
                        (P.alpha.*P.E_Jmax.*y) ));

FV = struct('Self_Basals1',Self_Basals1,'Self_Basals2',Self_Basals2, 'Outp_Basals',Outp_Basals , ...
            'Self_Consumers',Self_Consumers, ...
            'Dead',Dead  , 'Consume_Out',Consume_Out,'Consume_In',Consume_In ) ;

end

