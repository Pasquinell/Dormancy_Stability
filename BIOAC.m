function [W rho]=BIOAC(A,BS)
%%ACTUALIZADO 14/AGOSTO/2013

%Leslie Garay Narvaez
%Modificado 10-08-10
%Escalamiento alometrico de la salida y la entrada de contaminante desde 
%y hacia los organismos DESDE HERDRIKS ET AL. (2001)
%A=Matriz de Adyacencia
%BS=Tamaños corporales

%% PARAMETROS LOCALES
sizAV       = size(A,1);
%
%%%%%ONSERVACIONES: Cuando la matriz es aleatoria (E-R model) puede ser que no
%%%%%encuentre ninguna especie basal, en este caso serán todos no basales

b           = find(sum(A)'==0); %identifica especies basales 
nb          = find(sum(A)'>0);  %identifica especies no basales 

%"Lipidic layer permeation resistance"
LLPR        = zeros(sizAV,1);%vector de ceros
LLPR(b)     = 4.6*(10^3);    %"lipidic layer permeation resistance" valores de 
                             %resistencia de permeacion de la capa lipidica (rhoCH2,i) 
                             %para especies basales
LLPR(nb)    = 68;       %"lipidic layer permeation resistance" valores de resistencia 
                        %de permeacion de la capa lipidica (rhoCH2,i) para especies 
                        %no-basales
            
%"Water layer difusion resistance"
rhoh2o0     = 2.8*(10^(-3));    %water layer difusion resistance
rhoh2o1     = 1.1*(10^(-5));    %water layer difusion resistance
%
q           = 1;        %Temperature correction factor=1 for cold-blooded
%
KOw         = 10^10;    %K octanol water
%
LipidCont   = 0.03*BS.^0.04; %fraccion lipidica del organismo i, o alimento i-1 (pCH2,i)

%
ECI         = EfConvInv(A); %Asigna 1-Eficiencia de Conversion según corresponda
SS          = sum(ECI*diag(LipidCont),2);   %Vector de producto entre inverso de eficiencia 
                                            %y contenido lipidico en las presas
%
y1          = zeros(sizAV,1);%vector de ceros para food ingestion coefficient
y1(b)       = 0;
y1(nb)      = 0.005;


%% TASA DE INCORPORACION DE CONTAMINANTE DESDE EL AGUA 
%Este parametro se escala alometricamente de acuerdo a Hendriks et al. 2001
%(Substance absorption rate=L/kgád^-1)

W           =(BS.^(-0.25))./(rhoh2o0+(LLPR./KOw));  %Hendriks et al. 2001 Eq. 5 (se excluyo
                                      %el retraso impuesto por el flujo de agua porque estoy
                                      %pensando en un sistema acuatico)
                                      %El output es el vector W.                                          
W           = W*365.5;      %cambio de unidades a años 
                                          
%% TASA DE SALIDA DE CONTAMINANTE DESDE LOS ORGANISMOS 
%B3.1)EXCRECION CON EL AGUA
%(Substance excretion rate=d^-1)
AFLIPIDAQ   = (1./(LipidCont.*(KOw-1)+1));
EXCONT      = AFLIPIDAQ.*W;%Hendriks et al. 2001 Eq. 8

%B3.2)EXCRECION CON EL ALIMENTO
%(Substance egestion rate=d^-1)
EGCONT      = AFLIPIDAQ.*(BS.^(-0.25))./(rhoh2o1+(LLPR./KOw*q)+1./q*KOw.*SS.*y1);

rho         = (EXCONT+EGCONT)*365.5;%cambio de unidades a años     

end