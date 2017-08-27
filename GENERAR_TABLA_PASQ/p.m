function p
fid = fopen('data1.txt','w');
       fprintf(fid,'\"titulo1\", \"titulo2\",\"titulo3\" \n');
       y=[1 2 3; 4 5 6];
        fprintf(fid,'%d,%d,%d\n',y);
        fclose(fid);

end