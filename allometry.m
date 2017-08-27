function [T E_Jmax R]=allometry(A,BS,FIJO)
%ACTUALIZADO 15/OCTUBRE/2013
%A=Matriz de Adyacencia
%FIJO=1 quiere decir que todas las especies tienen el mismo tipo
%metab�lico, por defecto invertebrados.
%FIJO=0 quiere decir que se asignan tipos metab�licos de acuerdo a la
%posici�n tr�fica
%BS=tama�os corporales
%ESTA RUTINA GENERA PARAMETROS ESCALADOS ALOM�TRICAMENTE EN MODELO
%BIOENERG�TICO
%T=TASA METAB�LICA MASA ESPEC�FICA. 
%E*JMAX=TASA DE M�XIMO CONSUMO ESCALADA POR LA TASA METAB�LICA
%R=TASA DE M�XIMA PRODUCCI�N.


%CONSTANTES ALOM�TRICAS SEG�N TIPOS METABOLICOS:
%Rutina que asigna constantes alometricas a cada especie
 AC     = Met_type(A,FIJO);
 aT     = AC(:,1);      %Constante alom�trica para tasa metab�lica masa espec�fica
 aJ     = AC(:,2);      %Constante alom�trica para tasa de m�ximo consumo 
 aR     = AC(:,3);      %Constante alom�trica para tasa de producci�n
 
%PARAMETROS QUE SE ESCALAN ALOMETRICAMENTE EN MODELO BIOENERG�TICO.
T       = aT.*BS.^(-0.25);% Ti(tasa de respiracion masa especifica)
E_Jmax  = aJ.*BS.^(-0.25);% Jp(tasa de consumo asint�tico de la presa j)
R       = aR.*BS.^(-0.25);% Ri (razon intrinseca Produccion/Biomasa)

end