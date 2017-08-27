function BS=BodySize(A,ratio,VBS,RAND)
%ACTUALIZADO 14/AGOSTO/2013
%A=Matriz de adyacencia
%ratio=razon de tamaño corporal depredador presa
%VBS=Variación en el tamaño corporal
%RAND=Tamaños asignados al azar(1) o asignados según posición trófica(0)

%Leslie Garay-Narv‡ez
%20/10/10
%Modificado 6/04/11 segun Brose et al. 2006 ecol. let.
%TAMAÑOS CORPORALES (kg):
%Para cada especie de la red se obtiene el tamaño corporal 

%%%%%Esta rutina permite asignar tamaños aleatorios o no aleatorios a las
%%%%%especies de la red


%%%%%%%%%%%%%Asignación NO aleatoria%%%%%%%%%%%%%%

if RAND==0%asignación NO aleatoria de tamaños corporales
    
    %%Asignación de tamaño corporal a partir de posición trófica (TP)
    size(A)
    TP          = TroPos(A);
    p_pratio    = 10^ratio;     % Razón de tamaño corporal depredador-presa 
    mbasal      = 3.7*10^(-5);  % Asumiendo un diámetro esférico equivalente igual a 100 micrometros (correspondiente a 
                                % phytoplankton de red),
                                % densidad específica igual a 1 . Conversión de masa húmeda a carbono de
                                % 0.07 (Moloney & Field 1991, Journal of plankton research, 13.p:1003)
    %mbasal=10^0;%masa recurso basal=1
    BS          = (p_pratio.^TP).*mbasal;
                                %Se puede incorporar cierta variación a los tamaños de las especies 
                                %no basales obtenido a partir de TP
    
    BSmin       = BS-VBS.*BS;   %cuando VBS=0 BSmin=BS=BSmax
    BSmax       = BS+VBS.*BS;
    nb          = find(sum(A)');%Identifica especies no basales
    BS(nb)      = random('unif',BSmin(nb),BSmax(nb));
    
elseif RAND==1
    S           = size(A,1);
    min         = 1;
    max         = 10^3;
    BS          = random('unif',min,max,S,1);
end

end


