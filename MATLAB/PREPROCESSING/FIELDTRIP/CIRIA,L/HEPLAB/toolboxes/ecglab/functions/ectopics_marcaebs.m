function ebs_indices=ectopics_marcaebs(intervaloRR,tempoRR)
%usage: ebs_indices=ectopics_marcaebs(intervaloRR,tempoRR)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%calcula estatistica do sinal RR
%
quartil1=prctile(intervaloRR,25);
quartil3=prctile(intervaloRR,75);
dj=quartil3-quartil1;
Ei=quartil1-3/2*dj;
Es=quartil3+3/2*dj;

%funciona na maioria dos sinais RR
ebs_indices=find(intervaloRR<Ei | intervaloRR>Es);