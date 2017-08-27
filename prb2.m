function prb2(archivo)
% conect, richness, varBif_aux, vv1,vv2,vv3,EPDP,fenoRecA,fenoDormA,TotalMatr,replicas,semilla

fd = fopen(archivo,'r');

tic

while ~feof(fd)

   C = str2num(strtrim(fgets(fd)));
   R = str2num(strtrim(fgets(fd)));
   VB = str2num(strtrim(fgets(fd)));
   VV1 = str2num(strtrim(fgets(fd)));
   VV2 = str2num(strtrim(fgets(fd)));
   VV3 = str2num(strtrim(fgets(fd)));
   EPDP = str2num(strtrim(fgets(fd)));
   FR = str2num(strtrim(fgets(fd)));
   FD = str2num(strtrim(fgets(fd)));
   M = str2num(strtrim(fgets(fd)));
   REP = str2num(strtrim(fgets(fd)));

   disp(sprintf('series_varBif0/s_C%3.2f_S%d_varBif%g_v1%d_v2%d_v3%d_epdp%3.2f_FR%d_FD%d_matrix%d_r%d.mat', C, R, VB, VV1, VV2, VV3, EPDP, FR, FD, M, REP))

   if ~exist(sprintf('series_varBif0/s_C%3.2f_S%d_varBif%g_v1%d_v2%d_v3%d_epdp%3.2f_FR%d_FD%d_matrix%d_r%d.mat', C, R, VB, VV1, VV2, VV3, EPDP, FR, FD, M, REP),'file')

      try
         main(C,R,VB,VV1,VV2,VV3,EPDP,FR,FD,M,REP);
      catch
         main(C,R,VB,VV1,VV2,VV3,EPDP,FR,FD,M,REP);
      end
   end
    
end

TIEMPO = toc

fclose(fd);

end
