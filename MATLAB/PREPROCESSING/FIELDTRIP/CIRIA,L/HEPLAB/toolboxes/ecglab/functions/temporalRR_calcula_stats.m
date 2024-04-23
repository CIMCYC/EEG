function [totaldeamostras,media,mediana,desviopadrao,minimo,...
      maximo,quartil1,quartil3,pnn50,rmssd,coefvar,faixadinamica]=temporalRR_calcula_stats(intervaloRR)
% usage:[totaldeamostras,amostras,media,mediana,desviopadrao,...
%        minimo,maximo,quartil1,quartil3,pnn50,rmssd,coefvar,faixadinamica]=calcula_stats(intervaloRR);

totaldeamostras=length(intervaloRR);
media=mean(intervaloRR);
mediana=median(intervaloRR);
desviopadrao=sqrt(var(intervaloRR));
minimo=min(intervaloRR);
maximo=max(intervaloRR);
quartil1=prctile(intervaloRR,25);
quartil3=prctile(intervaloRR,75);

% pNN50: é a percentagem das diferencas absolutas entre
% batimentos normais sucessivos que excedem 50ms.
diferencas=abs( intervaloRR(2:length(intervaloRR))  -  intervaloRR(1:length(intervaloRR)-1)  );
pnn50=100*length(find(diferencas>50))/length(diferencas);

%RMSSD: é uma medida da variação das mudancas na duracao
%do intervalo R-R de um batimento pro outro.
%sqrt(sum((x(n+1)-x(n))^2)/(N-1))  (ver spacelabs pg98)
%somatorio de 1 a N-1
rmssd=sqrt(sum(diferencas.^2)/length(diferencas));

coefvar=100*desviopadrao/media;
faixadinamica=maximo-minimo;
