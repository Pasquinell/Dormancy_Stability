function K=CarrCap(A,k)

basal   = sum(A)'==0;       %vector que indica basales
np      = sum(sum(A)==0);   %cantidad de basales 
K2      = k/np;             %productividad dividida por la cantidad de productores
K       = basal*1/K2;       %Vector final de largo S. Contiene los valores 1/K2 en las 
                            %posiciones correspondientes a las especies basales y 0 en las
                            %no basales
end