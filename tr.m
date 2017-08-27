function tr()
% indicar T0 para iniciar analisis de transiente

fg = fopen('TlstNoEstable.txt','w');
fclose(fg);

fd = fopen('lista.txt','r');

while ~feof(fd)

    line = strtrim(fgets(fd));  

    fp = fopen('TAnomalo/Tlista.txt','r');
    sw=0;
    while ~feof(fp)
       line1 = strtrim(fgets(fp));
       if (strcmp(line,line1)==1)
          sw=1;
       end  
    end   
    fclose(fp); 

    if sw==0   % calcula transiente:
       L=load(line);
       Tmax = size(L,1);   % tiempo total
       R = str2double(line(:,21:22));    % riqueza
       
       LINA = line
       
       swtr=0;
       for ESPECIE=2:R+1
          
           ESP = ESPECIE 
          
          if sum(L(end-2:end,ESPECIE)) > 0  %% no está extinta
             % obtener rango de tiempo a evaluar:
             Tpunto = Tmax - randperm(Tmax - (Tmax - ceil(Tmax*.05)),1)  
             TpuntoCtrl1 = Tmax - randperm(Tmax - (Tmax - ceil(Tmax*.025)),1)
             TpuntoCtrl2 = Tmax - randperm(Tmax - (Tmax - ceil(Tmax*.005)),1)
             
             if L(Tpunto,ESPECIE) ~= L(Tpunto-1,ESPECIE)
                 if L(TpuntoCtrl1,ESPECIE) ~= L(TpuntoCtrl1-1,ESPECIE)
                     swtr=1;
%                      if L(TpuntoCtrl2,ESPECIE) ~= L(TpuntoCtrl2-1,ESPECIE)
%                         swtr=1;  
%                      end   
                 end   
             end
          end
       end
       if swtr==0
           fg = fopen('TlstNoEstable.txt','a');
           fprintf(fg,'%s\n',line);
           fclose(fg);
       end
    end
end
    
fclose(fd);

end
