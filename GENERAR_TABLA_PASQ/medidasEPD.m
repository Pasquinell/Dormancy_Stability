function medidasEPD(CON, RICH, matrix, replica, FUN, vEPD)
%% calculo de las medidas para cada matriz para replica.
%
%  medidas(CON, RICH, REP, FUN, EPD)
%  ejemplo: medidas([0.1 0.15], [20 40], 15, 0)
%
%  Si REP=0, genera un struct con todas las ayudas de las funciones,
%  y lo guarda en el archivo:
%                   grafos/hlp_fun_grafos.mat
%
%  Si REP>0, genera para replica indicada. REP puede ser secuencia.
%
%  Si FUN=0, genera resultados todas las funciones.
%
%  Si FUN>0, genera resultado para una funcion, indicada por el
%            indice FUN. FUN puede ser secuencia 1:n
%
%  Indice para FUN (funciones):
%  1  = degrees                 15 = Characteristic path length, global
%  2  = assortativity                efficiency, eccentricity, radius,
%  3  = Joint degree                 diameter
%  4  = Neighborhood overlap    16 = Cycle probability*
%  5  = Matching index          17 = Betweenness centrality
%  6  = Density                 18 = Edge betweenness centrality
%  7  = Clustering coefficient  19 = Within-module degree z-score
%  8  = Transitivity            20 = Participation coefficient
%  9  = Local efficiency        21 = Eigenvector centrality
%  10 = Connected components    22 = Subgraph centrality
%  11 = Community structure and 23 = K-coreness centrality
%       modularity              24 = Flow coefficient
%  12 = Paths and walks         25 = Shortcuts
%  13 = Distance and characte-  26 = Rich Club Coefficient
%       ristic path length      27 = k_core 
%  14 = Global efficiency
%.
if FUN==0
    FUN     = 1:27;   % poner total de funciones existentes
end
REP = 1 ;    
if REP==0   % solo llama a help de funciones
    
    for index = FUN
        switch index
            case 1,
                t11 = help('degrees_und')
                t12 = help('degrees_dir')
            case 2,
                t21 = help('assortativity_bin')
                t22 = help('assortativity_wei')
            case 3,
                t31 = help('jdegree')
            case 4,
                t41 = help('edge_nei_overlap_bu')
                t42 = help('edge_nei_overlap_bd')
            case 5,
                t51 = help('matching_ind_und')
                t52 = help('matching_ind')
            case 6,
                t61 = help('density_und')
                t62 = help('density_dir')
            case 7,
                t71 = help('clustering_coef_bu')
                t72 = help('clustering_coef_bd')
                t73 = help ('clustering_coef_wu')
                t74 = help ('clustering_coef_wd')
            case 8,
                t81 = help('transitivity_bu')
                t82 = help('transitivity_bd')
                t83 = help('transitivity_wu')
                t84 = help('transitivity_wd')
            case 9,
                t91 = help('efficiency_bin')
                t92 = help('efficiency_wei')
            case 10,
                t101 = help('get_components')
            case 11,
                t111 = help('modularity_und')
                t112 = help('modularity_dir')
                t113 = help('modularity_louvain_und')
                t114 = help('modularity_louvain_dir')
                t115 = help('modularity_finetune_und')
                t116 = help('modularity_finetune_dir')
            case 12,
                t121 = help('findpaths')
                t122 = help('findwalks')
            case 13,
                t131 = help('distance_bin')
                t132 = help('reachdist')
                t133 = help('breadthdist')
                t134 = help('distance_wei')
            case 14,
                t141 = help('efficiency_bin')
                t142 = help('efficiency_wei')
            case 15,
                t151 = help('charpath')
            case 16,
                t161 = help('cycprob')
            case 17,
                t171 = help('betweenness_bin')
                t172 = help('betweenness_wei')
            case 18,
                t181 = help('edge_betweenness_bin')
                t182 = help('edge_betweenness_wei')
            case 19,
                t191 = help('module_degree_zscore')
            case 20,
                t201 = help('participation_coef')
            case 21,
                t211 = help('eigenvector_centrality_und')
            case 22,
                t221 = help('subgraph_centrality')
            case 23,
                t231 = help('kcoreness_centrality_bu')
                t232 = help('kcoreness_centrality_bd')
            case 24,
                t241 = help('flow_coef_bd')
            case 25,
                t251 = help('erange')
            case 26,
                t261 = help('rich_club_bu')
                t262 = help('rich_club_bd')
            case 27,
                t271 = help('kcore_bu')
                t272 = help('kcore_bd')
        end
    end
    
