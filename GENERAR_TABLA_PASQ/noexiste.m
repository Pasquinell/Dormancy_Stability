function noexiste

fidx = fopen('NoExisteX.txt','w'); %el w es para grabar

for cx= [.15 .25]
for sx = 60
for varBifx = 1
for v1x = [0 1]
for v2x = [2]
for v3x = [1]
for EPDPx = [1]
for FenoRecx = 1:5
for FenoDormx = 1:5
for matrixx = 1:15
for replicax = 1:10
    
  DrFileXx=sprintf('Result_sim/s_C%3.2f_S%d_varBif%g_v1%d_v2%d_v3%d_epdp%3.2f_FR%d_FD%d_matrix%d_r%d.mat',cx,sx,varBifx,v1x,v2x,v3x,EPDPx,FenoRecx,FenoDormx,matrixx, replicax);
  
  if ~exist(DrFileXx,'file')
     
     fprintf(fidx,'%s\n',DrFileXx);
     
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

fclose(fidx);

end