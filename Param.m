function P=Param(G,Cont,A,ratio,VBS,RAND,FIJO)
%ACTUALIZADO 19/AGOSTO/2013
%Leslie Garay-Narva�ez
%%Modificaci�n 5/04/11segun Broseetal2006-TP parte de cero
%A=matriz de adjacencia.
%G=sensibilidad al contaminante.
%C=concentraci�n de contaminante en el medio.
%r=raz�n de tama�o corporal dep-presa.
%VBS=variabilidad en los tama�os corporales.
%RAND=indica si los tama�os corporales se asignan de forma aleatoria o no 
%(i.e. de acuerdo a posisic�n tr�fica). (0/1)
%FIJO=indica si los tipos metab�licos son fijos o se asignan de acuerdo a las
%posiciones tr�ficas.(0/1)

%global replicas_aux
S               = size(A,1);

%I.-PARAMETROS ASOCIADOS A LA DINAMICA DE LA BIOMASA

%BODY SIZE
%Rutina que calcula los tama�os corporales para cada especie
BS              = BodySize(A,ratio,VBS,RAND);


%PARAMETROS ALOM�TRICOS MODELO BIOENERG�TICO
[T E_Jmax R]    = allometry(A,BS,FIJO);


%MATRIZ DE EFICIENCIAS DE CONVERCI�N
EC              = EfConv(A);%es realmente 1/E


%PREFERENCIA 
alpha           = Preferencia(A);%Vector con valores de preferencia se divide 
                      %1 por el nro de presas

%EXPONENTE RESPUESTA FUNCIONAL
teta            = 2;

%BETA-HALF SATURATION CONSTANT
%Se asume por ahora mi=0 para todas las especies
Beta            = ones(S,1)*0.1;%0.1; % valores de constante de saturaci�n media.
                                      % se cambi� el 26Dic2013 para calzar con 
                                      % las unidades

%CAPACIDAD DE CARGA ASUMIENDO QUE K SE REPARTE EQUITATIVAMENTE ENTRE TODOS LOS
%PRODUCTORES
k               = 20 ; %.5;%Prod uctividad total del sistema

K               = CarrCap(A,k);

%VECTOR DE UNOS ASOCIADO A CRECIMIENTO LOG�STICO R*X(1-X/K)
ONES            = sum(A)'==0;%identifica especies basales 

% EFECTO DEL CONTAMINANTE
bet             = -1*ones(S,1);
Gam             = G*ones(S,1);



%II.-PARAMETROS ASOCIADOS A LA DINAMICA DEL CONTAMINANTE BIOACUMULADO

%TASA DE INCORPORACION DE CONTAMINANTE DESDE EL AGUA (W) Y SALIDA DE CONTAMINANTE 
%DESDE LOS ORGANISMOS (rho)
[Omega Phi]     = BIOAC(A,BS);%Ambos parametros se escalan alometricamente segun 
                              %Hendriks et al. 2001
                                                              

%III.-PARAMETROS ASOCIADOS A LA DINAMICA DEL CONTAMINANTE EN EL AMBIENTE

%FRACCION DEL CONTAMINANTE EXCRETADO O EGESTADO QUE VUELVE DE FORMA ACTIVA 
%AL AGUA. Se asume que vuleve el 100% de forma activa
ContAct         = 1.*ones(S,1);


%FUNCION DE PRODUCCION ANTR�PICA DE CONTAMINANTE
%C cantidad de contaminante
s               = 100000; %s  abruptez
m               = 500; %M  cuando es el primer pulso


%BIODEGRADACI�N
psi             = 0.0001; %biodegradation

%Normalizing by time=1/R we get
%Selecting R from vector of R values

R2              = 1 ;
%R2=max(R);%En este caso sabemos que todos los productores primerios tienen 
          %valor de R=1 por lo tanto simplemente del vector escogimos el m�
          %ximo.
Y               = zeros(S,1);
nb              = find(R==0);%Identificando basales

          
X               = T/(R2*52.18); %Los siguientes 3 par�metros est�n divididos por 52.18
%para que quede en semanas [Dic27/2013]
Y(nb)           = E_Jmax(nb)./(T(nb)*52.18);
%E_Jmax es J*epsilon (por eso despues en las ecuaciones se divide por)
r               = R/(R2*52.18);
OMEGA           = Omega/R2;
PHI             = Phi/R2;%Recordar que rho fue re bautizado como phi.
sigma           = s*R2;
M               = m*R2;
PSI             = psi/R2;


P               = struct('BS',BS,'T',T,'E_Jmax',E_Jmax,'R',R,'EC',EC,'alpha',alpha,'teta',teta,'Beta',Beta,...
                         'K',K,'ONES',ONES,'bet',bet,'Gam',Gam,...
                         'Omega',OMEGA,'PHI',PHI,... 
                         'ContAct',ContAct,'C',Cont,'sigma',sigma,'M',M,'psi',PSI);
         
% Las salidas de param tienen que ver con el modelo dinamico aparte de la
% dormancia. Ej: tasas metab�licas, de crecimiento, exponente de la
% respuesta funcional. Adem�s salen muchas variables que tienen que ver con
% el contaminante. 

%Nota: P.sigma nunca se ocupa en el programa y no tiene nada que ver con el
%PD.sigma, que es de la parte de la dormancia del modelo.

%Nota: creo que lo �nico que ocupa es 'T',T,'E_Jmax',E_Jmax,'R',R,'EC',EC,'alpha',alpha,'teta',teta,'Beta',Beta,...
         %'K',K,'ONES',ONES
end



