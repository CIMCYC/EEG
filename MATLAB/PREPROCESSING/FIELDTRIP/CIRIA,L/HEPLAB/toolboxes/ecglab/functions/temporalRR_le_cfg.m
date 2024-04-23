function [abscissa,unidade_eixox,eixox1,eixox2,eixoy1,eixoy2,minimox,limitex,outliers]=temporalRR_le_cfg(filename,intervaloRR,tempoRR)

load temporalRR_params.mat;

eixox1 = min(tempoRR);
eixox2 = max(tempoRR);

if abscissa == 'beat',
   unidade_eixox='intervals';
   eixox1 = 1;
   eixox2 = length(intervaloRR);
else
   unidade_eixox='seconds';
   eixox1=floor(min(tempoRR));
   eixox2=ceil(max(tempoRR));   
end
    
minimox=eixox1;
limitex=eixox2;

