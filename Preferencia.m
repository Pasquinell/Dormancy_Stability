function Omega=Preferencia(A)
S         = size(A,1);
Omega     = zeros(S,1);
s         = sum(A);
nb        = find(s>0);
Omega(nb) = 1./s(nb);
end