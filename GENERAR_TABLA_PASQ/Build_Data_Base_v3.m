function  Build_Data_Base_v3( )

Table = [] ;
i = 0 ;


%% crea encabezado de archivo:
fid = fopen('ResultTable7.txt','w'); %el w es para grabar
%se setea la primera linea
   fprintf(fid,'\"cconect\", \"richness\",\"varBif\",\"min_wp\",\"razon_tc\",\"latencia\",\"epdp\",\"fenoRec\",\"fenoDorm\",\"matrix\",\"replica\",'); %nombres de todas las variables de  input main
   fprintf(fid,'\"deg\", \"deg_epd\",\"assor\",\"clCoef\",\"clCoef_epd\",\"transitivity\",\"globalEff\",\"localEff\",\"localEff_epd\",\"modularity\",\"modularity_epd\",');
   fprintf(fid,'\"charPathLength\", \"betwc\",\"betwc_epd\",\"moduleZScore\",\"moduleZScore_epd\",\"participCoeff\",\"participCoeff_epd\",');
   fprintf(fid,'\"EigenVecCen\",\"EigenVecCenEPD\",\"TrofPos\",\"TrofPos_epd\",\"PercentEPD\",\"Persistence\"\n');
fclose(fid);

fid2 = fopen('NoExiste5.txt','w');
fclose(fid2);

fid4 = fopen('NoExisteX7.txt','w');
fclose(fid4);

fid3 = fopen('archivosX7.txt','w');
fclose(fid3);


%% Proceso

for s = 20%[20 40 60 80 ]
    for c= .2%[.10 .15 .20 .25 .30]
        for varBif = 0
            for v1 = 0%[0 1] 
                for v2 = 2
                    for v3 = 1%[ 1 2]
                        for EPDP = .5%[0 .25 .50 .75 1 ]
                            for FenoRec = 2%[1 2]
                                for FenoDorm = 2%[1 2 ]
                                    for matrix = 1%1:15
                                        for replica = 1 
                                            
                                            % verificar si el archivo existe:
                                            DrFileX=sprintf('C:\Users\pasquinell\Documents\MATLAB\6.00.00_STUARDO_C\v12\v12.01\t1\series\s_C%3.2f_S%d_varBif%g_v1%d_v2%d_v3%d_epdp%3.2f_FR%d_FD%d_matrix%d_r%d.mat',c,s,varBif,v1,v2,v3,EPDP,FenoRec,FenoDorm,matrix, replica)
                                            
                                            %if ~exist(DrFileX,'file')
%                                                NoExiste = [ c s varBif v1 v2 v3 EPDP FenoRec FenoDorm matrix replica ];
%                                                fid = fopen('NoExisteX5.txt','a'); %el w es para grabar
%                                                fprintf(fid,'%s\n',DrFileX);
%                                                fclose(fid);
%                                                fid = fopen('NoExiste5.txt','a'); %el w es para grabar
%                                                fprintf(fid,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f\n',NoExiste');
%                                                fclose(fid);
                                                
                                            %else
					    if exist(DrFileX,'file') 
                                                
                                               
						try

                                                i=i+1 ;

                                                % carga:
                                                load(DrFileX);

                                                % salva el nombre del archivo poara logearlo poxteriormente:
                                                fid = fopen('C:\Users\pasquinell\Documents\MATLAB\6.00.00_STUARDO_C\v12\v12.01\t1\series\archivosX7.txt','a');
                                                fprintf(fid,'%s\n',DrFileX);
                                                fclose(fid);
                                                
try
                                                %medidasEPD(c, s, matrix,replica, 0, ST.EPD_identity) %medidasEPD(CONectancia, RICHness, REPlica, FUN (funcion del daniel, dejar en 0 siempre), vEPD = vector de epd
                                                window = floor(2*52.18) ;
                                                vi=Variables_intermedias( ST.to_plotAdutls(:,end-window:end), ...
                                                    ST.to_plotConsume.Consume_In_mat(:,:,end-window:end),...
                                                    ST.to_plotConsume.Consume_Out_mat(:,:,end-window:end) ) 
catch
     disp('ERROR en medidasEPD!!');
end
                                
try                
                                                %recolecta(c,s,matrix,replica)
catch
   disp ('ERROR en RECOLECTA!');
end                                                
                                                load(sprintf('C:\Users\pasquinell\Documents\MATLAB\6.00.00_STUARDO_C\v12\v12.01\t1\series\Data_ofMatrix\DoM_C%3.2f_S%d_matrix%d_r%d.mat',c,s,matrix,replica)) ;
                                                
                                                persistencia    = (ST.input_main(2)-size(ST.Extinct,1))/ST.input_main(2) ;
                                                
                                                input_main      = ST.input_main';
                                                pEPD = size(ST.EPD_identity,1)/ST.input_main(2);
                                                
                                                Table           = [Table ;
                                                    input_main Data pEPD persistencia ] ;
                                                
                                                if i == 5
                                                    fid = fopen('C:\Users\pasquinell\Documents\MATLAB\6.00.00_STUARDO_C\v12\v12.01\t1\series\ResultTable7.txt','a'); %el w es para grabar
                                                    fprintf(fid,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f\n',Table');
                                                    fclose(fid);
                                                    i=0;
                                                    Table = [] ;
                                                end
                                                
                                                catch
                                                    fid = fopen('C:\Users\pasquinell\Documents\MATLAB\6.00.00_STUARDO_C\v12\v12.01\t1\series\archivosX7.txt','a');
                                                    fprintf(fid,'LOAD_ERROR: %s\n',DrFileX);
                                                    fclose(fid);
                                                end  
                                            else
                                                disp('no existe!')
                                            end
                                            
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    
    if size(Table,1)>0
        fid = fopen('C:\Users\pasquinell\Documents\MATLAB\6.00.00_STUARDO_C\v12\v12.01\t1\series\ResultTable7.txt','a'); %el w es para grabar
        fprintf(fid,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f\n',Table');
        fclose(fid);
    end
    
end


end % fin de programa