else
    for CONECTANCIES=CON   %[0.1 0.15 0.2 0.25 0.3]
        Conectancia = CONECTANCIES
        
        for RICHNESS=RICH    %[20 40 60 80 100]
            Riqueza = RICHNESS
            
            BigMatrix  = load(sprintf('/home/pasqui/6.00.00_G_STUARDO/v11_2015_02_15_ClusterDL/series_varBif0/Matrices/REP_C%s_S%d_CON1_M0_NM0_I30',num2str(CONECTANCIES),RICHNESS));
            
            
            for matrix_aux = matrix
                %% Carga datos iniciales
                matrixx = matrix_aux
                
                MATRIZ = BigMatrix(1+RICHNESS*(matrix_aux-1):RICHNESS*matrix_aux,1:end);  % end-1 matriz normal, grafos dirigidos
                MC     = MATRIZ(:,1:end-1);   % obtengo matriz sin TP
                M      = MC + MC';     % Matriz para calculos con grafos no dirigidos
                TP     = MATRIZ(:,end-1);     % Troffic Position
                xTP    = mean(TP);            % promedio
                xTP_EPD= mean(TP(vEPD));      % TP con EPD. 

                %                 load(sprintf('series/medias_C%3.2f_S%d_R%d.mat',CONECTANCIES,RICHNESS,REPLICA));
                %                 M_peso = xst.XCIN;
                
                % grafo_bin  = biograph(sparse(M),[],'ShowWeights','on');
                %                 grafo_peso = biograph(sparse(M_peso),[],'ShowWeights','on');
                for replica_aux = replica
                %% salva matrices de prueba
                %st_datos = struct('M',M,'M_peso',M_peso,'grafo_bin',grafo_bin,'grafo_peso',grafo_peso);
                st_datos = struct('MC',MC,'M',M,'TP',xTP,'TP_EPD',xTP_EPD,'vEPD',vEPD);
                
                %% Inicializa vectores, por si la generacion es parcializada:
                st_degree                   = NaN;
                st_strength                 = NaN;
                st_jdegree                  = NaN;
                st_edge_nei_overlap         = NaN;
                st_matching_ind             = NaN;
                st_rich_club_coefficient    = NaN;
                st_k_core                   = NaN;
                
                st_density_und              = NaN;
                st_density_dir              = NaN;
                
                st_clustering_coef          = NaN;
                st_transitivity             = NaN;
                st_efficiency               = NaN;
                st_connected_components     = NaN;
                st_modularity_uNewman       = NaN;
                st_modularity_dNewman       = NaN;
                
                st_findwalks                = NaN;
                st_distance                 = NaN;
                st_reachib                  = NaN;
                st_breadth                  = NaN;
                st_efficiency               = NaN;
                st_charpathb                = NaN;
                st_charpathw                = NaN;
                st_cycprob                  = NaN;
                
                st_assortativity            = NaN;
                st_betweenness_cen          = NaN;
                st_edge_betweenness_cen     = NaN;
                st_module_degree_zscore     = NaN;
                st_participation_coef       = NaN;
                st_eigenvector_centrality   = NaN;
                st_subgraph_centrality      = NaN;
                st_kcoreness_centrality     = NaN;
                st_flow_coef_bd             = NaN;
                st_erange                   = NaN;
                
                %% generacion de datos
                % medidas([.1 .15 .2 .25 0.3],[20 40 60 80 100],1:30,[1 2 7 8 9 11 15 17 19 20],[2 5 7 8 11 16 17 19 20])
                
                for index = [1 2 7 8 9 11 15 17 19 20 21] %FUN
                    
                    switch index
                        case 1,
                            %% degree:
                            % Node degree is the number of links connected to the node.
                            % In directed networks, the in-degree is the number of inward
                            % links and the out-degree is the number of outward links.
                            % Connection weights are ignored in calculations.
                            % degrees_und.m (BU, WU networks); degrees_dir.m (BD, WD networks).
                            [grado_id_bd, grado_od_bd, grado_deg_bd] = degrees_dir( MC );
                            grado_bu                                 = degrees_und( M );
                            xgrado_bu                                = mean(grado_bu);
                            grado_bu_epd                             = grado_bu(vEPD);
                            xgrado_bu_epd                            = mean(grado_bu_epd);
                            st_degree = struct('grado_id_bd',grado_id_bd,'grado_od_bd',grado_od_bd,'grado_deg_bd',grado_deg_bd,...
                                'grado_bu',grado_bu,'xgrado_bu',xgrado_bu,'xgrado_bu_epd',xgrado_bu_epd);
                            
                            
                        case 2,
                            %% Assortativity: 
                            % The assortativity coefficient is a correlation coefficient between 
                            % the degrees of all nodes on two opposite ends of a link. A positive
                            % assortativity coefficient indicates that nodes tend to link to other
                            % nodes with the same or similar degree.
                            % assortativity_bin.m (BU, BD networks).
                            % assortativity_wei.m (WU, WD networks).
                            %    Inputs:     CIJ,    binary directed/undirected connection matrix
                            % flag,   0, undirected graph: degree/degree correlation
                            %         1, directed graph: out-degree/in-degree correlation
                            %         2, directed graph: in-degree/out-degree correlation
                            %         3, directed graph: out-degree/out-degree correlation
                            %         4, directed graph: in-degree/in-degree correlation
                            ACbu = assortativity_bin(M, 0);    % grafo no dirigido;
                            ACOcIbd = assortativity_bin(MC, 1);    % grafo dirigido;
                            ACIcObd = assortativity_bin(MC, 2);    % grafo dirigido;
                            ACOcObd = assortativity_bin(MC, 3);    % grafo dirigido;
                            ACIcIbd = assortativity_bin(MC, 4);    % grafo dirigido;
                            
                            st_assortativity = struct ('ACbu',ACbu,'ACOcIbd',ACOcIbd,'ACIcObd',ACIcObd,'ACOcObd',ACOcObd,'ACIcIbd',ACIcIbd);
                            
                        %case 3,
                            %% Joint degree:
                            % This function returns a matrix in which the value of each
                            % element (u,v) corresponds to the number of nodes that have
                            % u outgoing connections and v incoming connections. Connection
                            % weights are ignored. jdegree.m (BD, WD networks).
                        %    [J_bd,J_od_bd,J_id_bd,J_bl_bd] = jdegree( MC );
                        %    st_jdegree = struct ('J_bd',J_bd,'J_od_bd',J_od_bd,'J_id_bd',J_id_bd,'J_bl_bd',J_bl_bd);
                            
                        %case 4,
                            %% Neighborhood overlap:
                            % These functions compute the overlap between the neighborhoods
                            % of pairs of nodes linked by edges.
                            % edge_nei_overlap_bu.m (BU networks); edge_nei_overlap_bd.m (BD networks).
                        %    [EC_bu,ec_bu,degij_bu] = edge_nei_overlap_bu( M );
                        %    [EC_bd,ec_bd,degij_bd] = edge_nei_overlap_bd( MC );
                        %    st_edge_nei_overlap = struct ('EC_bu',EC_bu,'ec_bu',ec_bu,'degij_bu',degij_bu,...
                        %        'EC_bd',EC_bd,'ec_bd',ec_bd,'degij_bd',degij_bd);
                            
                        %case 5,
                            %% Matching index:
                            % The matching index computes for any two nodes u and v, the
                            % amount of overlap in the connection patterns of u and v.
                            % Self-connections and u-v connections are ignored. The matching index
                            % is a symmetric quantity, similar to a correlation or a dot product.
                            % matching_ind_und.m (BU networks); matching_ind.m (BD networks).
                        %    Mbu                   = matching_ind_und( M );
                        %    [Minbd,Moutbd,Mallbd] = matching_ind( MC );
                        %    st_matching_ind = struct ('Mbu',Mbu,'Minbd',Minbd,'Moutbd',Moutbd,'Mallbd',Mallbd);
                            
                        %case 6,
                            %% Density:
                            % Density is the fraction of present connections to possible connections.
                            % Connection weights are ignored in calculations.
                            % density_und.m (BU, WU networks); density_dir.m (BD, WD networks).
                        %    [kdenbu,Nbu,Kbu] = density_und( M );    % BU
                        %    [kdenbd,Nbd,Kbd] = density_dir( MC );   % BD
                            
                        %    st_density_und = struct('kdenbu',kdenbu,'Nbu',Nbu,'Kbu',Kbu);
                        %    st_density_dir = struct('kdenbd',kdenbd,'Nbd',Nbd,'Kbd',Kbd);
                            
                        case 7,
                            %% Clustering coefficient:
                            % The clustering coefficient is the fraction of triangles around a node
                            % and is equivalent to the fraction of node’s neighbors that are neighbors
                            % of each other.
                            % clustering_coef_bu.m (BU networks); clustering_coef_bd.m (BD networks);
                            % clustering_coef_wu.m (WU networks); clustering_coef_wd.m (WD networks).
                            ccbu = clustering_coef_bu( M );
                            xccbu = mean(ccbu);
                            ccbu_epd = ccbu(vEPD);
                            xccbu_epd = mean(ccbu_epd);
                            
                            ccbd = clustering_coef_bd( MC );

