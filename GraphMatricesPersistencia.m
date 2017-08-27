function GraphMatricesPersistencia(varBif,v1,v2,v3,EPDP,fenoRecA,fenoDormA)

ET = 0.00001 ;

CONECTANCIES = [.1 .15 .2 .25 .3];%[ .1 .125 .15 .175 .2 .225 .25 .275 .3 ];
RICHNESS = [20 40 60 80 100];%[20 30 40 50 60 70 80 90];

PERSIST_MAT = NaN(size(CONECTANCIES,2),size(RICHNESS,2));
VAR_PERSIST_MAT = NaN(size(CONECTANCIES,2),size(RICHNESS,2));
SHANNON_MAT = NaN(size(CONECTANCIES,2),size(RICHNESS,2));

EPD_Proportion = EPDP ;

indice_c = 0;
for c= CONECTANCIES
    indice_s = 0;
    indice_c = indice_c + 1;
    persist = [];
    shannon = [];
    for s= RICHNESS
        indice_s = indice_s+1;
        
        for matrix = 1:15
            for replicas=1:1
                %series = sprintf('series_C%s_S%d_REP%d_CON0_M0_NM0_I30',num2str(c),s,rep);
                load(sprintf('series/s_C%3.2f_S%d_varBif%g_v1%d_v2%d_v3%d_epdp%3.2f_FR%d_FD%d_matrix%d_r%d.mat',c,s,varBif,v1,v2,v3,EPD_Proportion,fenoRecA,fenoDormA,matrix, replica));
                %             seriesD     = load(sprintf('series/sD_C%s_S%d_REP%g_CON1_M0_NM0_I30_r%d_v1%d_v2%d_v3%d.mat',num2str(c),s,varBif, replicas,v1,v2,v3));
                %             seriesFlux  = load(sprintf('series/sF_C%s_S%d_REP%g_CON1_M0_NM0_I30_r%d_v1%d_v2%d_v3%d.mat',num2str(c),s,varBif, replicas,v1,v2,v3));
                
                %series = load(series);
                
                
                persist = [persist (sum(ST.to_plotAdults(:,end)>ET)/s)];
                
                post_transiente = mean(ST.to_plotAdults(:,end-52:end),2);
                for_shannon =(post_transiente/sum(post_transiente,1)).*log2((post_transiente/sum(post_transiente,1)));
                sum_shannon= -sum(for_shannon(for_shannon<0),1)/log2(s);
                shannon = [shannon sum_shannon];
                
                %             if c==.15 & s==60
                %             post_transiente
                %             log2((post_transiente/sum(post_transiente,1)))
                %             shannon
                %
                %             end
            end
        end
%          EPD_identity = sprintf('EPD_identity_save_C%s_S%d_CON0_M0_NM0_I30',num2str(c),s,rep);
%             EPD_identity = load(EPD_identity);
%             
            
        PERSIST_MAT(indice_c, indice_s) = mean(persist);
        VAR_PERSIST_MAT(indice_c, indice_s) = std(persist)/mean(persist);
        SHANNON_MAT(indice_c, indice_s) = mean(shannon);
    end
    
    
end




dlmwrite(sprintf('PERSIST_Y_SHANNON_MAT/PERSIST_MAT_EPD%3.2f',EPD_Proportion), PERSIST_MAT)

dlmwrite(sprintf('PERSIST_Y_SHANNON_MAT/SHANNON_MAT_EPD%3.2f',EPD_Proportion), SHANNON_MAT)

end
% climsP = [.15 .6];
% %climsVP = [0 1];
% climsS = [.4 .7];
% 
% 
% figure
% colormap(gray);
% imagesc(PERSIST_MAT, climsP);
% set(gca,'YDir','normal')
% % figure
% % colormap(gray);
% % imagesc(VAR_PERSIST_MAT,climsVP);
% % set(gca,'YDir','normal')
% figure
% colormap(gray);
% imagesc(SHANNON_MAT,climsS);
% set(gca,'YDir','normal')


