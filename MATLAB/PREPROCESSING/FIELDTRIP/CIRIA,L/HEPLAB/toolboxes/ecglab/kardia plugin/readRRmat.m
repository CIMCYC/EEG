function [intervaloRR,tempoRR,verdadeiros,ebs_indices]=readRRmat(filename)
load(filename)
intervaloRR=diff(round(rr*1000));
tempoRR=[0; cumsum(intervaloRR/1000)];
verdadeiros=1:length(intervaloRR);
ebs_indices=[];
end