%                             ccwu = clustering_coef_wu( M );
%                             ccwd = clustering_coef_wd( MC );
                            st_clustering_coef = struct('ccbu',ccbu,'ccbd',ccbd,'xccbu',xccbu,'xccbu_epd',xccbu_epd); %,'ccwu',ccwu,'ccwd',ccwd);
                            
                        case 8,
                            %% Transitivity:
                            % The transitivity is the ratio of triangles to triplets in the network
                            % and is an alternative to the clustering coefficient.
                            % transitivity_bu.m (BU networks); transitivity_bd.m (BD networks);
                            % transitivity_wu.m (WU networks); transitivity_wd.m (WD networks).
                            Tbu = transitivity_bu( M );
                            Tbd = transitivity_bd( MC );    % el algoritmo solo calcula M+M.'
%                             Twu = transitivity_wu( M );
%                             Twd = transitivity_wd( MC );
                            st_transitivity = struct('Tbu',Tbu,'Tbd',Tbd); %,'Twu',Twu,'Twd',Twd);
                            
                        case 9,
                            %% Local/Global efficiency:
                            % The local efficiency is the global efficiency (see below) computed
                            % on node neighborhoods, and is related to the clustering coefficient.
                            % The global efficiency is the average inverse shortest path length in 
                            % the network, and is inversely related to the characteristic path length.
                            % efficiency_bin.m (BU, BD networks); efficiency_wei.m (WU, WD networks).
                            Eglob_bu     = efficiency_bin( M );     % escalar
                            Eloc_bu      = efficiency_bin( M, 1);    % vector
                            xEloc_bu     = mean(Eloc_bu);
                            Eloc_bu_epd  = Eloc_bu(vEPD);
                            xEloc_bu_epd = mean(Eloc_bu_epd);
                            Eglob_bd = efficiency_bin( MC );     % escalar
                            Eloc_bd  = efficiency_bin( MC, 1);    % vector
                            
                            st_efficiency   = struct('Eglob_bu',Eglob_bu,'Eloc_bu',Eloc_bu,...
                                'Eglob_bd',Eglob_bd,'Eloc_bd',Eloc_bd,'xEloc_bu',xEloc_bu,'xEloc_bu_epd',xEloc_bu_epd); %,...
