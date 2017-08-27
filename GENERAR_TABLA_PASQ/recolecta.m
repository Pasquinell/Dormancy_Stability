function recolecta(C,S,matrix,replica)
%% recolecta los datos y promedios de las matrices creadas con medidas de grafos

% [.1 .15 .2 .25 0.3],[20 40 60 80 100],1:30
Data=[];

             
            file=sprintf('/home/pasqui/6.00.00_G_STUARDO/v11_2015_02_15_ClusterDL/series_varBif0/grafos_RED_TODA/GR_C%3.2f_S%d_matrix%d_r%d.mat',C,S,matrix,replica);
            load(file);
            
            % grado
            DEG      = stg_fun.degree_similarity.st_degree.xgrado_bu;
            DEG_E    = stg_fun.degree_similarity.st_degree.xgrado_bu_epd;
            % assortativity
            ASS      = stg_fun.assortativity.st_assortativity.ACbu;
            % Community Clustering
            CLCOEF   = stg_fun.cluster_comm_struct.st_clustering_coef.xccbu;
            CLCOEF_E = stg_fun.cluster_comm_struct.st_clustering_coef.xccbu_epd;
            TRANS    = stg_fun.cluster_comm_struct.st_transitivity.Tbu;
            EFGLO    = stg_fun.cluster_comm_struct.st_efficiency.Eglob_bu;
            EFLOC    = stg_fun.cluster_comm_struct.st_efficiency.xEloc_bu;
            EFLOC_E  = stg_fun.cluster_comm_struct.st_efficiency.xEloc_bu_epd;
            MOD      = stg_fun.cluster_comm_struct.st_modularity_uNewman.xCSbu;
            MOD_E    = stg_fun.cluster_comm_struct.st_modularity_uNewman.xCSbu_epd;
            % Path distances: characteristic path lengthtgh
            CPL      = stg_fun.path_distances.st_charpathb.lambdabu;
            % Centrality
            BETW      = stg_fun.centrality.st_betweenness_cen.xBCbu;
            BETW_E    = stg_fun.centrality.st_betweenness_cen.xBCbu_epd;
            MODEZSC   = stg_fun.centrality.st_module_degree_zscore.xZbu;
            MODEZSC_E = stg_fun.centrality.st_module_degree_zscore.xZbu_epd;
            COPART    = stg_fun.centrality.st_participation_coef.xPbu;
            COPART_E  = stg_fun.centrality.st_participation_coef.xPbu_epd;
            % Eigen Vector Centrality:
            EVC       = stg_fun.centrality.st_eigenvector_centrality.xvbu;
            EVC_E     = stg_fun.centrality.st_eigenvector_centrality.xvbu_epd; 
            TP        = stg_fun.st_datos.TP;
            TP_E      = stg_fun.st_datos.TP_EPD;
            
%            linea = sprintf('%1.2f %d %d %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f',...
%                            C,S,R,DEG,DEG_E,ASS,CLCOEF,CLCOEF_E,TRANS,EFGLO,EFLOC,EFLOC_E,MOD,MOD_E,...
%                            CPL,BETW,BETW_E,MODEZSC,MODEZSC_E,COPART,COPART_E);
            
            Data = [       DEG DEG_E ASS CLCOEF CLCOEF_E ...
                           TRANS EFGLO EFLOC EFLOC_E MOD MOD_E CPL BETW BETW_E ...
                           MODEZSC MODEZSC_E COPART COPART_E EVC EVC_E TP TP_E];

            save(sprintf('/home/pasqui/6.00.00_G_STUARDO/v11_2015_02_15_ClusterDL/series_varBif0/Data_ofMatrix/DoM_C%3.2f_S%d_matrix%d_r%d.mat',C,S,matrix,replica),'Data')



end
