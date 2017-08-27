0.15,60,1,1,2,1,1,2,5,8,1,22477
0.15,60,1,1,2,1,1,2,5,8,4,74046
0.15,60,1,1,2,1,1,2,5,8,8,1006
0.15,60,1,1,2,1,1,2,5,8,9,16291
0.15,60,1,1,2,1,1,2,5,8,10,15414

tic
%% main(0.25,60,1,1,2,1,1,5,4,15,9,4519)  % no ejecuta por IF en main varbif=1 & fenoRec=5 y FenoDorm=4

%% OK: 6.133 mins.
%% main(0.25,60,1,1,2,1,1,5,1,15,1,91892)    % esta combinación no esta validada para break.

%% Error using horzcat
%% Out of memory. Type HELP MEMORY for your options
%% main(0.25,60,1,0,2,1,1,2,5,15,10,54482)      % FR=2, FD=5 = 
%% OK: 5.25 mins, sin extinción
%% main(0.25,60,1,0,2,1,1,2,5,15,10,1408)          % FR=2, FD=5 ; cambio de semilla 

try
   tic
   main(0.15,60,1,1,2,1,1,2,5,8,4,74046);
catch
   tic
   main(0.15,60,1,1,2,1,1,2,5,8,4,1408);
   TIEMPO_SUB = toc
end

TIEMPO = toc
