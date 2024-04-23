function ebs_indices=ecglabRR_le_ebs(filename,segundos_sinal)

global samplerate_ecg

[k, tempoRR,k,ebs_indices]=le_IRR(filename);
   
tRR_ebs=round(tempoRR(ebs_indices)*1000);

ebs_indices=[];

t=round((0:1/samplerate_ecg:segundos_sinal-1/samplerate_ecg)'*1000);

for k=1:length(tRR_ebs),
   
   ebs_indices=[ebs_indices;find(t==tRR_ebs(k))];
   
end,
