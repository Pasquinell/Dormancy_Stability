function tcomp(logfileA, logfileB)

msdiff = sprintf('diff %s %s > logs/diff.txt',logfileA, logfileB);


if exist('logs/diff.txt','file')==0
    status=sprintf('ATENCION: no fue posible crear el archivo de comparación de LOG.\n')
else
    status=sprintf('COMPARACION efectuada sin problemas en logs/diff.txt\n')
end
