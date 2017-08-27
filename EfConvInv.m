function ECI=EfConvInv(A)
%%%%ACTUALIZADO Y CORREGIDO 
%%%%14/AGOSTO/13
%A=MATRIZ DE ADYACENCIA
%Leslie Garay-Narvaez
%Modificado 10-08-2011 TP parte de 0
%Es llamada por BIOAC
%lo que hace es asignar valores 1-E en lugar de E
%%%%%Ojo: Cuando la matriz es aleatoria (E-R model) puede ser que no
%%%%%encuentre ninguna especie basal, en este caso serán todos no basales y 
%%%%%como no puede haber consumo de basales, serán todos carnívoros


b=sum(A)'==0;%identifica especies basales dentro de un vector de dimensión S,1
nb=sum(A)'>0;%identifica especies no basales dentro de un vector de dimensión S,1


%EFICIENCIA DE CONVERCIÓ”N: Valores tomados de Yodzis e Innes 1992
Herb=(diag(b)*(0.55)*A)';%la diagonalizacion me permite multiplicar el valor 
                         %(1-0.45)=0.55 por las filas correspondientes a las especies basales
Carn=(diag(nb)*(0.15)*A)';%la diagonalizacion me permite multiplicar el valor 
                          %(1-0.85)=0.15 por las filas correspondientes a las especies No-basales
ECI=Herb+Carn;%Output, una matriz con todas las eficiencias de consumo
end