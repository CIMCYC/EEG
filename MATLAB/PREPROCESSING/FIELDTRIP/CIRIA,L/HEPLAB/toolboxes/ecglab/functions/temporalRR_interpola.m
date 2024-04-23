function [intervaloRR,tempoRR]=temporalRR_interpola(intervaloRR_original,tempoRR_original,ebs_indices)
%usage:

%corrige eixo do tempo
tempoRR=tempoRR_original;
tempoRR(ebs_indices)=0;

%coloca os indices em ordem
ebs_indices=sort(ebs_indices);

%gera um vetor com os indices dos batimentos verdadeiros
verdadeiros=1:length(intervaloRR_original);

%apaga os intervalos marcados, um por um, do ultimo ate o primeiro
for i=length(ebs_indices):-1:1,
   k=ebs_indices(i);
   
   if k==1 & length(verdadeiros)==1,
      verdadeiros=[];
      
   elseif k==1,
      verdadeiros=verdadeiros(2:length(verdadeiros));
      
   elseif k<length(verdadeiros),
      verdadeiros=[verdadeiros(1:k-1) verdadeiros(k+1:length(verdadeiros))];
      
   else
      verdadeiros=verdadeiros(1:k-1);
   end
   
end

eixon=1:length(intervaloRR_original);
intervaloRR=intervaloRR_original(verdadeiros);

%interpola valores nos intervalos removidos
intervaloRR=round(spline(verdadeiros,intervaloRR,eixon))';