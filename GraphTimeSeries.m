function GraphTimeSeries(c,s,varBif,v1,v2,v3,EPD_Proportion,fenoRecA,fenoDormA,matrix, replica,spN) 


%EPD_Proportion = 0.5 ;
        %global LH

        DESDE=0;
        
        min = 20 ;
        max = 30 ;
        IntervalABund   =   min*52.18:(max*52.18);
        IntervalFlux    =   min*52.18:(max*52.18);
        
        IntervalABund   =   floor(IntervalABund);
        IntervalFlux    =   floor(IntervalFlux);
        
    
        
        % carga todas las matrices del struct "ST". Se accede a cada unop
        % como ST.to_plotAdults, etc.
        load(sprintf('series/s_C%3.2f_S%d_varBif%g_v1%d_v2%d_v3%d_epdp%3.2f_FR%d_FD%d_matrix%d_r%d.mat',c,s,varBif,v1,v2,v3,EPD_Proportion,fenoRecA,fenoDormA,matrix, replica));
                    %         seriesD     = load(sprintf('series/sD_C%s_S%d_REP%g_CON1_M0_NM0_I30_r%d_v1%d_v2%d_v3%d.mat',num2str(c),s,varBif, replicas,v1,v2,v3));
%         seriesFlux  = load(sprintf('series/sF_C%s_S%d_REP%g_CON1_M0_NM0_I30_r%d_v1%d_v2%d_v3%d.mat',num2str(c),s,varBif, replicas,v1,v2,v3));
        
 %% TO DO: hacer el cambio al nuevo struct, de ser necesario.   
%         A1=series.to_plotAdults(1,IntervalABund);
%         D1=seriesD.to_plotDormants(1,IntervalABund);
%         A2=series.to_plotAdults(2,IntervalABund);
%         D2=seriesD.to_plotDormants(2,IntervalABund);
% 
%         Self_Basals1    =       seriesFlux.to_plotFlujos(1,IntervalFlux);
%         Self_Basals2    =       seriesFlux.to_plotFlujos(2,IntervalFlux);
%         Outp_Basals     =       seriesFlux.to_plotFlujos(3,IntervalFlux);    
%         Self_Consumers  =       seriesFlux.to_plotFlujos(4,IntervalFlux);
%         Dead_Consumers  =       seriesFlux.to_plotFlujos(5,IntervalFlux);
%         Consume_Out     =       seriesFlux.to_plotFlujos(6,IntervalFlux);
%         Consume_In      =       seriesFlux.to_plotFlujos(7,IntervalFlux);
        
        
%         DESFf=decoupling;
%         a = [spulse(2*((IntervalABund)./52.18-0+.01-floor((IntervalABund)./52.18-0+.01)),16); ...
%             spulse(2*((IntervalABund)./52.18-DESFf+.01-floor((IntervalABund)./52.18-DESFf+.01)),16)];
%         t=IntervalFlux;
%         min_wp = 0;
%         max_wp = 1;
%         winter_punish=  (max_wp-min_wp)*(cos(t/52.18*2*pi-17/52.18*2*pi)*1/2+1/2)+min_wp;


        
        %series.to_plotAdults=[A1;A2];
        %seriesD.to_plotDormants=[D1;D2];
  %%      
        %spN = 1 ; 
        figure
        plot(IntervalABund/52.18,ST.to_plotAdults(spN,IntervalABund),IntervalABund/52.18,ST.to_plotDormants(spN,IntervalABund))
        legend('Active','Dormant') %,'Dormant Algae', 'Dormant Rotifer')
        xlabel('Time(years)') ;
        ylabel('AdultState') ;
        %size(IntervalABund)
        %size(series.to_plotAdults)
        %[IntervalABund',to_plotAdults',IntervalABund,to_plotDormants]
        %assignin('base', 'print_series', [IntervalABund' series.to_plotAdults' seriesD.to_plotDormants'])
        
%         figure
%         plot(IntervalFlux,Self_Basals1,'b',IntervalFlux,Self_Basals2,'.-',IntervalFlux,Outp_Basals,IntervalFlux,Self_Consumers,IntervalFlux,Dead_Consumers,IntervalFlux,Consume_Out,IntervalFlux,Consume_In)
%         legend('Self Basal Parthenog','Self Basal Recruit','Outp. Basal','Self Consumer', 'Dead Consumer', 'Consumer Out', 'Consumer In')
%         xlabel('Time(Weeks)') ;
%         ylabel('Flux') ;
        
        
%         figure
%         plot(IntervalFlux, winter_punish(:), IntervalABund,a(1,:),IntervalABund, a(2,:))
%         legend('Temperature', 'Basal Recruitment', 'Consumer Recruitment')
%         xlabel('Time(Weeks)') ;
%         ylabel('Phenologies') ;
end