%                                 'Eglob_wu',Eglob_wu,'Eloc_wu',Eloc_wu,...
%                                 'Eglob_wd',Eglob_wd,'Eloc_wd',Eloc_wd);
                            
                        %case 10,
                            %% Connected components:
                            % Connected components are subnetworks in which all pairs of nodes are
                            % connected by paths.
                            % get_components.m (BU networks).
                        %    [comps_bu, comp_sizes_bu] = get_components( M );
                        %    st_connected_components = struct('comps_bu',comps_bu,'comp_sizes_bu',comp_sizes_bu);
                            
                        case 11,
                            %% Community structure and modularity:
                            % The optimal community structure is a subdivision of the network into
                            % nonoverlapping groups of nodes in a way that maximizes the number of
                            % within-group edges, and minimizes the number of between-group edges.
                            % The modularity is a statistic that quantifies the degree to which the
                            % network may be subdivided into such clearly delineated groups.
                            % modularity_und.m (BU, WU networks): Newman's spectral algorithm.
                            % modularity_dir.m (BD, WD networks): Newman's algorithm for directed networks.
                            % modularity_louvain_und.m (BU, WU networks): Louvain algorithm.
                            % modularity_louvain_dir.m (BD, WD networks): Louvain algorithm for directed networks.
                            % modularity_finetune_und.m (BU, WU networks): fine-tuning algorithm.
                            % modularity_finetune_dir.m (BD, WD networks): fine-tuning algorithm for directed networks.
                            
                            CSbu           = modularity_und( M );      % estructura de comunidad optima
                            CSbu_epd       = CSbu(vEPD);
                            xCSbu          = mean(CSbu);
                            xCSbu_epd      = mean(CSbu_epd);
                            
                            [CSbus Q20bu]  = modularity_und( M, 2);    % detecta modulos pequenos; Qxxbu: modularidad maximizada
                            [CSbub Q05bu]  = modularity_und( M, 0.5);  % detecta modulos grandes
                            [CSbuc Q10bu]  = modularity_und( M, 1);    % funcion clasica de modularidad
                            
                            st_modularity_uNewman        = struct('CSbu',CSbu,'CSbus',CSbus,'Q20bu',Q20bu,...
                                'CSbub',CSbub,'Q05bu',Q05bu,'CSbuc',CSbuc,'Q10bu',Q10bu,'xCSbu',xCSbu,'xCSbu_epd',xCSbu_epd);
                            
                            CSbd           = modularity_dir( MC );      % estructura de comunidad optima
                            [CSbds Q20bd]  = modularity_dir( MC, 2);    % detecta modulos pequenos; Qxxbu: modularidad maximizada
                            [CSbdb Q05bd]  = modularity_dir( MC, 0.5);  % detecta modulos grandes
                            [CSbdc Q10bd]  = modularity_dir( MC, 1);    % funcion clasica de modularidad

                            st_modularity_dNewman        = struct('CSbd',CSbd,'CSbds',CSbds,'Q20bd',Q20bd,...
                                'CSbdb',CSbdb,'Q05bd',Q05bd,'CSbdc',CSbdc,'Q10bd',Q10bd);
