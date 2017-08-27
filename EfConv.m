function EC=EfConv(A)
%ACTUALIZADO 14/AGOSTO/2013
%A=MATRIZ DE ADYACENCIA
%Leslie Garay-Narvaez
%Modificado 06-04-2011 TP parte de 0

%%%%%ONSERVACIONES: Cuando la matriz es aleatoria (E-R model) puede ser que no
%%%%%encuentre ninguna especie basal, en este caso serán todos no basales y 
%%%%%como no puede haber consumo de basales, serán todos carnívoros

b       = sum(A)'==0;      %indica basales en un vector de ceros de S,1
nb      = sum(A)'>0;       %indica no basales en un vector de ceros de S,1

%EFICIENCIA DE CONVERCIÓN: Valores tomados de Yodzis e Innes 1992
Herb    = (diag(b)*(1/0.45)*A)';    %la diagonalizacion me permite multiplicar 
                           %el valor 1/0.45 por las filas correspondientes 
                           %a las especies basales
                           
Carn    = (diag(nb)*(1/0.85)*A)';%la diagonalizacion me permite multiplicar 
                            %el valor 1/0.85 por las filas correspondientes 
                            %a las especies No-basales
EC      = Herb+Carn;        %Output, una matriz con EL INVERSO de todas las
                            %eficiencias de consumo
end