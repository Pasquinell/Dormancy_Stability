function prb1(archivo)
% conect, richness, varBif_aux, vv1,vv2,vv3,EPDP,fenoRecA,fenoDormA,TotalMatr,replicas,semilla

fd = fopen(archivo,'r');

while ~feof(fd)

   % fs='%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f\n';
    
   % A = fscanf(fd,fs);
   
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
   SEM = str2num(strtrim(fgets(fd)));
    tic
%        C=A(1,1);
%        R=A(2,1);
%        VB=A(3,1);
% 	VV1=A(4,1);
% 	VV2=A(5,1);
% 	VV3=A(6,1);
% 	EPDP=A(7,1);
% 	FR=A(8,1);
% 	FD=A(9,1);
% 	M=A(10,1);
% 	REP=A(11,1);
% 	SEM=A(12,1);
   try
        main(C,R,VB,VV1,VV2,VV3,EPDP,FR,FD,M,REP,SEM);
   catch
        tic
        main(C,R,VB,VV1,VV2,VV3,EPDP,FR,FD,M,REP,1408);
        TIEMPO_SUB = toc
   end

    TIEMPO = toc
    
end

fclose(fd);

end
