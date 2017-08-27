
% PARA VARIAS ESPECIES
TP = [0 1]' ;
m = length(TP) ; 
T = 1:.01:100;
rangofen = 2 ;
DESFf                       = 1/52.18*(-11 +TP.*unifrnd(0,rangofen,m,1));  %variacion de un mes para adelante o un mes para atras
DESFh                       = 1/52.18*(-7+TP.*unifrnd(0,rangofen,m,1));
 

 ph_germination  = @(t)  spulse(2*(t/52.18-DESFf+.01-floor(t/52.18-DESFf+.01)),16) ;
 ph_production   = @(t)  spulse(2*(t/52.18+.01-DESFh-floor(t/52.18+.01-DESFh)),16);

%DESFf                       =(22 +TP.*unifrnd(0,rangofen,m,1));  %variacion de un mes para adelante o un mes para atras
%DESFh                       =(26+TP.*unifrnd(0,rangofen,m,1));
 %ph_germination  = @(t)  sin(t/52.18*pi-DESFf/52.18*pi).^10 ;
 %ph_production   = @(t)  sin(t/52.18*pi-DESFh/52.18*pi).^10 ;
 
 
R = NaN(m,length(T)); 
D = NaN(m,length(T)); 
aux = 1 ;
for t = T
    R(:,aux) = ph_germination(t);
    D(:,aux) = ph_production(t) ;
    aux = aux + 1 ;
end

v1 = 1 ;
min_wp                  = 0	;
max_wp                  = v1;
real_max_wp             = .5 ; % 4 8 16 
t = T ;

winter_punish           = real_max_wp.*(max_wp-min_wp)*(sin(t/52.18*2*pi-12/52.18*2*pi)*0.5+0.5)+min_wp; %antes del cambio de wp era -17/52.18*2*pi


figure
plot(T,R)
hold on
  plot(T,D,'-.')
  hold on
plot(T,winter_punish,'r')
hold off

% PARA UNA ESPECIE
% t = 0:.1:52.18; 
% DESFf                   = -7/52.18;
% ph_germination          = @(t)  spulse(2*(t/52.18-DESFf+.01-floor(t/52.18-DESFf+.01)),16); %f(t) ;
% DESFh                   = 30/52.18;%15/52.18;
% ph_production           = @(t)  spulse(2*(t/52.18+.01-DESFh-floor(t/52.18+.01-DESFh)),16); %h(t)
% min_wp                  = 0	;%LH(replicas,13);
% max_wp                  = 1	;
% winter_punish           = @(t) (max_wp-min_wp)*(cos(t/52.18*2*pi-17/52.18*2*pi)*0.5+0.5)+min_wp;
% 
% 
% figure; plot(t,ph_germination(t),t,ph_production(t),t,winter_punish(t))


%%%% integral de area de recruitement (ph_germination)

%ph_germination_plano   	=   @(t) 1 ;

% area_recr               = trapz(t,ph_germination(t))
% area_recrplano          = 1*52.18*(24.9834/52.18)                       %trapz(t,ph_germination_plano(t));
