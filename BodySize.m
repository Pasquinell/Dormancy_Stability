function BS=BodySize(A,ratio,VBS,RAND)
%ACTUALIZADO 14/AGOSTO/2013
%A=Matriz de adyacencia
%ratio=razon de tama�o corporal depredador presa
%VBS=Variaci�n en el tama�o corporal
%RAND=Tama�os asignados al azar(1) o asignados seg�n posici�n tr�fica(0)

%Leslie Garay-Narv�ez
%20/10/10
%Modificado 6/04/11 segun Brose et al. 2006 ecol. let.
%TAMA�OS CORPORALES (kg):
%Para cada especie de la red se obtiene el tama�o corporal 

%%%%%Esta rutina permite asignar tama�os aleatorios o no aleatorios a las
%%%%%especies de la red


%%%%%%%%%%%%%Asignaci�n NO aleatoria%%%%%%%%%%%%%%

if RAND==0%asignaci�n NO aleatoria de tama�os corporales
    
    %%Asignaci�n de tama�o corporal a partir de posici�n tr�fica (TP)
    size(A)
    TP          = TroPos(A);
    p_pratio    = 10^ratio;     % Raz�n de tama�o corporal depredador-presa 
    mbasal      = 3.7*10^(-5);  % Asumiendo un di�metro esf�rico equivalente igual a 100 micrometros (correspondiente a 
                                % phytoplankton de red),
                                % densidad espec�fica igual a 1 . Conversi�n de masa h�meda a carbono de
                                % 0.07 (Moloney & Field 1991, Journal of plankton research, 13.p:1003)
    %mbasal=10^0;%masa recurso basal=1
    BS          = (p_pratio.^TP).*mbasal;
                                %Se puede incorporar cierta variaci�n a los tama�os de las especies 
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


