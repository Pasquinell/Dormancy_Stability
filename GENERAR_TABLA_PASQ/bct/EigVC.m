function EVC  =EigVC(a)

% se ingresa una matriz de adyacencia "a"
%ahora la hago simétrica:
%a=a + a';
%ahora calculo

[V,D] = eig(a) ;
[maxValue,index] = max(diag(D));  %# The maximum eigenvalue and its index
maxVector = V(:,index)  ;      %# The associated eigenvector in V
EVC=abs(maxVector);

end
