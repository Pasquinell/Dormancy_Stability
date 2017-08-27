function gr()

fd = fopen('lista.txt','r');

fig = 1;
while ~feof(fd)

    line = strtrim(fgets(fd));  
    
    indice = line(1:4);
    R = line(:,21:22);
    
    L=load(line);
    
    n=str2double(R);
    
    Tmaximo = max(L(:,1));
    
    bud = sprintf('GR');
    sw=0; 
    if Tmaximo<30000
        bud = sprintf('XXXXX');
        sw=1; 
    end
    
    fprintf(sprintf('Generando grafico para %s\n',line));
    
    figure(fig)
    plot (L(:,1),L(:,2:n+1));
    title('TOXICO');
    xlabel('TIEMPO');
    ylabel('BIOMASA');

    if sw==0
        filename=sprintf('Result/%s_%s_BIOMASA.fig',indice, bud);
    else   
        filename=sprintf('Result/ANOMALOS/%s_%s_BIOMASA.fig',indice, bud);
    end    
    saveas(fig,filename); 
    clf(fig);
    close;

    figure(fig)
    plot (L(:,1),L(:,n+2:2*n+1));
    title('TOXICO');
    xlabel('TIEMPO');
    ylabel('CONTAMINANTE ACUMULADO');

    if sw==0 
        filename=sprintf('Result/%s_%s_CONTACUM.fig',indice,bud);
    else
        filename=sprintf('Result/ANOMALOS/%s_%s_CONTACUM.fig',indice,bud);
    end
    saveas(fig,filename); 
    clf(fig);
    close;
    
    figure(fig)
    plot (L(:,1),L(:,2*n+2));
    title('TOXICO');
    xlabel('TIEMPO');
    ylabel('CONTAMINANTE AGUA');

    if sw==0
        filename=sprintf('Result/%s_%s_CONTAGUA.fig',indice, bud);
    else    
        filename=sprintf('Result/ANOMALOS/%s_%s_CONTAGUA.fig',indice, bud);
    end
    saveas(fig,filename); 
    clf(fig);
    close;

    figure(fig)
    plot (L(:,1),L(:,2*n+3:end));
    title('TOXICO');
    xlabel('TIEMPO');
    ylabel('DEFENSAS');

    if sw==0
        filename=sprintf('Result/%s_%s_DEFENSAS.fig',indice, bud);
    else
        filename=sprintf('Result/ANOMALOS/%s_%s_DEFENSAS.fig',indice, bud);
    end
    saveas(fig,filename); 
    clf(fig);
    close;
    
end

fclose(fd);

end