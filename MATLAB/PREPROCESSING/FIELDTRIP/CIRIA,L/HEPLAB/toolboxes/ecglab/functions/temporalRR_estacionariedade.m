function estacionariedade=temporalRR_estacionariedade(intervaloRR)

N=length(intervaloRR);

n1=floor(N/3);
n2=floor(2*N/3);

A=intervaloRR(1:n1);
B=intervaloRR(n1+1:n2);
C=intervaloRR(n2+1:N);

mediaA=mean(A);
mediaB=mean(B);
mediaC=mean(C);

dpA=std(A);
dpB=std(B);
dpC=std(C);

mediaAB=100*abs(mediaA-mediaB)/mean([mediaA mediaB]);
mediaBC=100*abs(mediaB-mediaC)/mean([mediaB mediaC]);
mediaAC=100*abs(mediaA-mediaC)/mean([mediaA mediaC]);

dpAB=100*abs(dpA-dpB)/mean([dpA dpB]);
dpBC=100*abs(dpB-dpC)/mean([dpB dpC]);
dpAC=100*abs(dpA-dpC)/mean([dpA dpC]);

indices=[mediaAB mediaBC mediaAC dpAB dpBC dpAC];

x=mean(indices);
ponderacao=100* (log(1./(x+5))+4.655) /3.045;

estacionariedade=[ponderacao indices];




