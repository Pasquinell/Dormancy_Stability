function main(conect, richness, varBif_aux, vv1,vv2,vv3,EPDP,fenoRecA,fenoDormA,TotalMatr,replicas,semilla) 

% arguments= 0.15 40 1 0 2 1 1 1 3 15 5


%conect
%richness
%varBif_aux
%vv1
%vv2
%vv3 
%EPDP % porcentaje de epd [0,.25,.5,.75,1]
%fenoRecA
%fenoDormA
%semilla

%% NOTAS GENERALES

global v1 v2 v3 fenoRec fenoDorm replicas_aux
 v1         = vv1; %min winter punishment [0,1]
 v2         = vv2 ;%razón de tamaño coorporal [2]
 v3         = vv3 ;%latencia [0,1,2]
 fenoRec    = fenoRecA ;
 fenoDorm   = fenoDormA ;
 replicas_aux   = replicas ;
%% MODIFIQUE bc_seeds y ph_germination

%% DEFINICION DE VARIABLES DEL MODELO

global n_iter varBif M iter_total A AT TP% valores relevantisimos
% Matriz topologica
% n_iter : el tiempo que corre cada simulacion (cuantos años)
% varBif : el vector que dicta el valor de la variable a bifurcar


global initial_conditions  m ubicaBasales ubicaNoBasales ubicaEdadCero EPD_identity


global P PD ET iter  Limit_dormant_age EPD_identity_vec
global L cat_lengths cat_centers N % Globales de vectores de dormantes
% L          : largo de los intervalos de alta calidad
% hires_qty  : largo de los intervalos de edades de alta resolución
% lowres_mul : lo mismo para los de baja resolucion
% cat_lengths: largo de los intervalos de edades
% cat_centers: ubicación de los centros de cada intervalo de edades

global PH


global logfolder handler fff Latencia % folder de archivo log y tamano cat_centers

fff=1;
% deprecated & temporaly disabled
%global hires_qty lowres_mul
%global ubicaVec_Basales ubicaVec_noBasales


%% INICIO DE PROGRAMA

logfolder   = 'logs';

%ET          = .000001;
ET          = .00001;


%% PROPORCION DE ESPECIES QUE PRESENTAN DIAPAUSA
EPD_Proportion = EPDP;



% deprecated & temporaly disabled
%T_limite_simul = 3000 ; %segundos
%LH=[ic1 ic2 ic3 ic4 sigma1 sigma2 eta kappa beta epsilon1 epsilon2 mort g_alpha g_tau min_wp r x y];
%ic1 ic2 ic3 ic4 sigma eta kappa beta epsilon mort g_alpha g_tau min_wp r x y];


%% SETTING: VECTORES DE DORMANTES

iter_total          = 24           ; % CANTIDAD DE AÑOS QUE SE CORE EL MODELO
n_iter              = 52.18*iter_total      ; %Simulation time (multiplies of L)
L                   = 1                     ; %Unit time length (think 1 week)
Max_age             = 3                     ; %Edad máxima del vector de dormanted
Limit_dormant_age   = floor(52.18*Max_age)  ; %Edad máxima del vector de dormantes en semanas
Latencia            = v3*52.18;  % agregado por
% deprecated & temporaly disabled
%hires_qty           = 2                     ; %Hay hires_qty intervalos de longitud L
%lowres_mul          = 4                     ; %Hay intervalos de longitud lowres_mul*L
%[0, ...
%   1:1:hires_qty, ...
%  hires_qty+lowres_mul:lowres_mul:hires_qty+lowres_mul*40]';  %Vector auxiliar de intervalos (desde%el hires_qty en adelnte cuenta de a lowres_mul)


%% LAS SIMULACIONES (FOR DE conectancia, riqueza, bifurcación, replicas)

%% CONECTANCIA Y RIQUEZA

CONECTANCIES    = conect; %[.1 .2];%[.1 .15 .2 .25 .3];
                %1;%[.1 .15 .2 .25 .3];%[ .1 .125 .15 .175 .2 .225 .25 .275 .3 ];
RICHNESS        = richness;%[20 40];%[20 40 60 80 100];  
                %1;%[20 40 60 80 ];%[20 30 40 50 60 70 80 90];

%[handler, logfile] = tron('MAIN');

%profile on

%rand('seed',semilla);


