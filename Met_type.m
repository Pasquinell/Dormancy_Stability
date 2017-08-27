function AC=Met_type(A,FIJO)
%%ACTUALIZADO 19/AGOSTOS/2013
%Modificado 6/04/2011 segun Broseetal2006-ademas TP parte de 0
%A=Matriz de Adyacencia
%FIJO=1 quiere decir que todas las especies tienen el mismo tipo
%metab�lico, por defecto invertebrados.
%FIJO=0 quiere decir que se asignan tipos metab�licos de acuerdo a la
%posici�n tr�fica
%Esta rutina asigna tipos metab�licos seg�n posici�n tr�fica diferenciando 
%unicelulares-vertebrados-invertebrados o asigna posici�nes tr�fica sin 
%asociaci�n con la posici�n tr�fica, diferenciando unicelulares (basales)
%de invertebrados (no basales). 

%AC = especieX[r ax ay]

global LH replicas

if FIJO==0

    %%%%%%%%ASIGNACI�N DE TIPOS METAB�LICOS DE ACUERDO A POSICI�N TR�FICA%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %La asignacion de tipos metab�licos permite asignar valores de las
    %constantes alom�tricas de acuerdo a Yodzis&Innes1992.
    %Supuestos:
    %La posicion tr�fica promedio de una especie se relaciona de forma lineal-positiva con nu 
    %(esto quiere decir que entre mayor sea la posicion tr�fica, mayor es la probabilidad nu) 
    %Para obtener una relacion entre posicion trofica (TP) y nu se genera una ecuaci�n de l
    %a recta a partir de los 2 puntos conocidos:
    %TPmax,nu=1 y TPmin=2,nu=0
    %Los tipos metabolicos considerados son: 
    %basales=>unicelulares
    %vertebrados=>P(nu)
    %invertebrados=>P(1-nu)

    %%%%%%%%%%%%%%%%Par�metros para relaci�n lineal entre %%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%posici�n tr�fica y la probabilidad de ser vertebrado%%%%%%%%%%%%%
    TP=TroPos(A);%Debe calcular las posiciones tr�ficas para asignar tipo metab�lico
    TPmax=max(TP);%la especie de mayor posicion trofica promedio tiene
    numax=1;%la maxima probabilidad nu=1 de ser vertebrado.
    TPmin=1;%la especie no-basal de menor posicion trofica promedio tiene
    numin=0;%la menor probabilidad nu=0 de ser vertebrado.
    mm=(numax-numin)/(TPmax-TPmin);%Pendiente de la relacion TP/nu
    nu=mm*(TP-TPmin)+numin;%Vector de probabilidades nu (valores de y, dada la ecuacion de la recta TP/nu)


    %%%%%%%%%%Asignaci�n de tipos metab�licos seg�n posici�n tr�fica%%%%%%%%%%%

    AC=zeros(length(TP),3);%Matriz de ceros en la que se colocaran segun el tipo metabolico
    %las constantes alometricas ax, ay, ar para cada especie (una fila por especie)
    aa=find(TP==0);%identifica especies basales=>unicelulares
    bb=find(TP>0);%identifica especies no basales=>vert(P(nu))/inv(P(1-nu))

    %Asignaci�n de coefiecientes alom�tricos asociados con el tipo metab�lico
    %Para UNICELULARES
    for k=1:length(aa)
        AC(aa(k),:)=[0 0 1];%Asigna constantes alometricas caraceristicas de 
                            %especies unicelulares para los parametros Tp,Jp Y Ri
    end
    %Para VERTEBRADOS ECTOTERMOS E INVERTEBRADOS
    for j=1:length(bb)
    r=rand;
    if r<nu(bb(j))
        AC(bb(j),:)=[0.88 4 0];%Asigna constantes alometricas caraceristicas 
                                  %de VERTEBRADOS para los parametros Tp,Jp Y Ri
    else
        AC(bb(j),:)=[0.314 8 0];%Asigna constantes alometricas caraceristicas 
                                %de INVERTEBRADOS para los parametros Tp,Jp Y Ri
    end
    end

elseif FIJO==1
    
    AC=zeros(size(A,1),3);%Matriz de ceros en la que se colocaran segun el 
                           %tipo metab�lico las constantes alometricas 
                           %Tp, Jp, Ri para cada especie (una fila por especie)
    
    aa=find(sum(A)'==0);%identifica especies basales=>unicelulares 
    bb=find(sum(A)'>0);%identifica especies no basales=>invertebrados (por defecto) 

    %Asignaci�n de coefiecientes alom�tricos asociados con el tipo metab�lico
    %Para UNICELULARES


    for k=1:length(aa)
        AC(aa(k),:)=[0 0 1];%Asigna constantes alometricas caraceristicas de 
                            %especies unicelulares para los parametros Tp,Jp Y Ri
    end
    %Para INVERTEBRADOS
    for j=1:length(bb)
        AC(bb(j),:)=[.314 8*.314 0];%Asigna constantes alometricas caraceristicas de 
                            %especies unicelulares para los parametros Tp,Jp Y Ri
    end
end

end