%                             
                        %case 12,
                            %% Paths and walks:
                            % Paths are sequences of linked nodes that never visit a single node more than once.
                            % Walks are sequences of linked nodes that may visit a single node more than once.
                            % findpaths.m (BU, BD networks); findwalks.m (BU, BD networks).
                            
                            % descomentar:
                            % source   = ;    % vector con unidades desde donde salen paths
                            % qmax     = 5;
                            % savepths = 1;
                            %[Pq,tpath,plq,qstop,allpths,util] = findpaths( M, sources, qmax, savepths);
                            % comentar si anterior está descomentado:
                            %st_findpaths = struct('Pq',Pq,'tpath',tpath,'plq',plq,'qstop',qstop,'allpths',allpths,'util',util);

                        %    [Wqbd,twalkbd,wlqbd] = findwalks( MC );
                        %    [Wqbu,twalkbu,wlqbu] = findwalks( M );
                            
                        %    st_findwalks = struct('Wqbd',Wqbd,'twalkbd',twalkbd,'wlqbd',wlqbd,...
                        %        'Wqbu',Wqbu,'twalkbu',twalkbu,'wlqbu',wlqbu);
                            
                        %case 13,
                            %% Distance and characteristic path length:
                            % The reachability matrix describes whether pairs of nodes are connected by paths (reachable).
                            % The distance matrix contains lengths of shortest paths between all pairs of nodes. The
                            % characteristic path length is the average shortest path length in the network.
                            % distance_bin.m (BU, BD networks): distance matrix (algebraic algorithm).
                            % reachdist.m (BU, BD networks): reachability and distance matrices (alternative algebraic
                            %                                algorithm -- returns nonzeros on the main diagonal, unlike distance_bin).
                            % breadthdist.m (BD, BU networks): reachability and distance matrices (breadth-first search). This
                            %                                algorithm is slower but less memory-intensive compared to the above.
                            %                                This function requires an auxiliary function breadth.m.
                            % distance_wei.m (WU, WD networks): distance matrix (Dijkstra's algorithm). The input matrix must be a
                            %                                mapping from weight to distance (usually weight inversion).
                        %    Dbu        = distance_bin( M );     % Dbu = matriz de distancias
                        %    Dbd        = distance_bin( MC );
                            
                        %    [Rbu,DRbu] = reachdist( M );   % Rbu = reachability, Dbu = distancia
                        %    [Rbd,DRbd] = reachdist( MC );
                            
                        %    [Bbu,DBbu] = breadthdist( M );
                        %    [Bbd,DBbd] = breadthdist( MC );
                            
                        %    st_distance = struct('Dbu',Dbu,'Dbd',Dbd);
                        %    st_reachib  = struct('Rbu',Rbu,'DRbu',DRbu,'Rbd',Rbd,'DRbd',DRbd);
                        %    st_breadth  = struct('Bbu',Bbu,'DBbu',DBbu,'Bbd',Bbd,'DBbd',DBbd);

                            
                        %case 14,
                            %% No.
                            
                        case 15,
                            %% Characteristic path length, global efficiency, eccentricity, radius, diameter:
                            % The characteristic path length is the average shortest path length in the network. The global
                            % efficiency is the average inverse shortest path length in the network. The node eccentricity is
                            % the maximal shortest path length between a node and any other node. The radius is the minimum
                            % eccentricity and the diameter is the maximum eccentricity.
                            % charpath.m (BU, BD, WU, WD networks).
                            [lambdabu,efficiencybu,eccbu,radiusbu,diameterbu] = charpath( M );
                            [lambdabd,efficiencybd,eccbd,radiusbd,diameterbd] = charpath( MC );

                            st_charpathb = struct('lambdabu',lambdabu,'efficiencybu',efficiencybu,'eccbu',eccbu,'radiusbu',...
                                radiusbu,'diameterbu',diameterbu,...
                                                  'lambdabd',lambdabd,'efficiencybd',efficiencybd,'eccbd',eccbd,'radiusbd',...
                                radiusbd,'diameterbd',diameterbd);
                            
                        %case 16,
                            %% Cycle probability:
                            % Cycles are paths which begin and end at the same node. Cycle probability for path length d,
                            % is the fraction of all paths of length d-1 that may be extended to form cycles of length d.
                            % cycprob.m (BU, BD networks)
                            % descomentar lo que sigue cuando se sepa bien que
                            % significa:
                            %[Wq,twalk,wlq] = findwalks( M ); % es posible que deba ser "findpaths"
                            %[fcyc,pcyc] = cycprob(Wq);
                            %st_cycprob = struct('fcyc',fcyc,'pcyc',pcyc);
                            
                        case 17,
                            %% Betweenness centrality:
                            % Node betweenness centrality is the fraction of all shortest paths in the network that contain
                            % a given node. Nodes with high values of betweenness centrality participate in a large number
                            % of shortest paths.
                            % betweenness_bin.m (BU, BD networks): Kintali's algorithm.
                            % betweenness_wei.m (WU, WD networks): Brandes's algorithm.
                            BCbu      = betweenness_bin( M );
                            xBCbu     = mean(BCbu);
                            BCbu_epd  = BCbu(vEPD);
                            xBCbu_epd = mean(BCbu_epd);
                            BCbd = betweenness_bin( MC );

                            st_betweenness_cen = struct('BCbu',BCbu,'BCbd',BCbd,'xBCbu',xBCbu,'xBCbu_epd',xBCbu_epd);
                            
                        %case 18,
                            %% Edge betweenness centrality:
                            % Edge betweenness centrality is the fraction of all shortest paths in the network that contain
                            % a given edge. Edges with high values of betweenness centrality participate in a large number
                            % of shortest paths.
                            % edge_betweenness_bin.m (BU, BD networks);
                            % edge_betweenness_wei.m (WU, WD networks).
                        %    [EBCbu BCbu] = edge_betweenness_bin( M );
                        %    [EBCbd BCbd] = edge_betweenness_bin( MC );

                        %    st_edge_betweenness_cen = struct('EBCbu',EBCbu,'BCbu',BCbu,'EBCbd',EBCbd,'BCbd',BCbd);
                            
                        case 19,
                            %% Within-module degree z-score:
                            % The within-module degree z-score is a within-module version of degree centrality. This measure
                            % requires a previously determined community structure (see above): modularity_und.
                            % module_degree_zscore.m; (BU, BD, WU, WD networks).
                            Zbu     = module_degree_zscore(M, modularity_und( M ), 0);    % grafo no dirigido = 0
                            xZbu    = mean(Zbu); % salen valores negativos
                            Zbu_epd = Zbu(vEPD);
                            xZbu_epd= mean(Zbu_epd);
                            ZIObd   = module_degree_zscore(MC, modularity_dir( MC, 1), 3);    % grafo dirigido: in-degree, out-degree
                            ZIbd    = module_degree_zscore(MC, modularity_dir( MC, 1), 2);    % grafo dirigido: in-degree
                            ZObd    = module_degree_zscore(MC, modularity_dir( MC, 1), 1);    % grafo dirigido: out-degree
                            %
                            st_module_degree_zscore = struct('Zbu',Zbu,'ZIObd',ZIObd,'ZIbd',ZIbd,'ZObd',ZObd,'xZbu',xZbu,'xZbu_epd',xZbu_epd);
                            
                        case 20,
                            %% Participation coefficient:
                            % Participation coefficient is a measure of diversity of intermodular connections of individual
                            % nodes. This measure requires a previously determined community structure (see above).
                            % participation_coef.m (BU, BD, WU, WD networks).
                            Pbu      = participation_coef(M, modularity_und( M ));
                            xPbu     = mean(Pbu);
                            Pbu_epd  = Pbu(vEPD);
                            xPbu_epd = mean(Pbu_epd);
                            Pbd      = participation_coef(MC, modularity_dir( MC, 1));

                            st_participation_coef = struct('Pbu',Pbu,'Pbd',Pbd,'xPbu',xPbu,'xPbu_epd',xPbu_epd);
                            
                        case 21,
                            %% Eigenvector centrality:
                            % Eigenector centrality is a self-referential measure of centrality -- nodes have high eigenvector
                            % centrality if they connect to other nodes that have high eigenvector centrality.
                            % eigenvector_centrality_und.m (BU, WU networks).
                            vbu      = EigVC(M);   %eigenvector_centrality_und( M );
                            xvbu     = mean(vbu);
                            vbu_epd  = vbu(vEPD);
                            xvbu_epd = mean(vbu_epd); 
                            st_eigenvector_centrality = struct('vbu',vbu,'xvbu',xvbu,'vbu_epd',vbu_epd,'xvbu_epd',xvbu_epd);
                            
                        %case 22,
                            %% Subgraph centrality:
                            % The subgraph centrality of a node is a weighted sum of closed walks of different lengths in the
                            % network starting and ending at the node.
                            % subgraph_centrality.m (BU networks).
                        %    Cs = subgraph_centrality( M );
                        %    st_subgraph_centrality = struct('Cs',Cs);
                            
                        %case 23,
                            %% K-coreness centrality:
                            % The k-core is the largest subgraph comprising nodes of degree at least k. The coreness of a node
                            % is k if the node belongs to the k-core but not to the (k+1)-core.
                            % kcoreness_centrality_bu.m (BU networks);
                            % kcoreness_centrality_bd.m (BD networks).
                        %    [corenessbu,knbu] = kcoreness_centrality_bu( M );
                        %    [corenessbd,knbd] = kcoreness_centrality_bd( MC );
                        %    st_kcoreness_centrality = struct('corenessbu',corenessbu,'knbu',knbu,'corenessbd',corenessbd,'knbd',knbd);
                            
                        %case 24,
                            %% Flow coefficient:
                            % The flow coefficient is similar to betweenness centrality, but computes centrality based on on
                            % local neighborhoods. The flow coefficient is inversely related to the clustering coefficient.
                            % flow_coef_bd.m (BU, BD networks).
                        %    [hcbu,HCbu,total_flobu] = flow_coef_bd( M );    % no dirigido
                        %    [hcbd,HCbd,total_flobd] = flow_coef_bd( MC );   % dirigido
                            
                        %    st_flow_coef_bd = struct('hcbu',hcbu,'HCbu',HCbu,'total_flobu',total_flobu,...
                        %        'hcbd',hcbd,'HCbd',HCbd,'total_flobd',total_flobd);
                        %case 25,
                            %% Shortcuts:
                            % Shorcuts are central edges which significantly reduce the characteristic path length in the network.
                            % erange.m (BD networks).
                        %    [Erange,eta,Eshort,fs] = erange( MC );
                        %    st_erange = struct('Erange',Erange,'eta',eta,'Eshort',Eshort,'fs',fs);
                        %case 26,
                            %% Rich club coefficient: 
                            % The rich club coefficient at level k is the fraction of edges that connect nodes of degree k or higher 
                            % out of the maximum number of edges that such nodes might share.
                            % rich_club_bu.m (BU networks); rich_club_bd.m (BD networks).
                            % rich_club_wu.m (WU networks); rich_club_wd.m (WD networks).
                            % Contributors: MH, OS.
                        %    Rbu = rich_club_bu(M);
                        %    Rbd = rich_club_bd(MC);
                            % cambie el valor de kLevel (es opcional):
                        %    kLevel = 3;
                        %    [Rkbu, Nkbu, Ekbu] = rich_club_bu(M, kLevel);
                        %    [Rkbd, Nkbd, Ekbd] = rich_club_bd(MC, kLevel);
                            
                        %    st_rich_club_coefficient = struct('Rbu',Rbu,'Rkbu',Rkbu,'Nkbu',Nkbu,'Ekbu',Ekbu,'Rbd',Rbd,'Rkbd',Rkbd,'Nkbd',Nkbd,'Ekbd',Ekbd);
                            
                        %case 27,
                            %% K-core: 
                            % The k-core is the largest subnetwork comprising nodes of degree at least k. The k-core is computed 
                            % by recursively peeling off nodes with degree lower than k, until no such nodes remain in the subnetwork.
                            % kcore_bu.m (BU networks); kcore_bd.m (BD networks).
                            % Contributor: OS.
                            % cambie el valor de k: 
                        %    k=5;
                        %    [Mkcorebu,knbu,peelorderbu,peellevelbu] = kcore_bu(M,k);
                        %    [Mkcorebd,knbd,peelorderbd,peellevelbd] = kcore_bd(MC,k);
                            
                        %    st_k_core = struct('Mkcorebu',Mkcorebu,'knbu',knbu,'peelorderbu',peelorderbu,'peellevelbu',peellevelbu,...
                        %                       'Mkcorebd',Mkcorebd,'knbd',knbd,'peelorderbd',peelorderbd,'peellevelbd',peellevelbd);

                    end
                end
                %% guardar replicas en archivo:
                degree_similarity = struct ('st_degree',st_degree,...
                    'st_jdegree',st_jdegree,...
                    'st_edge_nei_overlap',st_edge_nei_overlap,...
                    'st_matching_ind',st_matching_ind);
                
                density = struct ('st_density_und',st_density_und,...
                    'st_density_dir',st_density_dir);
                
                cluster_comm_struct = struct ('st_clustering_coef',st_clustering_coef,...
                    'st_transitivity',st_transitivity,...
                    'st_efficiency',st_efficiency,...
                    'st_connected_components',st_connected_components,...
                    'st_modularity_uNewman',st_modularity_uNewman,...
                    'st_modularity_dNewman',st_modularity_dNewman);
                
                assortativity = struct('st_assortativity', st_assortativity,...
                                       'st_rich_club_coefficient',st_rich_club_coefficient,...
                                       'st_k_core',st_k_core);
                
                path_distances = struct ('st_findwalks',st_findwalks,...
                    'st_distance',st_distance,...
                    'st_reachib',st_reachib,...
                    'st_breadth',st_breadth,...
                    'st_charpathb',st_charpathb,...
                    'st_charpathw',st_charpathw);
                
                centrality = struct ('st_betweenness_cen',st_betweenness_cen,...
                    'st_edge_betweenness_cen',st_edge_betweenness_cen,...
                    'st_module_degree_zscore',st_module_degree_zscore,...
                    'st_participation_coef',st_participation_coef,...
                    'st_eigenvector_centrality',st_eigenvector_centrality,...
                    'st_subgraph_centrality',st_subgraph_centrality,...
                    'st_kcoreness_centrality',st_kcoreness_centrality,...
                    'st_flow_coef_bd',st_flow_coef_bd,...
                    'st_erange',st_erange);
                
                stg_fun = struct('st_datos',st_datos,'degree_similarity',degree_similarity,...
                    'density',density,'assortativity',assortativity,...
                    'cluster_comm_struct',cluster_comm_struct,...
                    'path_distances',path_distances,...
                    'centrality',centrality);
                
                
                save(sprintf('/home/pasqui/6.00.00_G_STUARDO/v11_2015_02_15_ClusterDL/series_varBif0/grafos_RED_TODA/GR_C%3.2f_S%d_matrix%d_r%d.mat',CONECTANCIES,RICHNESS,matrix_aux,replica_aux),'stg_fun');
                end
                end
        end
    end
end

end