indice_c = 0 ; %indice para ubicar el slot de la matriz Persist mat
for c= CONECTANCIES
    indice_s = 0;
    indice_c = indice_c + 1;

    %%%%% parte del diseño experimental 1,2,3 (varBif0)
    if varBif_aux == 0
        if (fenoRecA == 1) && (fenoDormA == 2)
            break
        end
        if (fenoRecA == 2) && (fenoDormA == 1)
            break
        end
    end
    
    
    %%%%% parte del diseño experimental 4 (varBif0)
    if varBif_aux == 1
        if (fenoRecA == 3) && (fenoDormA == 4)
            break
        end
        if (fenoRecA == 3) && (fenoDormA == 5)
            break
        end
        if (fenoRecA == 4) && (fenoDormA == 3)
            break
        end
        if (fenoRecA == 4) && (fenoDormA == 5)
            break
        end
        if (fenoRecA == 5) && (fenoDormA == 3)
            break
        end
        if (fenoRecA == 5) && (fenoDormA == 4)
            break
        end
    end
    
    
    for s= RICHNESS
        indice_s = indice_s + 1;
        
        %AHORA VIENE LA CANTIDAD DE REPLICAS:
        for varBif  = varBif_aux %0:.05:1
            %series  = []; % uso en programa Plotseries.m
            %seriesD = []; % uso en programa Plotseries.m
            %varBif

            BigMatrix  = load(sprintf('Matrices/REP_C%s_S%d_CON1_M0_NM0_I100.mat',num2str(c),s))%[0 1 0; 0 0 1];%
            
            for matrix = TotalMatr   %1:TotalMatr %size(LH,1)
%                MATRIX = matrix

            
                %M   =   [0 1 0 0 ; 0 0 1 1; 0 0 0 2];
                %M = [0 0 1 1 0 0;0 0 1 1 0 0;0 0 0 0 1 1; 0 0 0 0 1 1; 0 0 0 0 0 2] 
                
                M   = BigMatrix.REP2(1+s*(matrix-1):s*matrix,:); %cargo matrices con caracteristica s, c y replica.
                TP  = M(:,end) ;%Creo vector de posición trófica (trophic position), que es la ultima columna de M
                A   = M(:,1:end-1) ;
                %view(biograph(A))
                AT  = A' ;
                
                % Carga topologias y posicion trofica de especies.
%                 xfile = sprintf('TOPOS//TOPO-CON-%3.2f-RIQ-%d-REP-%d-M.mat',c,s,replicas);
%                         load(xfile);
%                 xfile = sprintf('TOPOS//TOPO-CON-%3.2f-RIQ-%d-REP-%d-TP.mat',c,s,replicas);
%                         load(xfile);
                
                m     = size(M,1);    % cantidad de especies
                for replica =replicas_aux   %1:replicas_aux
 %                   REPLICA = replica
                    
                    %% PARAMETROS DE ALOMETRIC TROPHIC NETWORK (ATN)
                    
                    %En el orden corespondiente a los INPUTS DE PARAM
                    %G=sensibilidad al contaminante.
                    %Cont=concentración de contaminante en el medio.
                    %A=matriz de adjacencia.
                    %r=razón de tamaño corporal dep-presa.
                    %VBS=variabilidad en los tamaños corporales.
                    %RAND=indica si los tamaños corporales se asignan de forma aleatoria o no
                    %(i.e. de acuerdo a posisicón trófica). (0/1)
                    %FIJO=indica si los tipos metabólicos son fijos o se asignan de acuerdo a las
                    %posiciones tróficas.(0/1)
                    
                    ratio = v2 ; % logaritmo de la razón de tamaño corporal
                    VBS   = 0 ;   % varianza de la razon de tamaño corporal
                    
                    P     = Param(0,0,M(:,1:end-1),ratio,VBS,0,1) ;
                    
                    %% DEFINIR PROPORCIÓN DE ESPECIES QUE PRESENTAN DIAPAUSA (EPD)
                   
%                     EPD_Number     = floor(EPD_Proportion*m); %define la cantida total de las EPD
%                     EPD_aux        = randperm(m); %Aleatorización de el intervalo 1:m
%                     EPD_identity   = EPD_aux(1:EPD_Number); 
                    
