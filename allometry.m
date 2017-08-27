function [T E_Jmax R]=allometry(A,BS,FIJO)
%ACTUALIZADO 15/OCTUBRE/2013
%A=Matriz de Adyacencia
%FIJO=1 quiere decir que todas las especies tienen el mismo tipo
%metabólico, por defecto invertebrados.
%FIJO=0 quiere decir que se asignan tipos metabólicos de acuerdo a la
%posición trófica
%BS=tamaños corporales
%ESTA RUTINA GENERA PARAMETROS ESCALADOS ALOMÉTRICAMENTE EN MODELO
%BIOENERGÉTICO
%T=TASA METABÓLICA MASA ESPECÍFICA. 
%E*JMAX=TASA DE MÁXIMO CONSUMO ESCALADA POR LA TASA METABÓLICA
%R=TASA DE MÁXIMA PRODUCCIÓN.


%CONSTANTES ALOMÉTRICAS SEGÚN TIPOS METABOLICOS:
%Rutina que asigna constantes alometricas a cada especie
 AC     = Met_type(A,FIJO);
 aT     = AC(:,1);      %Constante alométrica para tasa metabólica masa específica
 aJ     = AC(:,2);      %Constante alométrica para tasa de máximo consumo 
 aR     = AC(:,3);      %Constante alométrica para tasa de producción
 
%PARAMETROS QUE SE ESCALAN ALOMETRICAMENTE EN MODELO BIOENERGÉTICO.
T       = aT.*BS.^(-0.25);% Ti(tasa de respiracion masa especifica)
E_Jmax  = aJ.*BS.^(-0.25);% Jp(tasa de consumo asintótico de la presa j)
R       = aR.*BS.^(-0.25);% Ri (razon intrinseca Produccion/Biomasa)

end