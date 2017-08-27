function TP=TroPos(Na)
% Leslie Garay-Narvaez & Jose D. Flores.
% February 28, 2011
% Algorithm S.Levine(1980) 

%Deleting self effects (Loops)

V=diag(Na);
M=diag(V,0);
Mat=Na-M;

%Vector TP
TP=zeros(size(Mat,1),1);%Vector de ceros (vector x en algoritmo de Levine)


ss=sum(Mat);%Suma columnas de matriz de adyacencia, entregando cantidad de 
            %presas por nodo =In_degree.
            
s=find(ss);%Identifica las especies no basales

T1=Mat(:,s);%Saca la submatriz de interacciones entre
            %no basales y basales (cuadrante superior, equivale a matriz R 
            %de Levine)+ la submatriz de las interacciones 
            %entre especies no basales (cuadrante inferior, equivale a 
            %matriz Q de Levine)
             
D=diag(1./ss(s));%Divide la energía por la cantidad de presas de cada 
                 %especie y así da peso a los links
                 
T2=T1*D;%Con este calculo de peso a los links dependiendo de la cantidad de
        %presas
Q=T2(s,:)';%Se recupera la matriz Q de Levine que contiene las interacciones
           %entre las especies no basales como matriz de
           %transición(=adyacencia transpuesta)
L=ones(max(size(Q)),1);%Vector de unos que viene del supuesto de Levine que 
                       %dice que, se espera que la posición trófica
                       %promedio sea 1+ que la posición trófica de sus 
                       %recursos, recordar que se asume que las basales 
                       %tienen posición trófica=0 
y=(eye(size(Q))-Q)\L;%Se calcula las posición trófica según ecuación 4-5 en
                     %Levine
TP(s)=y;%Se junta posición trófica para basales y no basales

end
