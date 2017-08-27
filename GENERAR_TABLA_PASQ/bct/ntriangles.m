function N=ntriangles(A)

S=A+A.';                       % symmetrized input graph
M=sparse(S);
n=size(A,1);
N=zeros(n,1);

for i=1:n
    sum=0;
    for j=1:n-1
        if j==i
            continue;
        end    
        h=j+1;
        sum=sum+(M(i,j)*M(i,h)*M(j,h));
    end
    N(i,:)=sum;
end
end