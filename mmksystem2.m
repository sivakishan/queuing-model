clc
clear all
lambda=[15,22,28];
mu=[60/8,60/8,60/8];%60 because is the number of minutes in one hour
for i=1:3 
    M=zeros(28);
    M(1,1)=-lambda(i);
    M(1,2)=mu(i);
    M(2,1)=lambda(i);
    M(2,2)=-(lambda(i)+mu(i));
    M(2,3)=2*mu(i);
    for j=3:27
        M(j,j-1)=lambda(i);
        M(j,j)=-(lambda(i)+2*mu(i));
        M(j,j+1)=2*mu(i); 
    end
    M(28,27)=lambda(i);
    M(28,28)=-2*mu(i);
    M(28,:)=ones(1,28);
    B=[zeros(27,1);1];
    S=linsolve(M,B);
    cis=[0;cumsum(ones(27,1))];
    lq=[0;0;cumsum(ones(26,1))];
    wq=1/2/mu(i)*sum(lq.*S);
    w=wq+1/mu(i);
    sr=sum([0;mu(i);2*mu(i)*ones(26,1)].*S)*10;
    fprintf('departured %f\n',sr)
    fprintf('waiting in queue %f\n',wq)
    fprintf('spent in system %f\n',w)
    fprintf('probability that server 1 and server 2 are not free %f\n',w/2)
    
end
%%%%%%%%%%%%
