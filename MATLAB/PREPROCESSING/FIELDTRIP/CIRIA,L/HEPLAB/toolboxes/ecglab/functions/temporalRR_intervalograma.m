function rr_handle=temporalRR_intervalograma(tempoRR,intervaloRR,eventos,abscissa,rr_handle,eixox1,eixox2,eixoy1,eixoy2)
%usage:

corirr='b';
janela_plotagem_irr=[60 275 730 400];

if abscissa=='beat',
   unidade_eixox='intervalos';
   label_eixox='R-R interval number';
   if(isempty(eixox1)), eixox1=1; end,
   if(isempty(eixox2)), eixox2=length(intervaloRR); end,
else
   unidade_eixox='segundos';
   label_eixox='time (seconds)';
   if(isempty(eixox1)), eixox1=min(tempoRR); end,
   if(isempty(eixox2)), eixox2=max(tempoRR); end,
end

%interpola valores de tempo onde ha batimentos ectopicos
trs=find(tempoRR~=0);
if tempoRR(1)==0,trs=[1;trs];end,
tempoRR=spline(trs,tempoRR(trs),1:length(tempoRR));
tempoRR=tempoRR';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555
% plotagem do intervalograma
%

%cria uma espaco para plotagem na janela
if rr_handle~=-1,
   delete(rr_handle);
end

rr_handle=axes('Units','pixels','Position',janela_plotagem_irr);

if abscissa=='time',
   plot(tempoRR,intervaloRR,corirr);
elseif abscissa=='beat',
   plot(intervaloRR,corirr);
else
   plot(tempoRR,intervaloRR,corirr);
   eventos_linhas=line([eventos'; eventos'],[eixoy1*ones(1,length(eventos)); eixoy2*ones(1,length(eventos))]);
   set(eventos_linhas,'Color',[0 .75 0],'LineStyle','-')
end,
axis([eixox1 eixox2 eixoy1 eixoy2]);
title('Intervalogram'),
xlabel(label_eixox),
ylabel('R-R interval (milliseconds)'),
grid,