%                     if varBif == 0 % CASO OBJETIVO 1,2,3, EN EL QUE SOLO VARIAMOS EL %EPD
%                         EPD_identity_vec = EPD_identity;   %vector para guardar la identidad de las epd
%                     elseif varBif == 1 %CASO OBJETIVO 4 EN QUE %EPD SIEMPRE ES 1 Y VARIAMOS LA PROPORCION DE
                        r_min = .1;
                        r_max = 1;
                        randd = (r_max-r_min).*rand(1,1) + r_min;
                        nRandnumber 	= floor(randd*m);
                        n_aux       	= randperm(m)' ;
                        %EPD_identity_vec = [ 12 6 4 15];%n_aux(1:nRandnumber)    %vector para guardar la identidad de las epd
                        EPD_identity_vec = n_aux(1:nRandnumber) ;   %vector para guardar la identidad de las epd
%                     end
                    EPD_identity = EPD_identity_vec ;
                    %Nota2: La asociación de Diapausa a las especies de la red
                    %esta cercanamente relacionado con el OBJETIVO 3 de la
                    %TESIS de Urbani.
                    
                    
                    %% TIPO DE FENOLOGIAS v1=1 (fvsf), v1=2 (hvsh) etc... (paper 2 especies)
                    
                    %Nota: se ocupó en el bi específico pero en el multi
                    %específico hasta ahora, no hemos considerado variacion de
                    %las fenologías ENTRE especies.
                    
                    
                    %PH = Phenologies(); %Elige que cruza de fenologías vamos a tomar para hacer el experimento
                    % La salida del vector PH es un vector dependiente del
                    % tiempo (ej [f(t) presa; f(t) depredador]
                    % Este vector se necesita en "PD = params_struct()" para
                    % definir las funciones ph_germination = PH{1}  y ph_production  = PH{2}  ;
                    
                    % Opciones
                    % v1 =1 => Cruza f(t) presa vs f(t) depredador
                    % v1 =2 => Cruza h(t) presa vs h(t) depredador
                    % v1 =3 => Cruza f(t) presa vs h(t) presa
                    % v1 =4 => Cruza f(t) depredador vs h(t) depredador
                    % v1 =5 => Cruza f(t) presa vs h(t) depredador
                    % v1 =6 => Cruza f(t) depredador vs h(t) presa
                    
                    %Nota: Esto hasta el momento NO, aplica en TESIS. Dado que,
                    %para el caso de la tesis, las fenologías son todas
                    %iguales.
                    
                    %% UBICACION DE BASALES Y NO BASALES
                    ubicaBasales    = find(TP==0)   ;
                    ubicaNoBasales  = find(TP ~=0)  ;  %Ubica los No basales,
                    %indicando la posición que tienen
                    %en el vector "Y"(vector
                    %de abundancias que
                    %posee las abundancias

                    %de los adultos en los m
                    %primeros slots).
                    %% PARAM_STRUCT (Define un struct con tododos los
                    %parametros que se van a utilizar en lo que queda de código

                    % cambio de semilla de numeros aleatorios:
                    
                    PD       = params_struct();
                    
                    %La salida es la siguiente.
                    %PD = struct( 'eta', eta, 'kappa', kappa,  'mu', mu,  'sigma', sigma, 'beta', beta, 'epsilon', epsilon, 'mort',mort, ...
                    % 'g_zero', g_zero, 'g_inf',g_inf, 'g_alpha',g_alpha, 'g_tau', g_tau, 'Phi_max', Phi_max,  'Phi_min', Phi_min, 'tau_phi',  tau_phi, 'alpha_phi', alpha_phi, ...
                    % 'ph_germination', ph_germination, 'ph_production', ph_production, ... %'DESF', DESF, ...
                    % 'bc_seeds',bc_seeds, 'Crowding', Crowding,'coefB1',coefB1,'coefRF' ,coefRF, 'winter_punish',winter_punish ) ;
                    
                    %% VECTORES DE DORMANTES
                    cat_ends    = [0,1]';             % Vector que indica [inicio; largo del vector de dormantes]
                    N           = size(cat_ends,1);   % Numero de ESTADOS de cada dormante
                    cat_lengths = [ cat_ends(1); cat_ends(2:end) - cat_ends(1:end-1)] ; % Longitud de cada intervalo
                    cat_centers = [0; cat_ends(1:end-1)] + 0.5*cat_lengths   ;          % Centro de cada intervalo
                    % El tamaño de estos vectores va a ir creciendo a medida
                    % que pasan las semanas. Cada semana crece un slot, sin
                    % embargo hasta este momento (03/11/2014) el programa solo
                    % hace que cat_lengths crezca hasta un valor máximo de edad
                    % de los dormantes:  Limit_dormant_age. Esto puede
                    % modifcarse en el futuro
                    
                    
                    %                 treg(handler,0,'catCERNT',cat_centers); % #stuardo
                    %                 treg(handler,0,'catLENGT',cat_lengths); % #stuardo
                    
                    
                    %% CONDICIONES INICIALES
                    
                    initial_conditions   = [zeros(m,1); ... % Activos con valor inicial cero
                        zeros(m*N,1)] ;  % Todos los dormantes con condiciones iniciales cero
                    %Nota: Esta no es la forma mas eficient de guardar las
                    %abundancias de las especies de la red. Dado que igual
                    %guardamos espacios en el la parte de los dormantes del
                    %vector initial_conditions, aunque no los ocupemos. En el
                    %futuro convendría dejar de guardar estos espacios y
                    %mejorar la indexación de las abundancias de los dormantes
                    %en el vector initial conditions. En este caso, crearíamos
                    %un vector initial_conditions de la siguiente manera:_
                    % initial_conditions                = [zeros(m,1); ...
                    %zeros(EPD_Number*N,1)] ;
                    % Ojo que esta nueva indexacion tendría consecuencias
                    % ramificadas sobre todo el programa. Como por ejemplo
                    % rhs.m
                    
                    ubicaEdadCero                     = m+1:N:(m+1+N*(m-1))  ; %Ubica todaslas edades cero de los dormantes.
                    %por esto es que parte en m+1 y avanza de N en N (donde N
                    %es la edad actual de cada estado dormante la última edad
                    
                    aaa = 1:m ; %definicion en funcion de ubicaEdadCero, termina en dos lineas mas su utilidad
                    aaa(EPD_identity_vec) = [] ;
                    
                    ubicaEdadCero(aaa) = [] ; % Solo ubico los de edad cero que tengan dormancia
                    
                    initial_conditions(1:m)           = .1 ;
                    initial_conditions(ubicaEdadCero) = 5 ;% AQUI HAY UN CAMBIO SERIES4.1 ;
                    to_plotAdults                     = initial_conditions(1:m)  ;
                    
                    % Dormantes ordenados en matriz mxN:
                    init                              = reshape(initial_conditions(m+1:end), N, m).' ;
                    
                    
                    to_plotDormants                   = sum(init,2) ; %Condensa la abundancia de todas las edades
                    %de cada dormante
                    
                    %plant_history   = []  ;
                    
                    tic
                    
                    dormantsFull                      = {}; %se ocupa para almacenar los estados dormantes
                    %dormantsFull(1,1:n_iter:m*n_iter)=[ic3 ic4]; %NO REGISTRO
                    %LA PRIMER ABUNDANCIA
                    
                    
                    for iter = 0:n_iter-1
                        %iter/52.18
                        ubicaEdadCero = m+1:N:(m+1+N*(m-1)) ;
                        
                        %<<CHG: pre-dimensionar estos arrays.... ¿Se puede?
                        t_all   = [];  %
                        y_all   = []; 
                        
                        %CONDICIONES INICIALES
                        fin     = 1;
                        tspan   = [0,fin/2,fin];
                        
                        
                        %CONDICIÓN PARA EXTINCIÓN
                        %opts    = odeset('events',@Extintion) ;
                        
                        %% Corrida del ode como tal, despues viene el rearreglo de vectores
                        
                        %while 1
                        %iter
                        options = odeset('NonNegative',1:m);
                            [t,Y] = ode23(@rhs, tspan, initial_conditions,options) ;
                            %[t,Y,tE,initial_conditions,iE] = ode23(@rhs, tspan, initial_conditions, opts ) ;

%                             %plant_history=[plant_history; [Y(1:end-1,1), sum(Y(1:end-1,2:vec_half),2)]];
%                             t_all = [t_all; t];
%                             y_all = [y_all; Y];
%                             
%                             if t(end)==fin
%                                 break
%                             end
%                             initial_conditions      = initial_conditions(end,:);
%                             initial_conditions(iE)  = 0;
%                             tspan                   = [tE(end),tspan(tspan>tE(end))];
%                            
                        %end
                        %%
                        
                        adults               = Y(end, 1:m) ; %reconoce adultos
                        dormants             = Y(end, m+1:end);  %reconoce dormantes
                        
                        dormantsFull{iter+1} =  dormants ;
                     
                        
                        
                        initial_adults       = adults' ; %reconoce a los adultos iniciales de la proxima iteracion
                       
                        dormants_Nxm             = reshape(dormants, N,m).'; 
                        
                        if iter < Limit_dormant_age %Si la iteracion es anterior a Limit_dormant_age entonces va a haber reacomodamiento, sino, se corta la ultima edad de los dormantes y no se reacomodan los cat
                            initial_dormants = cat(2, zeros(m,1), dormants_Nxm );  % concatena en el 2do eje las matrices siguientes
                            cat_ends         = [0 ; cat_ends+L] ;
                            N                = size(cat_ends,1) ;
                            cat_lengths      = [ cat_ends(1); cat_ends(2:end) - cat_ends(1:end-1) ] ;
                            cat_centers      = [0; cat_ends(1:end-1)] + 0.5*cat_lengths ;
                        else
                            initial_dormants = cat(2, zeros(m,1), dormants_Nxm );
                            initial_dormants = initial_dormants(:,1:end-1); %AQUI PIERDE LA INFORMACION DE LOS DORMANTES CON EDAD SOBRE Limit_dormant_age
                        end
                       
                        
                         %% EXTINTION 08 Jun 2015
                        % Nota :  a las variables les pongo el sub indice
                        % _ext para no confundirloas con otras variables
                        % del código
                       a_ext            = sum(initial_dormants,2);
                       aa_ext           = find(a_ext<= ET) ;
                       aa2_ext          = find(initial_adults<= ET)  ;
                       b_ext            = zeros(m,1) ;
                       b2_ext           = zeros(m,1) ;
                       b_ext(aa_ext)        = 1  ;
                       b2_ext(aa2_ext)      = 1  ;
                       c_ext            = b_ext.*b2_ext  ;
                       d_ext            = find(c_ext==1)  ;
                       
                       initial_adults(d_ext) = 0;
                       initial_dormants(d_ext,:) = 0 ;
                       Extinct                 = d_ext ;
                       
                       %% EXTINTION 28 nov 2014 (antiguo que causaba
                       %% problemas)
                        
%                         Extinct=[];
%                         if any(initial_adults(id_adult_alive)<= ET) %primero veo si existe algun adulto menor, que cero, si es asi vale la pena hacer lo que viene
%                             for ii=find(initial_adults<=ET)
%                                 if initial_dormants(ii,:)<=ET
%                                     size(initial_dormants)
%                                     initial_adults(ii)      = 0     ;
%                                     initial_dormants(ii,:)  = 0  ;
%                                     Extinct                 = ii ;
%                                     id_adult_alive =  find(initial_adults>ET) ;
%                                 end
%                             end
%                         end
                        
                        
                        
                        
                        initial_dormants   = reshape(initial_dormants',size(initial_dormants,2)*size(initial_dormants,1) ,1 );
                        %dormantsFull{iter+1} =  initial_dormants;%dormants ;%este array guarda todos los dormantes para despues ocuparlo en GraphBif
                        
                        
                        
                        initial_conditions = [ initial_adults ; initial_dormants ] ;
                        to_plotAdults      = [ to_plotAdults initial_adults ];
                        
                        %PD           = params_struct();
                        % deja size(cat_centers)en variable:
                        
                        scat_centers = size(cat_centers);
                        
                        for i=1:m
                            initial_dormants(1+(i-1)*(scat_centers):i*scat_centers) = ...
                                initial_dormants(1+(i-1)*scat_centers:i*scat_centers);%.* PD.bc_seeds(cat_centers);
                        end
                        
                        init            = reshape(initial_dormants, N, m).';        % DLSS
                        to_plotDormants = [to_plotDormants sum(init,2)] ;
                        
                        tiempo = toc ;
                        
                        
                      
                        
                    end
                   
                    tiempoTotal   = tiempo
                    [to_plotFlujos to_plotConsume] = GraphSeries(n_iter,varBif, to_plotAdults,to_plotDormants, y_all,dormantsFull );
                    
                    
                    
                    ExtinctEPD = intersect(PD.EPD_identity_vec,Extinct)';
                    noEPD= 1:richness ;
                    noEPD(PD.EPD_identity_vec) = [] ;
                    ExtinctNoEPD = intersect(noEPD,Extinct)';
                    
                    
                    TP_epd = TP ;
                    TP_epd(noEPD) = [] ;
                    TP_noepd = TP ;
                    TP_noepd(PD.EPD_identity_vec) = [] ;
                    
                    
                    input_main = [conect, richness, varBif_aux, vv1,vv2,vv3,EPDP,fenoRecA,fenoDormA, matrix,replica]';
                    
                    ST = struct('to_plotAdults',to_plotAdults,'to_plotDormants',to_plotDormants,...
                        'to_plotFlujos',to_plotFlujos,'to_plotConsume',to_plotConsume,...
                        'Extinct', Extinct, 'ExtinctEPD',ExtinctEPD,'ExtinctNoEPD',ExtinctNoEPD, ...
                        'input_main',input_main,...
                        'EPD_identity',PD.EPD_identity_vec,'TP',TP ,'TP_epd',TP_epd,'TP_noepd',TP_noepd,...
                        'tiempo',tiempoTotal);

                    
                    EPD_IDENTITY_VEC = PD.EPD_identity_vec';
                    EXTINCT = Extinct';
                    INPUT_MAIN = input_main'                    
                    
                    %save(sprintf('series_varBif0/s_C%3.2f_S%d_varBif%g_v1%d_v2%d_v3%d_epdp%3.2f_FR%d_FD%d_matrix%d_r%d.mat',c,s,varBif,v1,v2,v3,EPD_Proportion,fenoRecA,fenoDormA,matrix, replica),'ST');
                    save(sprintf('Series/s_C%3.2f_S%d_varBif%g_v1%d_v2%d_v3%d_epdp%3.2f_FR%d_FD%d_matrix%d_r%d.mat',c,s,varBif,v1,v2,v3,EPD_Proportion,fenoRecA,fenoDormA,matrix, replica),'ST');
                    
                    %                 save(sprintf('series/s_C%s_S%d_REP%g_CON1_M0_NM0_I30_r%d_v1v1%d_v2%d_v3%d.mat',num2str(c),s,varBif, replicas,v1,v2,v3),'to_plotDormant%d_v2%d_v3%d.mat',num2str(c),s,varBif, replicas,v1,v2,v3),'to_plotAdults');
                    %                 save(sprintf('series/sD_C%s_S%d_REP%g_CON1_M0_NM0_I30_r%d_s');
                    %                 save(sprintf('series/sF_C%s_S%d_REP%g_CON1_M0_NM0_I30_r%d_v1%d_v2%d_v3%d.mat',num2str(c),s,varBif, replicas,v1,v2,v3),'to_plotFlujos');
                    %                 save(sprintf('series/EPD_identity_save_C%s_S%d_REP%g_CON1_M0_NM0_I30_r%d_v1%d_v2%d_v3%d.mat',num2str(c),s,varBif, replicas,v1,v2,v3),'EPD_identity');
                    %
                    
                    %                 dlmwrite(sprintf('series/s_C%s_S%d_REP%g_CON0_M0_NM0_I30_r%d_v1%d_v2%d_v3%d',num2str(c),s,varBif, replicas,v1,v2,v3),to_plotAdults)
                    %                 dlmwrite(sprintf('series/sD_C%s_S%d_REP%g_CON0_M0_NM0_I30_r%d_v1%d_v2%d_v3%d',num2str(c),s,varBif, replicas,v1,v2,v3),to_plotDormants)
                    %                 dlmwrite(sprintf('series/sF_C%s_S%d_REP%g_CON0_M0_NM0_I30_r%d_v1%d_v2%d_v3%d',num2str(c),s,varBif, replicas,v1,v2,v3),to_plotFlujos)
                    %dlmwrite(sprintf('EPD_identity_save_C%s_S%d_REP%d_CON0_M0_NM0_I30',num2str(c),s,varBif),EPD_identity)
                end
            end
        end


    end
end

clear all;  % se agrega para asegurar proxima ejecucion

%troff(handler);
%profile viewer

end

